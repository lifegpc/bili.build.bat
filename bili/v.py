from os import popen,remove
from re import search,I
from os.path import exists
def crf(fn:str,fd:str,od:str,l:list) :
    if exists(fn) :
        try :
            remove(fn)
        except :
            return -1
    f=open(fn,'w',encoding='utf8')
    v='%s, %s, %s, %s'%(l[1],l[2],l[3],l[4])
    if l[4]>0 :
        z='%s.%s.%s.%s(%s%s)'%(l[1],l[2],l[3],l[4],l[6],l[5])
    else :
        z='%s.%s.%s'%(l[1],l[2],l[3])
        if l[6]!='' :
            z='%s(dirty)'%(z)
    s='''VSVersionInfo(
  ffi=FixedFileInfo(
    filevers=(%s),
    prodvers=(%s),
    mask=0x3f,
    flags=0x0,
    OS=0x40004,
    fileType=0x1,
    subtype=0x0,
    date=(0, 0)
    ),
  kids=[
    StringFileInfo(
      [
      StringTable(
        u'040904B0',
        [StringStruct(u'CompanyName', u'lifegpc'),
        StringStruct(u'FileDescription', u'%s'),
        StringStruct(u'FileVersion', u'%s'),
        StringStruct(u'InternalName', u'%s'),
        StringStruct(u'LegalCopyright', u'Copyright 2019-2020 lifegpc'),
        StringStruct(u'OriginalFilename', u'%s.py'),
        StringStruct(u'ProductName', u'bili'),
        StringStruct(u'ProductVersion', u'%s')])
      ]), 
    VarFileInfo([VarStruct(u'Translation', [1033, 1200])])
  ]
)
'''%(v,v,fd,z,od,od,z)
    f.write(s)
    f.close()
    return 0
def ww(fn:str,l:list) :
    if l[4]>0 :
        v='%s.%s.%s.%s'%(l[1],l[2],l[3],l[4])
        z='%s(%s%s)'%(v,l[6],l[5])
    else :
        z='%s.%s.%s'%(l[1],l[2],l[3])
        v=z
        if l[6]!='' :
            z='%s(dirty)'%(z)
    if exists(fn) :
        try :
            remove(fn)
        except :
            return -1
    f=open(fn,'w',encoding='utf8')
    f.write('#define MyAppVersion "%s"\n'%(v))
    f.write('#define MyAppVername "%s"\n'%(z))
    print(z)
    f.close()
    return 0
def main():
    r=popen('git describe --tags --long --dirty')
    x=r.read()
    r.close()
    x=x.split('\n')[0]
    s=search(r'^v(([0-9]+)\.([0-9]+)\.([0-9]+)(.([0-9]+))?)-([0-9]+)-([0-9A-Z]+)(-dirty)?',x,I)
    if s==None :
        return -1
    s=s.groups()
    l=[]
    l.append(s[0])
    l.append(int(s[1]))
    l.append(int(s[2]))
    l.append(int(s[3]))
    if s[4]:
        l.append(int(s[5])+int(s[6]))
    else :
        l.append(int(s[6]))
    l.append(s[7][1:])
    if s[-1]:
        l.append(s[-1][1:]+",")
    else :
        l.append('')
    if crf('v.txt','从BiliBili下载视频/弹幕','start',l)!=0:
        return -1
    if crf('v2.txt','过滤弹幕','filter',l)!=0:
        return -1
    if crf('v3.txt','设置程序','setsettings',l)!=0:
        return -1
    if ww('../bilibin/v.h',l)!=0:
        return -1
    return 0
if __name__ == "__main__":
    main()
