# ═══════════════════════════════════════════════════════════════════════════
#
#   PowerShell profile  ·  companion to the Reliquary starship prompt
#   Lives at:  $PROFILE
#
#   The portable aesthetic lives in ~/.config/starship.toml and works in
#   every shell. This file is PowerShell-only: starship init, welcome
#   banner, PSReadLine theming, quality-of-life aliases.
#
# ═══════════════════════════════════════════════════════════════════════════


# ─── Starship ─────────────────────────────────────────────────────────────
#   (Usually already loaded by the system profile, but harmless to call
#    again — ensures the prompt always works.)

if (-not $env:STARSHIP_SHELL) {
    Invoke-Expression (&starship init powershell)
}


# ─── Terminal-Icons  ·  glyphs in `ls` output ─────────────────────────────
#   Install once:   Install-Module Terminal-Icons -Scope CurrentUser

if (Get-Module -ListAvailable -Name Terminal-Icons) {
    Import-Module Terminal-Icons
}


# ─── PSReadLine  ·  history predictions, reliquary palette ────────────────

if (Get-Module -ListAvailable -Name PSReadLine) {
    Import-Module PSReadLine

    Set-PSReadLineOption -PredictionSource HistoryAndPlugin
    Set-PSReadLineOption -PredictionViewStyle ListView
    Set-PSReadLineOption -EditMode Windows
    Set-PSReadLineOption -HistorySearchCursorMovesToEnd

    # Colors match starship.toml reliquary palette
    Set-PSReadLineOption -Colors @{
        Command          = '#F0E6D2'   # bone
        Parameter        = '#B08D57'   # gilt
        String           = '#C41E3A'   # blood
        Comment          = '#5C1F29'   # dim blood
        Number           = '#B08D57'   # gilt
        Variable         = '#F0E6D2'   # bone
        Operator         = '#8B6B6B'   # shade
        Type             = '#C41E3A'   # blood
        Keyword          = '#C41E3A'   # blood
        Member           = '#F0E6D2'   # bone
        Selection        = '#3A0F18'   # deep oxblood
        Error            = '#FF3838'   # alert
        InlinePrediction = '#5C1F29'   # dim
    }

    Set-PSReadLineKeyHandler -Key Tab       -Function MenuComplete
    Set-PSReadLineKeyHandler -Key UpArrow   -Function HistorySearchBackward
    Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
    Set-PSReadLineKeyHandler -Key Ctrl+d    -Function DeleteChar
    Set-PSReadLineKeyHandler -Key Ctrl+w    -Function BackwardDeleteWord
}


# ─── Aliases ──────────────────────────────────────────────────────────────

function ll     { Get-ChildItem -Force @args }
function la     { Get-ChildItem -Force -Hidden @args }
function which  { param($cmd) (Get-Command $cmd -ErrorAction SilentlyContinue).Source }
function touch  { param($file) New-Item -ItemType File -Path $file -Force | Out-Null }
function mkcd   { param($dir)  New-Item -ItemType Directory -Path $dir -Force | Out-Null; Set-Location $dir }
function up     { param([int]$n = 1) Set-Location (".." + ("\.." * ($n - 1))) }
function home   { Set-Location $HOME }

function edit-profile  { notepad $PROFILE }
function edit-starship { notepad "$env:USERPROFILE\.config\starship.toml" }
function reload        { . $PROFILE }


# ─── Theme switcher ───────────────────────────────────────────────────────
#   Usage:
#     theme              → list saved themes in ~/.config/starship-presets
#     theme <name>       → activate that preset

function theme {
    param([string]$Name)
    $presetDir = "$env:USERPROFILE\.config\starship-presets"
    $target    = "$env:USERPROFILE\.config\starship.toml"
    if (-not (Test-Path $presetDir)) { Write-Host "No presets folder at $presetDir"; return }
    if (-not $Name) {
        Write-Host "Available themes:"
        Get-ChildItem $presetDir -Filter *.toml | ForEach-Object { Write-Host "  $($_.BaseName)" }
        return
    }
    $source = Join-Path $presetDir "$Name.toml"
    if (Test-Path $source) { Copy-Item $source $target -Force; Write-Host "✟ $Name" }
    else { Write-Host "not found: $Name" }
}


