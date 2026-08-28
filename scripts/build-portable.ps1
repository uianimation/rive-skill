param(
    [string]$SkillPath = (Join-Path $PSScriptRoot "..\SKILL.md"),
    [string]$OutputPath = (Join-Path $PSScriptRoot "..\rive-instructions.md")
)

$content = Get-Content -Raw -LiteralPath $SkillPath
$body = $content -replace '(?s)\A---\r?\n.*?\r?\n---\r?\n+', ''
$preamble = @'
# Rive Expert — Portable AI Instructions

This is the portable version of the Rive skill for AI tools that accept a system prompt or persistent context but do not load Agent Skills. Supporting references are separate files in the repository; include the relevant reference text when the task needs deeper guidance.

Maintained by Praneeth Kawya Thathsara — https://uianimation.com

---

'@

Set-Content -LiteralPath $OutputPath -Value ($preamble + $body) -Encoding utf8NoBOM

