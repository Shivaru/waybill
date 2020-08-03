# Окно с предупреждением что программа обновляется


$wshell = New-Object -ComObject Wscript.Shell
$Output = $wshell.Popup("Проверка обновления программы",0,"Waybill")


# Проверка версии

$pathversion = $PSScriptRoot + "/" + "version.txt"
$currentversion = Get-Content -Path $pathversion
$getversion = (Invoke-WebRequest -Uri 'https://raw.github.com/Shivaru/waybill/master/version.txt').content

$urls = 'https://raw.github.com/Shivaru/waybill/master/README.md',
        'https://raw.github.com/Shivaru/waybill/master/design.py',
        'https://raw.github.com/Shivaru/waybill/master/Excel.py',
        'https://raw.github.com/Shivaru/waybill/master/GetDataWialon.py',
        'https://raw.github.com/Shivaru/waybill/master/Window.py',
        'https://raw.github.com/Shivaru/waybill/master/GA4-C.xls',
        'https://raw.github.com/Shivaru/waybill/master/LA.xls',
        'https://raw.github.com/Shivaru/waybill/master/updater.py',
        'https://raw.github.com/Shivaru/waybill/master/main.py',
        'https://raw.github.com/Shivaru/waybill/master/version.txt'

$startpath = $PSScriptRoot + "/" + "version.txt"

$startpath1 = $PSScriptRoot + "/" + "version1.txt"

if ($currentversion -eq $getversion)
{
    $Output = $wshell.Popup("Обновления не требуется",0,"Waybill")        
    & $startpath
}
else 
{
    $Output = $wshell.Popup("Устанавливается обновление, пожалуйста подождите",0,"Waybill")
    
    # Копируем предыдущую версию
   
    $lsdir = ls $PSScriptRoot | where name -Like "version1.txt"     
    if ($lsdir)
    {
        #Write-Host "Копирование не требуется"        
    }
    else 
    {
        #Write-Host "Копируем" 
        Copy-Item -Path $pathversion -Destination $startpath1 -Force        
    }

    
    # Обновление файлов
   
    try
    {
        foreach ($link in $urls)
        {
            $name = $link.split("/")[-1]
            $fullname = $PSScriptRoot + "\" + $name
            $getfile = Invoke-WebRequest $link -outfile “$fullname”
        }      
        $Output = $wshell.Popup("Программа обновлена",0,"Waybill")
        & $startpath
    }
    catch 
    {
        $Output = $wshell.Popup("Программу неудалось обновить, запуск предыдущей версии",0,"Waybill")
        & $startpath1
    }
    
}



