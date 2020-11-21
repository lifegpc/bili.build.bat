# bili.build.bat
The build bat for [bili](https://github.com/lifegpc/bili).  
[bili](https://github.com/lifegpc/bili)的构建脚本。

# 准备工作

## 复制文件

### 1.克隆仓库
将[bili](https://github.com/lifegpc/bili)克隆到bili文件夹。  
（注：由于并不是空文件夹，你可以先克隆至其他位置，再复制到该文件夹。）

### 2.放置chromedriver等文件
将chromedriver.exe(32bit)、aria2c.exe(64bit)、ffmpeg.exe(64bit)放入```bilibin```文件夹。  
将aria2c.exe(32bit)、ffmpeg(32bit)放入```bilibin/x86```文件夹。  
将linux版chromedriver放入```bilibin/linux```文件夹。
将mac版chromedriver放入```bilibin/mac```文件夹。

### 3.放置python3.8.6 embedded版本
去[这里](https://www.python.org/downloads/release/python-386/)下载```Windows x86-64 embeddable zip file```和```Windows x86 embeddable zip file```，分别解压后放入```bili/python_x64```和```bili/python_x86```  
下面以x86为例来说明接下来的操作（x64同理）：  
1.去[这里](https://bootstrap.pypa.io/get-pip.py)下载```get-pip.py```，然后将文件放入```bili/python_x86```。  
2.在```bili/python_x86```目录执行```python get-pip.py```，执行完后可直接删除```get-pip.py```。  
3.将仓库中```bili/python_x86```内放的两个文件放入```bili/python_x86```文件夹。  
4.将```bili/python_x86/python38.zip```中的```site.pyc```文件夹解压至```bili/python_x86```，并重命名为```sites.pyc```。  
5.在```bili```目录执行```embeddedpython_x86 -pip install --upgrade -r requirements.txt```来安装依赖库。  
6.继续执行```embeddedpython_x86 start.py```，查看是否正常运行。

## 安装依赖软件（以下软件的exe都需要放在PATH指定的目录下）
1.安装Python3。  
2.安装[bili](https://github.com/lifegpc/bili)所需的依赖库和[PyInstaller](https://pypi.org/project/PyInstaller/)。  
3.下载UNIX工具中的cp.exe、rm.exe。  
4.下载[7-zip](https://7-zip.org/)。确保**7z.exe**在PATH指定的目录下。  
5.下载安装[Inno setup5](https://files.jrsoftware.org/is/5/innosetup-5.5.9-unicode.exe)。确保**compil32.exe**在PATH指定的目录下。  
6.下载安装[node.js](https://nodejs.org/)，然后使用npm安装[showdown](https://github.com/showdownjs/showdown)，然后运行```bili/converttohtml.js```完成MARKDOWN转HTML的转换。

# 运行脚本
双击运行**bili/build.bat**即可。
