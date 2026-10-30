# install-helper.ps1 — Qoder CN 每日 100 Credits 一键安装（给小白用户的图形化引导）
# 由 install.bat 调起；逻辑：查 Python → 缺则 winget 装 → 注册计划任务 → 离线自检

$ErrorActionPreference = "Continue"
$dir = Split-Path -LiteralPath $MyInvocation.MyCommand.Path
Set-Location -LiteralPath $dir

function Find-Python {
    # 返回可用的 python.exe 完整路径；找不到返回 $null。
    # 不依赖当前会话 PATH——winget 刚装完时 PATH 尚未刷新，靠扫常见目录兜底。
    foreach ($c in @("py", "python")) {
        $cmd = Get-Command $c -ErrorAction SilentlyContinue
        if ($cmd) {
            & $cmd.Source --version *> $null
            if ($LASTEXITCODE -eq 0) { return $cmd.Source }
        }
    }
    foreach ($pat in @(
        "C:\Python3*\python.exe",
        "$env:LOCALAPPDATA\Programs\Python\Python3*\python.exe",
        "C:\Program Files\Python3*\python.exe",
        "$env:LOCALAPPDATA\Programs\Python\Launcher\py.exe"
    )) {
        $hit = Get-ChildItem $pat -ErrorAction SilentlyContinue |
               Sort-Object FullName -Descending | Select-Object -First 1
        if ($hit) { return $hit.FullName }
    }
    return $null
}

Write-Host ""
Write-Host "==============================================" -ForegroundColor Cyan
Write-Host "  Qoder CN 每日 100 Credits  一键安装" -ForegroundColor Cyan
Write-Host "==============================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "  前提：已安装 [Qoder CN 国内版] 桌面端并登录过。"
Write-Host ""

# ---- 1. 检查 Python ----
Write-Host "[1/3] 检查 Python ..." -NoNewline
$python = Find-Python
if (-not $python) {
    Write-Host " 未找到" -ForegroundColor Yellow
    Write-Host "      尝试用 winget 自动安装 Python（约 1 分钟，请稍候）..."
    $winget = Get-Command winget -ErrorAction SilentlyContinue
    if ($winget) {
        & $winget.Source install -e --id Python.Python.3.12 `
            --accept-package-agreements --accept-source-agreements
        $python = Find-Python
    }
    if (-not $python) {
        Write-Host ""
        Write-Host "  [X] Python 未就绪。" -ForegroundColor Red
        Write-Host "      正在为你打开 Python 下载页面，安装时一路下一步即可，" -ForegroundColor Yellow
        Write-Host "      装完后重新双击 install.bat。" -ForegroundColor Yellow
        Start-Process "https://www.python.org/downloads/"
        exit 1
    }
}
Write-Host " $python" -ForegroundColor Green

# ---- 2. 注册计划任务 ----
Write-Host "[2/3] 注册每天自动领取的 Windows 计划任务 ..."
& powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $dir "install-qoder-windows.ps1")
if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host "  [X] 计划任务注册失败，请把上方的错误信息截图反馈。" -ForegroundColor Red
    exit 1
}

# ---- 3. 离线自检 ----
Write-Host ""
Write-Host "[3/3] 自检：读取本机 Qoder 登录态（不联网领取）..."
# python 输出是 UTF-8，先切控制台解码再捕获，否则中文 JSON 会乱码。
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$doctorOut = (& $python qoder_signin.py doctor 2>$null) -join ""
$doctorExit = $LASTEXITCODE
$doc = $null
try { $doc = $doctorOut | ConvertFrom-Json } catch { }
if ($doc -and $doc.report) {
    Write-Host ("  自检结果：" + $doc.report)
}

Write-Host ""
if ($doctorExit -eq 0) {
    Write-Host "==============================================" -ForegroundColor Green
    Write-Host "  安装完成！" -ForegroundColor Green
    Write-Host "  上面自检结果为「登录态可读」即一切正常。" -ForegroundColor Green
    Write-Host "  之后每天 10:05 起自动领取，全程静默无窗口；" -ForegroundColor Green
    Write-Host "  运行记录见同目录 qoder_signin.log。" -ForegroundColor Green
    Write-Host "  以后重新登录 Qoder 桌面端也无需重装。" -ForegroundColor Green
    Write-Host "==============================================" -ForegroundColor Green
} else {
    Write-Host "==============================================" -ForegroundColor Yellow
    Write-Host "  计划任务已装好，但自检未通过。" -ForegroundColor Yellow
    Write-Host "  最常见原因：还没安装「Qoder CN 国内版」桌面端，" -ForegroundColor Yellow
    Write-Host "  或装了但没登录过。请先登录一次 Qoder 桌面端，" -ForegroundColor Yellow
    Write-Host "  然后重新双击 install.bat。" -ForegroundColor Yellow
    Write-Host "==============================================" -ForegroundColor Yellow
}
