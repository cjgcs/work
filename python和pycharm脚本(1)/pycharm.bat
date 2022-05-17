@chcp 65001
@title '闪电软件安装器'
@echo off
mode con lines=20 cols=80
net session >nul 2>&1 && goto :admintasks
MSHTA "javascript: var shell = new ActiveXObject('shell.application'); shell.ShellExecute('%~nx0', '', '', 'runas', 1);close();"
exit /b
:admintasks
SET SourceFile=d:\
if exist %SourceFile% (
    SET drv=d
) else (
    SET drv=c
)
SET drive=%drv%:\py\
if not exist %drive% (
    mkdir %drive%
)
SET download=%drive%download\
if not exist %download% (
    mkdir %download%
)
set cos=https://shandian-1251437523.cos.ap-chengdu.myqcloud.com
set pyurl=https://download.jetbrains.com.cn/python/pycharm-professional-2021.2.4.exe
if not exist aria2c.exe (
    curl -s  %cos%/aria/aria2c.exe -o aria2c.exe
)
del /f /s /q %appdata%\JetBrains
aria2c.exe -s16 -x10 --file-allocation=none -d %download% %pyurl%
aria2c.exe -s16 -x10 --file-allocation=none -d %download% %cos%/pyc/silent.config
%download%pycharm-professional-2021.2.4.exe /S /CONFIG=%download%silent.config /D=%drive%Pycharm2021.2.4
aria2c.exe -s16 -x10 --file-allocation=none -d %download% %cos%/pyc/%drv%/JetBrains.exe
%download%JetBrains.exe
aria2c.exe -s16 -x10 --file-allocation=none -d %download% %cos%/pyc/%drv%/pyc.exe
%download%pyc.exe

del aria2c.exe
del /f /s /q %download%
del %0
