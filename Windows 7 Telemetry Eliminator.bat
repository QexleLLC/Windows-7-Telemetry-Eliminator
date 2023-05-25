echo Removing Telemetry Update 1
rem This update performs diagnostics on the Windows systems that participate in the Windows Customer Experience Improvement Program. The diagnostics evaluate the compatibility status of the Windows ecosystem, and help Microsoft to ensure application and device compatibility for all updates to Windows. There is no GWX or upgrade functionality contained in this update.
start /w wusa.exe /uninstall /kb:2952664 /quiet /norestart

echo Removing Telemetry Update 2
rem This update provides the latest set of definitions for compatibility diagnostics that are performed on the system. The updated definitions help enable Microsoft and its partners to ensure compatibility for all customers who want to install the latest Windows operating system. Installing this update also makes sure that the latest Windows operating system version is correctly offered through Windows Update, based on compatibility results.
start /w wusa.exe /uninstall /kb:3150513 /quiet /norestart

echo Removing Telemetry Update 3
rem This update performs diagnostics in Windows 7 Service Pack 1 (SP1) in order to determine whether performance issues may be encountered when the latest Windows operating system is installed. Telemetry is sent back to Microsoft for those computers that participate in the Windows Customer Experience Improvement Program (CEIP). This update will help Microsoft and its partners deliver better system performance for customers who are seeking to install the latest Windows operating system.
start /w wusa.exe /uninstall /kb:3021917 /quiet /norestart

echo Removing Telemetry Update 4
rem This update has been replaced by the latest update for customer experience and diagnostic telemetry that was first released on June 2, 2015. To get the update, see 3080149 Update for customer experience and diagnostic telemetry.
start /w wusa.exe /uninstall /kb:3022345 /quiet /norestart

echo Removing Telemetry Update 5
rem This article describes an update for Windows 8.1, Windows Server 2012 R2, Windows 7 Service Pack 1 (SP1), and Windows Server 2008 R2 SP1. Before you install this update, check out the Prerequisites section.
start /w wusa.exe /uninstall /kb:3068708 /quiet /norestart

echo Removing Telemetry Update 6
rem This article describes an update for Windows 8.1, Windows Server 2012 R2, Windows 7 Service Pack 1 (SP1), and Windows Server 2008 R2 SP1. Before you install this update, check out the Prerequisites section.
start /w wusa.exe /uninstall /kb:3080149 /quiet /norestart

echo Removing Telemetry Update 7
rem This update adds telemetry data points to Work Folders for Asimov telemetry pipeline in Windows 7 Service Pack 1 (SP1).
start /w wusa.exe /uninstall /kb:3081954 /quiet /norestart

rem UPDATE DOESN'T EXIST ON THE MICROSOFT UPDATE CATALOG ANYMORE
rem echo Removing Telemetry Update 8
rem rem 
rem start /w wusa.exe /uninstall /kb:3015249 /quiet /norestart

rem UPDATE DOESN'T EXIST ON THE MICROSOFT UPDATE CATALOG ANYMORE
rem echo Removing Telemetry Update 9
rem rem 
rem start /w wusa.exe /uninstall /kb:2976987 /quiet /norestart

rem UPDATE DOESN'T EXIST ON THE MICROSOFT UPDATE CATALOG ANYMORE
rem echo Removing Telemetry Update 10
rem rem 
rem start /w wusa.exe /uninstall /kb:3068707 /quiet /norestart

rem UPDATE DOESN'T EXIST ON THE MICROSOFT UPDATE CATALOG ANYMORE
rem echo Removing Diagnostics Update (Can break pirated Windows)
rem rem When this update is installed, it performs a validation process for the copy of Windows that is running on your computer...
rem start /w wusa.exe /uninstall /kb:971033 /quiet /norestart

rem UPDATE DOESN'T EXIST ON THE MICROSOFT UPDATE CATALOG ANYMORE
rem echo 
rem rem 
rem start /w wusa.exe /uninstall /kb:3075249 /quiet /norestart

echo Removing Enabling Windows 10 Upgrade Update
rem This article describes an update that enables you to upgrade your computer from Windows 7 Service Pack 1 (SP1) to a later version of Windows. This update has prerequisites.
start /w wusa.exe /uninstall /kb:2990214 /quiet /norestart

