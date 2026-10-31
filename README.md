# Qoder Daily Credits

**积分领取这件小事，交给后台记着。**

用 Qoder CN 写代码，还要惦记活动 Credits 的领取时段。这个 Windows 小工具会按计划检查可领活动，在登录有效、符合活动条件时自动领取，省去反复打开活动页的操作。

基于 [88lin/workbuddy-auto-signin](https://github.com/88lin/workbuddy-auto-signin) 的开源领取脚本，这里提供中文安装入口和 Windows 打包。**非 Qoder 官方工具。**

**[下载 Windows 安装包](https://github.com/Maneck007/qoder-daily-credits/releases/download/v0.1.0/qoder-daily-credits-win-v0.1.0.zip)** · [安装步骤](#怎么开始) · [常见问题与卸载](docs/USAGE.md) · [反馈问题](https://github.com/Maneck007/qoder-daily-credits/issues)

[![Checks](https://github.com/Maneck007/qoder-daily-credits/actions/workflows/checks.yml/badge.svg)](https://github.com/Maneck007/qoder-daily-credits/actions/workflows/checks.yml)

## 装好以后，少做这些重复操作

| 原本要记着的事 | 交给它来做 |
|---|---|
| 到时间打开活动页 | Windows 计划任务定时检查，每天安排 5 个触发时点 |
| 找到还没领的活动 | 检查活动状态，只处理当前可领项目 |
| 手动复制登录凭据 | 读取本机 Qoder CN 已有登录态，无需把 token 粘贴进配置 |
| 怀疑到底有没有运行 | 提供离线自检、状态查询；实际领取和异常会记录日志 |

电脑需要开机且用户保持登录；登录过期后，仍需你打开 Qoder CN 重新登录。积分数量、有效期和活动是否开放，以[官方活动说明](https://docs.qoder.cn/events/100credits)为准，不承诺每天固定到账，也不能补领错过的窗口。

## 怎么开始

适用：**Windows 10/11 + 已安装并登录的 Qoder CN 国内版**。

1. [下载 Windows zip](https://github.com/Maneck007/qoder-daily-credits/releases/download/v0.1.0/qoder-daily-credits-win-v0.1.0.zip)，解压到准备长期保留的目录。
2. 双击 `install.bat`。安装器会检查 Python、注册计划任务并运行离线自检；缺少 Python 时会尝试通过 winget 安装 Python 3.12。
3. 看一眼安装结果。若有报错，先按提示处理；任务注册成功不等于账号登录有效。

装好后保留这个目录，后台任务需要其中的脚本。无需克隆仓库或自己编写计划任务；已有 Python 时也可直接使用。

首次使用想确认状态？在解压目录打开 PowerShell：

```powershell
python qoder_signin.py doctor
python qoder_signin.py status
python qoder_signin.py auto --dry-run
```

依次检查本机环境、查询活动、预览领取操作；`--dry-run` 不会真正领取。具体触发时间、登录失效、日志位置和卸载命令见[使用说明](docs/USAGE.md)。

## 常见疑问

**关机、退出登录以后还能领吗？** 不能。错过计划触发点后，可在系统允许时补跑，但仍要赶得上活动窗口。

**为什么有时没有新日志？** 默认只记录实际领取、异常或错误；已领过或没有活动时可能保持安静。需要检查时运行上面的状态命令。

**这是领取脚本的原创仓库吗？** 核心领取逻辑和计划任务安装脚本来自 88lin。本仓库专注 Windows 中文打包与安装引导；接口问题可以同时查看[上游仓库](https://github.com/88lin/workbuddy-auto-signin)。

## 来源与参与

本版固定上游快照 `8c66f4b`，完整提交及文件对应关系见 [UPSTREAM.md](UPSTREAM.md)。原脚本保持该快照内容，保留上游 [MIT 版权](LICENSE)；本项目新增内容同样采用 MIT，开发中使用 AI 编程辅助。

安装和打包有问题，欢迎[提 Issue](https://github.com/Maneck007/qoder-daily-credits/issues)；想参与维护，先看[贡献说明](CONTRIBUTING.md)。反馈时请去除 token、登录目录和未脱敏日志。
