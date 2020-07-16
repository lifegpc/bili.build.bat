# bili.build.bat
The build bat for [bili](https://github.com/lifegpc/bili).  
[bili](https://github.com/lifegpc/bili)的构建脚本。

# 准备工作

## 复制文件

### 1.克隆仓库
将[bili](https://github.com/lifegpc/bili)克隆到bili文件夹。  
（注：由于并不是空文件夹，你可以先克隆至其他位置，再复制到该文件夹。）

### 2.放置chromedriver等文件
将chromedriver.exe、aria2c.exe、ffmpeg.exe放入bilibin文件夹。  
将linux版chromedriver放入bilibin/linux文件夹。
将mac版chromedriver放入bilibin/mac文件夹。

## 安装依赖软件（以下软件的exe都需要放在PATH指定的目录下）
1.安装Python3。  
2.安装[bili](https://github.com/lifegpc/bili)所需的依赖库和[PyInstaller](https://pypi.org/project/PyInstaller/)。  
3.下载UNIX工具中的cp.exe。  
4.下载[7-zip](https://7-zip.org/)。确保**7z.exe**在PATH指定的目录下。  
5.下载安装[Inno setup5](https://files.jrsoftware.org/is/5/innosetup-5.5.9-unicode.exe)。确保**compil32.exe**在PATH指定的目录下。

# 运行脚本
双击运行**bili/build.bat**即可。
