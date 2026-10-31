# Qoder Daily Credits

**积分领取这件小事，交给后台记着。**

用 Qoder CN 写代码，活动 Credits 就交给计划任务来照看：到点检查活动，读取本机登录态，符合条件时自动领取。

这是基于 [88lin/workbuddy-auto-signin](https://github.com/88lin/workbuddy-auto-signin) 的**社区 Windows 打包版**，提供中文安装入口和使用说明。

**[下载 Windows 安装包](https://github.com/Maneck007/qoder-daily-credits/releases/download/v0.1.0/qoder-daily-credits-win-v0.1.0.zip)** · [安装步骤](#怎么开始) · [详细用法与卸载](docs/USAGE.md) · [反馈问题](https://github.com/Maneck007/qoder-daily-credits/issues)

[![Checks](https://github.com/Maneck007/qoder-daily-credits/actions/workflows/checks.yml/badge.svg)](https://github.com/Maneck007/qoder-daily-credits/actions/workflows/checks.yml)

## 装好以后，它来记时间

| 要做的事 | 它怎样处理 |
|---|---|
| 按时查看活动 | Windows 计划任务每天安排 5 个触发时点 |
| 选择可领项目 | 检查活动状态，处理当前符合条件的项目 |
| 使用账号登录态 | 读取本机 Qoder CN 客户端已有的登录信息 |
| 查看执行情况 | 提供环境自检、状态查询，记录实际领取和异常 |

任务随 Windows 当前用户会话运行，请保持电脑开机和用户登录。领取额度、有效期和活动窗口以[官方活动说明](https://docs.qoder.cn/events/100credits)为准。

## 怎么开始

适用：**Windows 10/11 + 已安装并登录的 Qoder CN 国内版**。

1. [下载 Windows zip](https://github.com/Maneck007/qoder-daily-credits/releases/download/v0.1.0/qoder-daily-credits-win-v0.1.0.zip)，解压到准备长期保留的目录。
2. 双击 `install.bat`。安装器会检查 Python、注册计划任务并运行离线自检；需要 Python 时会尝试通过 winget 安装 Python 3.12。
3. 按安装结果完成环境检查，保持 Qoder CN 登录状态，后台任务即可按计划执行。

安装目录保存了后台任务使用的脚本；迁移目录后，重新运行安装器即可更新任务位置。

## 随时查看运行情况

在解压目录打开 PowerShell：

```powershell
python qoder_signin.py doctor
python qoder_signin.py status
python qoder_signin.py auto --dry-run
```

三个命令分别用于检查本机环境、查询活动、预览领取操作。详细触发时间、日志设置、登录更新和卸载步骤见[使用说明](docs/USAGE.md)。

## 来源与参与

核心领取逻辑和计划任务安装脚本来自 **88lin**，本仓库负责 Windows 中文打包与安装引导。当前固定上游快照 `8c66f4b`，完整提交及文件对应关系见 [UPSTREAM.md](UPSTREAM.md)。保留上游 [MIT 版权](LICENSE)，本项目新增内容同样采用 MIT，开发中使用 AI 编程辅助。

欢迎通过 [Issues](https://github.com/Maneck007/qoder-daily-credits/issues) 反馈安装体验；参与维护可查看[贡献说明](CONTRIBUTING.md)。
