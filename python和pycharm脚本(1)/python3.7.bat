@chcp 65001
@title '闪电软件安装器'
@echo off
mode con lines=20 cols=80
net session >nul 2>&1 && goto :admintasks
MSHTA "javascript: var shell = new ActiveXObject('shell.application'); shell.ShellExecute('%~nx0', '', '', 'runas', 1);close();"
exit /b
:admintasks
reg query "hklm\software\Python\pythoncore\2.7" >nul 2>nul
if %errorlevel% ==0 (
    echo 已存在 Python 2.7 先卸载
    pause
)

reg query "hklm\software\Python\pythoncore\3.5" >nul 2>nul
if %errorlevel% ==0 (
    echo 已存在 Python 3.5 先卸载
    pause
)

reg query "hklm\software\Python\pythoncore\3.6" >nul 2>nul
if %errorlevel% ==0 (
    echo 已存在 Python 3.6 先卸载
    pause
)
reg query "hklm\software\Python\pythoncore\3.7" >nul 2>nul
if %errorlevel% ==0 (
    echo 已存在 Python 3.7 先卸载
    pause
)
reg query "hklm\software\Python\pythoncore\3.8" >nul 2>nul
if %errorlevel% ==0 (
    echo 已存在 Python 3.8 先卸载
    pause
)
reg query "hklm\software\Python\pythoncore\3.9" >nul 2>nul
if %errorlevel% ==0 (
    echo 已存在 Python 3.9 先卸载
    pause
)
reg query "hklm\software\Python\pythoncore\3.10" >nul 2>nul
if %errorlevel% ==0 (
    echo 已存在 Python 3.10 先卸载
    pause
)

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
set pyurl=https://mirrors.huaweicloud.com/python/3.7.9/python-3.7.9-amd64.exe
if not exist aria2c.exe (
    curl -s  %cos%/aria/aria2c.exe -o aria2c.exe
)
aria2c.exe -s16 -x10 --file-allocation=none -d %download% %pyurl%
%download%python-3.7.9-amd64.exe /quiet InstallAllUsers=1 PrependPath=1 Include_test=0 TargetDir=%drive%Python3
aria2c.exe -s16 -x10 --file-allocation=none -d %download% %cos%/py/%drv%/py_desktop.exe
%download%py_desktop.exe
aria2c.exe -s16 -x10 --file-allocation=none -d %download% %cos%/py/pip.exe
%download%pip.exe
del aria2c.exe
del /f /s /q %download%
del %0
