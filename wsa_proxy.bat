@echo off
:initial
cls
echo 在开始操作之前，请确保WSA已运行，WSA Settings界面已出现IP地址
pause

echo 正在检测已连接的设备
adb devices
ping /n 3 127.0.0.1>nul
echo 正在断开所有ADB调试设备
adb disconnect
ping /n 2 127.0.0.1>nul
set /p adbip=请输入当前WSA调试IP地址：
adb connect %adbip%

echo 请确保已出现“connected to”提示
echo 若已出现提示请输入1继续操作
echo 若连接异常，请输入2重试连接
set /p nextstep=
if %nextstep% == 1 goto selectmode
if %nextstep% == 2 goto initial
if %nextstep% neq 1 (
if %nextstep% neq 2 goto :invalid1)

:invalid1
echo 请输入正确的数字！
pause
goto initial

:selectmode
cls
echo 若WSA版本小于等于2204.40000.3.0，希望开启代理，输入1；
echo 若WSA版本大于等于2204.40000.19.0，希望开启代理，输入2；
echo 若需要清除代理设置，输入3（否则在不开启代理软件时，将无法正常上网）；
echo 若需要解决“VirtWifi连接受限”问题，输入4
echo 若需要解决“VirtWifi连接受限”问题（暴力方案），输入5
set /p selection=
if %selection% == 1 goto a11
if %selection% == 2 goto a12
if %selection% == 3 goto clearproxy
if %selection% == 4 goto setcaptive
if %selection% == 5 goto disablecaptive
if "%selection%" neq 1 (
if "%selection%" neq 2 (
if "%selection%" neq 3 (
if "%selection%" neq 4 (
if "%selection%" neq 5 goto :invalid2))))

:a11
cls
set /p port=请输入当前HTTP代理的端口：
adb shell "settings put global http_proxy `ip route list match 0 table all scope global | cut -F3`:%port%"
ping /n 2 127.0.0.1>nul
adb shell settings get global http_proxy

echo 请确保已出现IP地址和代理端口，否则请检查输入内容是否有误
goto :end

:a12
cls
set /p port=请输入当前HTTP代理的端口：
adb -s %adbip% shell "settings put global http_proxy `ip route list match 0 table all scope global | cut -F3`:%port%"
ping /n 2 127.0.0.1>nul
adb shell settings get global http_proxy

echo 请确保已出现IP地址和代理端口，否则请检查输入内容是否有误
goto :end

:clearproxy
cls
echo 即将开始清除代理设置
ping /n 2 127.0.0.1 >nul
echo 正在清除代理设置
adb -s %adbip% shell "settings put global http_proxy :0"
adb -s %adbip% shell "settings get global http_proxy"
echo 请确保已出现“:0”内容，若有，则代表清除成功
goto :end

:setcaptive
cls
echo 即将开始修复“连接受限”提示
ping /n 2 127.0.0.1 >nul
echo 正在修复......
adb shell "settings put global captive_portal_http_url http://connect.rom.miui.com/generate_204"
adb shell "settings put global captive_portal_https_url https://connect.rom.miui.com/generate_204"
adb shell "settings get global captive_portal_http_url"
adb shell "settings get global captive_portal_https_url"
echo 请确保已出现两行generate_204网址，重启WSA后，无法连接的提示即可消失
goto :end

:disablecaptive
cls
echo 即将开始修复“连接受限”提示（暴力方案）
echo 本方案将彻底关闭Captive Portal检测功能
echo 即便主机没有联网，也无法检测并给出任何提示，仅适合基础方案无效的用户
echo 若要继续，请输入1，否则请输入2回到主菜单：
set /p disable=
if %disable% == 1 goto :confirm
if %disable% == 2 goto :selectmode
if "%disable%" neq 1 (
if "%disable%" neq 2 goto :invalid2)

:confirm
echo 正在修复......
adb shell "settings put global captive_portal_mode 0"
adb shell "settings get global captive_portal_mode"

echo 请确保已出现数字0，即代表修复成功，重启WSA后生效
goto :end

:end
echo 若操作正确，请输入1退出
echo 若操作异常，请输入2重试
set /p end=
if %end% == 1 exit
if %end% == 2 goto :selectmode
if %end% neq 1 (
if %end% neq 2 goto :invalid2)

:invalid2
echo 请输入正确的数字！
pause
goto selectmode
