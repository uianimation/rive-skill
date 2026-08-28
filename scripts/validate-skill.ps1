param(
    [string]$SkillRoot = (Join-Path $PSScriptRoot ".."),
    [switch]$CheckExternalLinks
)

$ErrorActionPreference = "Stop"
$root = (Resolve-Path -LiteralPath $SkillRoot).Path
$skillPath = Join-Path $root "SKILL.md"
$openAiPath = Join-Path $root "agents\openai.yaml"
$portablePath = Join-Path $root "rive-instructions.md"

function Assert-True {
    param([bool]$Condition, [string]$Message)
    if (-not $Condition) {
        throw $Message
    }
}

Assert-True (Test-Path -LiteralPath $skillPath) "SKILL.md is missing."
$skill = Get-Content -Raw -LiteralPath $skillPath
$frontmatterMatch = [regex]::Match($skill, '(?s)^---\r?\n(.*?)\r?\n---')
Assert-True $frontmatterMatch.Success "SKILL.md frontmatter is invalid."

$frontmatter = $frontmatterMatch.Groups[1].Value
$topKeys = [regex]::Matches($frontmatter, '(?m)^([a-zA-Z0-9-]+):') |
    ForEach-Object { $_.Groups[1].Value }
$allowedKeys = @("name", "description", "license", "allowed-tools", "metadata")
$unexpectedKeys = @($topKeys | Where-Object { $_ -notin $allowedKeys })
Assert-True ($unexpectedKeys.Count -eq 0) ("Unexpected frontmatter keys: " + ($unexpectedKeys -join ", "))
Assert-True ($frontmatter -match '(?m)^name:\s+rive\s*$') "Skill name must be 'rive'."
Assert-True ($frontmatter -match '(?m)^description:\s+\S') "Skill description is missing."
Assert-True ($skill -notmatch '(?m)^\s*\[TODO:') "SKILL.md contains an unfinished TODO placeholder."

$relativeLinks = [regex]::Matches($skill, '\]\((references/[^)]+)\)') |
    ForEach-Object { $_.Groups[1].Value } |
    Sort-Object -Unique
Assert-True ($relativeLinks.Count -gt 0) "SKILL.md does not route to references."
foreach ($relativeLink in $relativeLinks) {
    $localPath = Join-Path $root ($relativeLink -replace '/', '\')
    Assert-True (Test-Path -LiteralPath $localPath) "Missing routed reference: $relativeLink"
}

$requiredPaths = @(
    "agents\openai.yaml",
    "assets\rive-skill-icon.svg",
    "evals\behavioral-cases.md",
    "references\runtime-integration-patterns.md",
    "scripts\build-portable.ps1",
    "scripts\validate-skill.ps1"
)
foreach ($relativePath in $requiredPaths) {
    Assert-True (Test-Path -LiteralPath (Join-Path $root $relativePath)) "Missing required file: $relativePath"
}

$openAi = Get-Content -Raw -LiteralPath $openAiPath
Assert-True ($openAi -match '\$rive') 'agents/openai.yaml default_prompt must mention $rive.'
Assert-True ($openAi -match '(?m)^\s*brand_color:\s*"#[0-9A-Fa-f]{6}"') "agents/openai.yaml needs a valid brand_color."
$iconMatches = [regex]::Matches($openAi, '(?m)^\s*icon_(?:small|large):\s*"([^"]+)"')
Assert-True ($iconMatches.Count -eq 2) "agents/openai.yaml must define small and large icons."
foreach ($match in $iconMatches) {
    $iconPath = Join-Path $root ($match.Groups[1].Value -replace '^\./', '' -replace '/', '\')
    Assert-True (Test-Path -LiteralPath $iconPath) "Missing UI icon: $($match.Groups[1].Value)"
}

$evals = Get-Content -Raw -LiteralPath (Join-Path $root "evals\behavioral-cases.md")
foreach ($caseId in 1..8) {
    Assert-True ($evals -match ("(?m)^## Case " + $caseId + "\b")) "Behavioral eval Case $caseId is missing."
}

& (Join-Path $root "scripts\build-portable.ps1") -SkillPath $skillPath -OutputPath $portablePath -Check

if ($CheckExternalLinks) {
    $documents = @($skillPath) + (Get-ChildItem (Join-Path $root "references") -File -Filter "*.md").FullName
    $urls = foreach ($document in $documents) {
        $text = Get-Content -Raw -LiteralPath $document
        [regex]::Matches($text, 'https?://[^\s\)"\x60]+') | ForEach-Object { $_.Value.TrimEnd('.', ',') }
    }

    foreach ($url in ($urls | Sort-Object -Unique)) {
        try {
            Invoke-WebRequest -Uri $url -Method Head -MaximumRedirection 5 -TimeoutSec 20 | Out-Null
        }
        catch {
            try {
                Invoke-WebRequest -Uri $url -Method Get -MaximumRedirection 5 -TimeoutSec 20 | Out-Null
            }
            catch {
                throw "External link check failed: $url"
            }
        }
    }
}

Write-Output "Rive skill validation passed."