echo Removing Windows 10 Upgrade Notification Update
rem If you have Windows 8.1 or Windows 7 with Service Pack 1 (SP1), the following full-screen notification might appear on your computer:
start /w wusa.exe /uninstall /kb:3173040 /quiet /norestart

echo Removing BitLocker Fix Update
rem Useless update if you don’t use BitLocker
start /w wusa.exe /uninstall /kb:3133977 /quiet /norestart

echo DISABLING TELEMETRY TASKS...
for %%? in (
  "\Microsoft\Windows\Application Experience\AitAgent"
  "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser"
  "\Microsoft\Windows\Application Experience\ProgramDataUpdater"
  "\Microsoft\Windows\Autochk\Proxy"
  "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator"
  "\Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask"
  "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip"
  "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector"
  "\Microsoft\Windows\PI\Sqm-Tasks"
  "\Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem"
  "\Microsoft\Windows\Windows Error Reporting\QueueReporting"
  "\Microsoft\Windows\Maintenance\WinSAT"
  "\Microsoft\Windows\Media Center\ActivateWindowsSearch"
  "\Microsoft\Windows\Media Center\ConfigureInternetTimeService"
  "\Microsoft\Windows\Media Center\DispatchRecoveryTasks"
  "\Microsoft\Windows\Media Center\ehDRMInit"
  "\Microsoft\Windows\Media Center\InstallPlayReady"
  "\Microsoft\Windows\Media Center\mcupdate"
  "\Microsoft\Windows\Media Center\MediaCenterRecoveryTask"
  "\Microsoft\Windows\Media Center\ObjectStoreRecoveryTask"
  "\Microsoft\Windows\Media Center\OCURActivate"
  "\Microsoft\Windows\Media Center\OCURDiscovery"
  "\Microsoft\Windows\Media Center\PBDADiscovery"
  "\Microsoft\Windows\Media Center\PBDADiscoveryW1"
  "\Microsoft\Windows\Media Center\PBDADiscoveryW2"
  "\Microsoft\Windows\Media Center\PvrRecoveryTask"
  "\Microsoft\Windows\Media Center\PvrScheduleTask"
  "\Microsoft\Windows\Media Center\RegisterSearch"
  "\Microsoft\Windows\Media Center\ReindexSearchRoot"
  "\Microsoft\Windows\Media Center\SqlLiteRecoveryTask"
  "\Microsoft\Windows\Media Center\UpdateRecordPath"
) do call:disable_task %%?

echo DISABLING TELEMETRY SERVICES...
for %%? in (
  "Diagtrack"
  "dmwappushservice"
  "WerSvc"
) do call:disable_service %%?

set RegDataCollection="HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection"
reg query !RegDataCollection!>nul 2>&1 & if %errorLevel%==0 (
  reg add !RegDataCollection! /v AllowTelemetry /t REG_DWORD /d 0 /f >nul
)

set RegWindowsReporting="HKEY_CURRENT_USER\Software\Microsoft\Windows\Windows Error Reporting"
reg query !RegWindowsReporting!>nul 2>&1 & if %errorLevel%==0 (
  reg add !RegWindowsReporting! /v Disabled /t REG_DWORD /d 1 /f >nul
)

:disable_task
set task_name=%~1
call:log "Disable task %task_name%"
schtasks /Change /TN "%task_name%" /DISABLE>nul 2>&1
exit /b

:disable_service
set service_name=%~1
set errors_counter=0
call:log "Disable service '%service_name%'"
sc query "%service_name%">nul
if %errorlevel% NEQ 1060 (
  sc config "!service_name!" start= disabled>nul
  if %errorlevel% NEQ 0 set /a errors_counter=errors_counter+1
  sc stop "!service_name!">nul
  if %errorlevel% NEQ 0 set /a errors_counter=errors_counter+1
  if %errors_counter%==0 (
    call:log "Service '!service_name!' disabled successful"
  )
) else set /a errors_counter=errors_counter+1 & call:log "Service '!service_name!' not installed"
exit /b