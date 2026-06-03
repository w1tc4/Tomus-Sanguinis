# ─── Custom Workflow Functions & KeyHandlers

# Navigation & File Management Shortcuts
function ll { Get-ChildItem -Force @args } [1]
function la { Get-ChildItem -Force -Hidden @args } [1]
function which { param($cmd) (Get-Command $cmd -ErrorAction SilentlyContinue).Source } [1]
function touch { param($file) New-Item -ItemType File -Path $file -Force | Out-Null } [1]
function mkcd { param($dir) New-Item -ItemType Directory -Path $dir -Force | Out-Null; Set-Location $dir } [1]
function up { param([int]$n = 1) Set-Location (".." + ("\.." * ($n - 1))) } [1]
function home { Set-Location $HOME } [1]

# Environment Configuration Adjustments
function edit-profile { notepad $PROFILE } [1]
function edit-starship { notepad "$env:USERPROFILE\.config\starship.toml" } [1]
function reload { . $PROFILE } [1]
