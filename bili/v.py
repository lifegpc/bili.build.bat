from os import popen,remove
from re import search,I
from os.path import exists
from lang import getdict
from pkg_resources import resource_filename
def crf(fn:str,od:str,l:list) :
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
    laen = getdict('exeinfo', 'en')
    lazh_CN = getdict('exeinfo', 'zh_CN')
    laja = getdict('exeinfo', 'ja')
    s=f"""VSVersionInfo(
  ffi=FixedFileInfo(
    filevers=({v}),
    prodvers=({v}),
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
        u'080403A8',
        [StringStruct(u'CompanyName', u'lifegpc'),
        StringStruct(u'FileDescription', u'{lazh_CN[od]}'),
        StringStruct(u'FileVersion', u'{z}'),
        StringStruct(u'InternalName', u'{od}'),
        StringStruct(u'LegalCopyright', u'Copyright 2019-2020 lifegpc'),
        StringStruct(u'OriginalFilename', u'{od}.py'),
        StringStruct(u'ProductName', u'bili'),
        StringStruct(u'ProductVersion', u'{z}')])
      ]), 
    VarFileInfo([VarStruct(u'Translation', [0x804, 0x3a8])]),
    StringFileInfo(
      [
      StringTable(
          u'040904E4',
        [StringStruct(u'CompanyName', u'lifegpc'),
        StringStruct(u'FileDescription', u'{laen[od]}'),
        StringStruct(u'FileVersion', u'{z}'),
        StringStruct(u'InternalName', u'{od}'),
        StringStruct(u'LegalCopyright', u'Copyright 2019-2020 lifegpc'),
        StringStruct(u'OriginalFilename', u'{od}.py'),
        StringStruct(u'ProductName', u'bili'),
        StringStruct(u'ProductVersion', u'{z}')])
      ]),
    VarFileInfo([VarStruct(u'Translation', [0x409, 0x4e4])]),
    StringFileInfo(
      [
      StringTable(
          u'041103A4',
        [StringStruct(u'CompanyName', u'lifegpc'),
        StringStruct(u'FileDescription', u'{laja[od]}'),
        StringStruct(u'FileVersion', u'{z}'),
        StringStruct(u'InternalName', u'{od}'),
        StringStruct(u'LegalCopyright', u'Copyright 2019-2020 lifegpc'),
        StringStruct(u'OriginalFilename', u'{od}.py'),
        StringStruct(u'ProductName', u'bili'),
        StringStruct(u'ProductVersion', u'{z}')])
      ]),
    VarFileInfo([VarStruct(u'Translation', [0x411, 0x3a4])])
  ]
)
"""
    f.write(s)
    f.close()
    return 0
def iso639file():
    z = ''
    for n in ['iso-639-3-macrolanguages.tab', 'iso-639-3.tab', 'iso-639-3_Name_Index.tab', 'iso-639-3-macrolanguages.tab', 'iso639-5.tsv', 'iso639-2.tsv', 'iso639-1.tsv']:
        z = z + f' --add-data "{resource_filename("iso639", n)};iso639"'
    return z
def buildstart():
    with open('buildstart.bat', 'w', encoding='utf8') as f:
        f.write('@echo off\n')
        z = 'pyinstaller -F start.py --version-file v.txt --icon icon/favicon.ico' + iso639file()
        f.write(z)
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
    buildstart()
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
    if crf('v.txt', 'start', l) != 0:
        return -1
    if crf('v2.txt', 'filter', l) != 0:
        return -1
    if crf('v3.txt', 'setsettings', l) != 0:
        return -1
    if crf('v4.txt', 'startwebui', l) != 0:
        return -1
    if ww('../bilibin/v.h',l)!=0:
        return -1
    if exists('../bilibin/version.txt'):
        remove('../bilibin/version.txt')
    f = open('../bilibin/version.txt','w',encoding='utf8')
    f.write(x)
    f.close()
    return 0
if __name__ == "__main__":
    main()
