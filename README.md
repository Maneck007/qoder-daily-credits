# Qoder Daily Credits · Windows 安装包

[![Checks](https://github.com/Maneck007/qoder-daily-credits/actions/workflows/checks.yml/badge.svg)](https://github.com/Maneck007/qoder-daily-credits/actions/workflows/checks.yml)

给 [88lin/workbuddy-auto-signin](https://github.com/88lin/workbuddy-auto-signin) 的 Qoder CN 功能补充一套中文安装入口：解压后双击 `install.bat`，检查 Python、安装计划任务并运行离线自检。

领取逻辑和计划任务安装脚本来自上游，本项目的工作是 Windows 打包、安装引导与文档整理。它不是 Qoder 官方工具，也不宣称原创了领取接口或认证实现。

## 给使用者

1. 从 [Releases](https://github.com/Maneck007/qoder-daily-credits/releases) 下载 `qoder-daily-credits-win-v0.1.0.zip`，解压到准备长期保留的目录。
2. 确认 Windows 10/11 上已安装并登录 **Qoder CN 国内版**。
3. 双击 `install.bat`。缺少 Python 时，安装器会尝试通过 winget 安装 Python 3.12；也可提前从 [python.org](https://www.python.org/downloads/) 安装。
4. 检查安装输出与同目录日志。自检失败时按提示处理，任务已注册不代表登录态可用。

安装器会创建或更新当前用户的 `QoderDailyCredits` 计划任务，每天按 UTC+8 的 10:05、11:05、15:05、19:05、23:05 换算到本机时间执行。错过触发点后在系统允许时补跑；任务依赖该用户登录会话，无法在电脑关机或完全退出登录时运行。安装后不要移动目录，移动后需重跑安装器。

服务端活动是否仍开放、额度数额和有效期，以 [Qoder 官方活动说明](https://docs.qoder.cn/events/100credits) 为准。脚本不会为错过的活动窗口补领。

## 手动检查

```powershell
python qoder_signin.py doctor
python qoder_signin.py status
python qoder_signin.py auto --dry-run
```

`doctor` 离线检查，`status` 查询活动，`--dry-run` 不领取。需要立即执行时使用 `python qoder_signin.py auto`。脚本读取运行者本机的登录态；登录过期时需打开 Qoder CN 重新登录，不会自动刷新令牌。

日志默认只记录真领取、异常或错误，已领过或无活动时可能不写日志。要查看每次运行，可设置环境变量 `QODER_SIGNIN_LOG_EMPTY=1`。不要上传登录目录、token 或未检查的日志。

## 卸载

```powershell
Unregister-ScheduledTask -TaskName "QoderDailyCredits" -Confirm:$false
```

确认任务已移除后再删除安装目录。

## 来源与开发

上游快照为 `8c66f4b`；`qoder_signin.py` 与 `install-qoder-windows.ps1` 保持该快照的原始内容，保留作者与 [MIT 声明](LICENSE)。详细对应关系和更新步骤见 [UPSTREAM.md](UPSTREAM.md)。本项目新增内容同样采用 MIT，开发中使用 AI 编程辅助。

```powershell
python -m unittest discover -s tests -v
```

测试来自同一上游快照，使用模拟网络和隔离的计划任务模块；不为测试真实领取积分。活动和客户端私有协议可能随时改变。接口问题优先检查上游修复；本仓库的安装和打包问题请提交 [Issue](https://github.com/Maneck007/qoder-daily-credits/issues)。

维护和贡献流程见 [CONTRIBUTING.md](CONTRIBUTING.md)。
