# 上游对应关系

- 来源：https://github.com/88lin/workbuddy-auto-signin
- 固定提交：`8c66f4b`（完整提交号见仓库内 `upstream.json`）
- 原作者：88lin；许可：MIT。
- 原样收录：`qoder_signin.py`、`install-qoder-windows.ps1`。
- 测试来源：上游 `tests/test_qoder_signin.py` 和 `tests/test_install_qoder_windows.py`。
- 本地新增：`install.bat`、`install-helper.ps1`、中文使用说明和本仓库管理文件。

更新时从上游选定一个提交，将上述脚本和测试一起更新，修改 `upstream.json`，运行测试，然后通过 Pull Request 合并。请勿对本仓库直接执行以替换全部代码为目的的上游 pull；这里是独立的 Windows 分发仓库。

保留上游版权声明。若修改了领取脚本，应在此列明修改点，并在 Issue 中区分上游问题和打包问题。
