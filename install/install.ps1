param(
  [switch]$Force,
  [switch]$Minimal,
  [switch]$SkipClaudeCheck
)

$CLAUDE_DIR = if ($env:CLAUDE_DIR) { $env:CLAUDE_DIR } else { "$HOME/.claude" }

if (-not $SkipClaudeCheck) {
  try {
    $null = Get-Command claude -ErrorAction Stop
  } catch {
    Write-Error "Claude Code not found. Install it first or use -SkipClaudeCheck"
    exit 1
  }
}

$null = New-Item -ItemType Directory -Force -Path $CLAUDE_DIR

$ADDED = 0
$SKIPPED = 0

function Copy-File {
  param($From, $To)
  if ((Test-Path $To) -and -not $Force) {
    Write-Host "skip $To"
    $SKIPPED++
  } else {
    $null = New-Item -ItemType Directory -Force -Path (Split-Path $To)
    Copy-Item $From $To -Force
    Write-Host "add $To"
    $ADDED++
  }
}

function Copy-Dir {
  param($From, $To)
  $null = New-Item -ItemType Directory -Force -Path $To
  Get-ChildItem $From | Copy-Item -Destination $To -Recurse -Force
  Write-Host "added $To/"
  $ADDED++
}

$ROOT = Split-Path $PSScriptRoot -Parent

Copy-File -From "$ROOT/core/CLAUDE.md" -To "$CLAUDE_DIR/CLAUDE.md"
Copy-File -From "$ROOT/core/hooks/block_dangerous.sh" -To "$CLAUDE_DIR/hooks/block_dangerous.sh"
Copy-File -From "$ROOT/core/hooks/block_secrets.sh" -To "$CLAUDE_DIR/hooks/block_secrets.sh"
Copy-File -From "$ROOT/core/hooks/verify_paths.sh" -To "$CLAUDE_DIR/hooks/verify_paths.sh"
Copy-File -From "$ROOT/core/hooks/loop_prevention.sh" -To "$CLAUDE_DIR/hooks/loop_prevention.sh"
Copy-File -From "$ROOT/core/hooks/auto_format.sh" -To "$CLAUDE_DIR/hooks/auto_format.sh"
Copy-File -From "$ROOT/core/rules/operating-system-policy.md" -To "$CLAUDE_DIR/rules/operating-system-policy.md"
Copy-File -From "$ROOT/core/rules/golden-set.md" -To "$CLAUDE_DIR/rules/golden-set.md"

Get-ChildItem "$ROOT/core/commands" -Filter *.md | ForEach-Object {
  Copy-File -From $_.FullName -To "$CLAUDE_DIR/commands/$($_.Name)"
}

Get-ChildItem "$ROOT/core/skills" -Directory | ForEach-Object {
  Copy-Dir -From $_.FullName -To "$CLAUDE_DIR/skills/$($_.Name)"
}

Get-ChildItem "$ROOT/core/workflows" -Filter *.js | ForEach-Object {
  Copy-File -From $_.FullName -To "$CLAUDE_DIR/workflows/$($_.Name)"
}

if (-not $Minimal) {
  if (Test-Path "$ROOT/templates/settings.template.json") {
    Copy-File -From "$ROOT/templates/settings.template.json" -To "$CLAUDE_DIR/settings.json"
  }
}

Get-ChildItem "$ROOT/install" -Filter *.js | ForEach-Object {
  Copy-File -From $_.FullName -To "$CLAUDE_DIR/scripts/$($_.Name)"
}

Write-Host "Done. Added: $ADDED, Skipped: $SKIPPED"
