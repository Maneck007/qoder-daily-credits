# Qoder Daily Credits 使用说明

[返回项目首页](../README.md)

## 安装与运行时间

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
