; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#include "v.h"
#define MyAppName "bili"
#define MyAppPublisher "lifegpc"
#define MyAppURL "https:\\github.com\lifegpc\bili"
#define MyAppExeName "start.exe"

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{9007D20E-3623-49D5-B70D-3538417517DC}
AppName={#MyAppName}
AppVersion={#MyAppVername}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
ArchitecturesAllowed=x64
ArchitecturesInstallIn64BitMode=x64
DefaultDirName={code:GetDefaultInstallRoot}\{#MyAppName}
DefaultGroupName={#MyAppName} x64
DisableProgramGroupPage=yes
LicenseFile=LICENSE
OutputDir=.
OutputBaseFilename=bili_{#MyAppVername}_windows10_x64
Compression=lzma
SolidCompression=yes
VersionInfoVersion={#MyAppVersion}
UninstallDisplayName={#MyAppName}
AppCopyright=Copyright 2019-2020 lifegpc
SetupIconFile=..\bili\icon\favicon.ico
UninstallDisplayIcon=..\bili\icon\favicon.ico

[code]
function GetDefaultInstallRoot(Param: String): String;
begin
    if ((GetWindowsVersion shr 16) >= $0600) then
        Result := ExpandConstant('{userappdata}')
    else  
        Result := ExpandConstant('{pf}');
end;

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: zh_CN; MessagesFile: Languages\ChineseSimplified.isl
Name: zh_TW; MessagesFile: Languages\ChineseTraditional.isl
Name: ja;    MessagesFile: compiler:Languages\Japanese.isl

[CustomMessages]
ViewChangelog=View changelog
zh_CN.ViewChangelog=查看更新日志
zh_TW.ViewChangelog=檢視更新紀錄檔
ja.ViewChangelog=変更ログの表示

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
Name: "quicklaunchicon"; Description: "{cm:CreateQuickLaunchIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked; OnlyBelowVersion: 0,6.1

[Files]
Source: "start.exe"; DestDir: "{app}";
Source: "setsettings.exe"; DestDir: "{app}";
Source: "filter.exe"; DestDir: "{app}";
Source: "startwebui.exe"; DestDir: "{app}";
Source: "aria2c.exe"; DestDir: "{app}";
Source: "chromedriver.exe"; DestDir: "{app}";
Source: "ffmpeg.exe"; DestDir: "{app}";
Source: "LICENSE"; DestDir: "{app}";
Source: "README.html"; DestDir: "{app}"; Flags: isreadme
Source: "easyuse.html"; DestDir: "{app}";
Source: "version.txt"; DestDir: "{app}";
Source: "changelog.txt"; DestDir: "{app}";
Source: "Language\*"; DestDir: "{app}\Language";
Source: "webuihtml\*"; DestDir: "{app}\webuihtml";
Source: "webuihtml\css\*"; DestDir: "{app}\webuihtml\css";
Source: "webuihtml\csso\*"; DestDir: "{app}\webuihtml\csso";
Source: "webuihtml\js\*"; DestDir: "{app}\webuihtml\js";
Source: "webuihtml\jso\*"; DestDir: "{app}\webuihtml\jso";
Source: "webuihtml\json\*"; DestDir: "{app}\webuihtml\json";
Source: "icon\*"; DestDir: "{app}\icon";
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{commonprograms}\{#MyAppName}\bili"; Filename: "{app}\{#MyAppExeName}"
Name: "{commondesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: quicklaunchicon
Name: "{commonprograms}\{#MyAppName}\setsettings"; Filename: "{app}\setsettings.exe"
Name: "{commonprograms}\{#MyAppName}\filter"; Filename: "{app}\filter.exe"
Name: "{commonprograms}\{#MyAppName}\startwebui"; Filename: "{app}\startwebui.exe"

[Run]
Filename: "{app}\setsettings.exe"; Description: "{cm:LaunchProgram,setsettings.exe}"; Flags: nowait postinstall skipifsilent 64bit unchecked
Filename: "{app}\changelog.txt"; Description: "{cm:ViewChangelog}"; Flags: nowait postinstall skipifsilent shellexec

