param(
    [string]$SkillPath = (Join-Path $PSScriptRoot "..\SKILL.md"),
    [string]$OutputPath = (Join-Path $PSScriptRoot "..\rive-instructions.md"),
    [switch]$Check
)

$skillRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
$lf = [string][char]10
$cr = [string][char]13
function ConvertTo-Lf {
    param([string]$Value)
    return $Value.Replace($cr + $lf, $lf).Replace($cr, $lf)
}

$content = ConvertTo-Lf (Get-Content -Raw -LiteralPath $SkillPath)
$body = $content -replace '(?s)\A---\r?\n.*?\r?\n---\r?\n+', ''
$referencePaths = @(
    "references\editor-authoring.md",
    "references\interaction-data.md",
    "references\scripting-ai-mcp.md",
    "references\runtimes-performance-accessibility.md",
    "references\runtime-integration-patterns.md",
    "references\runtime-handoff-checklist.md",
    "references\official-docs-map.md"
)

$preamble = @'
# Rive Expert — Complete Portable AI Instructions

This single-file edition bundles the Rive skill entry point and all task references for AI tools that accept a system prompt or persistent context but do not load Agent Skills. Every reference linked by the entry point is embedded later in this file; treat those paths as section labels and do not attempt to open local files.

Maintained by Praneeth Kawya Thathsara — https://uianimation.com

---

'@

$sections = [System.Collections.Generic.List[string]]::new()
$sections.Add((ConvertTo-Lf $preamble) + $body.TrimEnd())
$separator = ($lf * 2) + "---" + ($lf * 2)

foreach ($relativePath in $referencePaths) {
    $absolutePath = Join-Path $skillRoot $relativePath
    if (-not (Test-Path -LiteralPath $absolutePath)) {
        throw "Missing portable reference: $relativePath"
    }

    $reference = ConvertTo-Lf (Get-Content -Raw -LiteralPath $absolutePath)
    $sections.Add($separator + $reference.Trim())
}

$expected = (($sections -join "") + $lf)

if ($Check) {
    if (-not (Test-Path -LiteralPath $OutputPath)) {
        throw "Portable output is missing: $OutputPath"
    }

    $actual = Get-Content -Raw -LiteralPath $OutputPath
    if ($actual -ne $expected) {
        throw "Portable output is stale. Run scripts/build-portable.ps1."
    }

    Write-Output "Portable instructions are current."
    return
}

Set-Content -LiteralPath $OutputPath -Value $expected -Encoding utf8NoBOM -NoNewline
Write-Output "Built complete portable instructions: $OutputPath"
