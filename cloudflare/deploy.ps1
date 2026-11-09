# Publishes the website to Cloudflare (grounddraft.app and www). Run from anywhere:
#   powershell -File cloudflare\deploy.ps1
# It copies the site files into cloudflare\public (left out of git) and deploys the Worker.
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$site = Split-Path -Parent $here
$pub = Join-Path $here 'public'
if (Test-Path $pub) { Remove-Item -Recurse -Force $pub }
New-Item -ItemType Directory $pub | Out-Null
Get-ChildItem $site -Force | Where-Object { $_.Name -notin @('.git', '.github', 'cloudflare', 'CNAME', 'README.md', '.gitignore') } |
  Copy-Item -Destination $pub -Recurse
Push-Location $here
npx.cmd wrangler deploy
Pop-Location