# ═══════════════════════════════════════════════════════════════════════════
#   WELCOME BANNER  ·  ASCII art "RELIQUARY" in blood red
#
#   The art below is the "bloody" figlet font. To swap in something else:
#     1. Visit https://patorjk.com/software/taag
#     2. Generate your text in any font
#     3. Paste it into $banner below (mind the quoting — use @'...'@ here-string)
#     4. Save.
#
#   To DISABLE the banner entirely, comment out the last line:
#      # Show-Banner
# ═══════════════════════════════════════════════════════════════════════════

function Show-Banner {
#    $blood = "`e[38;2;196;30;58m"     # #C41E3A
#    $bone  = "`e[38;2;240;230;210m"   # #F0E6D2
#    $dim   = "`e[38;2;92;31;41m"      # #5C1F29
#    $italic = "`e[3m"
#    $reset  = "`e[0m"
#
    $banner = @'

          ┓                ┓      ┓             ┓              •     
     ┓┏┏┏┓┃┏┏┓┏┳┓┏┓  ╋┏┓  ╋┣┓┏┓  ╋┣┓┏┓┏┓╋┏┓┏┓  ┏┫┏┓┏  ┓┏┏┓┏┳┓┏┓┓┏┓┏┓┏
     ┗┻┛┗ ┗┗┗┛┛┗┗┗   ┗┗┛  ┗┛┗┗   ┗┛┗┗ ┗┻┗┛ ┗   ┗┻┗ ┛  ┗┛┗┻┛┗┗┣┛┗┛ ┗ ┛
                                                             ┛       
'@

    $date = (Get-Date).ToString("dddd · d MMMM yyyy")
#
    Write-Host "$blood$banner$reset"
    Write-Host "$bone$italic                    ✟  $date  ✟$reset"
    Write-Host ""
}

Show-Banner


# ═══════════════════════════════════════════════════════════════════════════
#
#   Other figlet banners to try (replace the $banner here-string above):
#
#   VIGIL (short, 33-wide):

#      ██▒   █▓ ██▓  ▄████  ██▓ ██▓
#     ▓██░   █▒▓██▒ ██▒ ▀█▒▓██▒▓██▒
#      ▓██  █▒░▒██▒▒██░▄▄▄░▒██▒▒██░
#       ▒██ █░░░██░░▓█  ██▓░██░▒██░
#        ▒▀█░  ░██░░▒▓███▀▒░██░░██████▒
#        ░ ▐░  ░▓   ░▒   ▒ ░▓  ░ ▒░▓  ░
#
#   VANITAS (62-wide):
#      ██▒   █▓ ▄▄▄       ███▄    █  ██▓▄▄▄█████▓ ▄▄▄        ██████
#     ▓██░   █▒▒████▄     ██ ▀█   █ ▓██▒▓  ██▒ ▓▒▒████▄    ▒██    ▒
#      ▓██  █▒░▒██  ▀█▄  ▓██  ▀█ ██▒▒██▒▒ ▓██░ ▒░▒██  ▀█▄  ░ ▓██▄
#       ▒██ █░░░██▄▄▄▄██ ▓██▒  ▐▌██▒░██░░ ▓██▓ ░ ░██▄▄▄▄██   ▒   ██▒
#        ▒▀█░   ▓█   ▓██▒▒██░   ▓██░░██░  ▒██▒ ░  ▓█   ▓██▒▒██████▒▒
#        ░ ▐░   ▒▒   ▓▒█░░ ▒░   ▒ ▒ ░▓    ▒ ░░    ▒▒   ▓▒█░▒ ▒▓▒ ▒ ░


#
#   Or visit https://patorjk.com/software/taag and paste anything else in.
#
# ═══════════════════════════════════════════════════════════════════════════

. ([ScriptBlock]::Create((& scoop-search --hook | Out-String)))

Invoke-Expression (& zoxide init powershell | Out-String)

$env:FZF_DEFAULT_OPTS = '--color=bg+:#1a1a1a,bg:#0c0c0c,border:#C41E3A,spinner:#C41E3A,hl:#C41E3A,fg+:#F0E6D2,fg:#a0a0a0,header:#C41E3A,info:#5C1F29,pointer:#C41E3A,marker:#C41E3A,prompt:#C41E3A --border=sharp'
