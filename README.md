# WSA_SetProxy_and_Other

### 请注意：目前版本大于等于2204.40000.19.0的WSA暂时不能使用此脚本设置代理，脚本中对应的代码仅充当占位，极有可能不起作用！

---

#### 声明：脚本代码均为本人编写，但我并不怎么会写bat，都是网上查的语法现学现用，只能保证正常运行，麻烦各位就不要挑刺了。

### 改脚本可以做的事
1. 让WSA可以通过Windows下的代理软件连接谷歌等网站，只要打开“允许来自局域网的连接”（可能需要加入防火墙白名单），并提供了HTTP端口，即可使用，无视软件。
2. 清除上述的代理设置，恢复正常联网。
3. 修复WSA反复在Windows通知中提示“VirtWifi连接受限”的提示。（修改Captive Portal链接至MIUI服务器，如果有自己想用的服务器可以自己在脚本中修改网址）
4. 暴力修复“VirtWifi连接受限”提示。（彻底关闭Captive Portal功能，可以完全解决问题，但将无法检测实际是否能上网）

### 使用方法
1. 将此脚本放在ADB调试工具（亦称platform-tools）文件夹下并双击执行。（若你已经设置了adb的环境变量，可以放在任意位置执行，具体方法请自行百度）
2. 打开WSA Settings并随便运行一个软件，等待WSA初始化完成。
3. 确保“开发者模式 (Developer Mode)”已打开，在WSA初始化完成后点击下方“IP地址”的“刷新”按钮。
4. 点击“复制”，根据bat中的提示，将其用鼠标右键粘贴到命令行中。注意：请不要使用127.0.0.1。
5. 若需要设置代理，以“V2RayN”软件为例，在配置系统代理、打开“允许来自局域网的连接”后，软件主界面下方会出现Socks5、HTTP和PAC对应的端口或地址，将HTTP的端口输入到命令行中，即可事先WSA过代理软件访问谷歌。
6. 若暂时不需要过代理，请使用脚本中的清除代理功能，否则在不打开代理软件的情况下，将无法正常上网！
7. 本脚本还可以解决“VirtWifi连接受限”提示的问题。

### 其他
使用此脚本强制WSA过代理绝对不是最优解。事实上，使用诸如Clash之类的客户端的TUN模式等灵活性更高，且能够支持代理规则。使用此脚本将会造成所有流量均过代理的问题，因此在暂时无需访问谷歌等时，建议手动清除一遍代理设置。
之所以写这个脚本，只是因为我自己在用V2RayN，暂时不想换Clash（因为我觉得pac.txt真的很好用），哪怕操作麻烦一点也无所谓了。
