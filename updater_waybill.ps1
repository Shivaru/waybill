# Окно с предупреждением что программа обновляется

### Создание формы для интерфейса загрузки

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

Function StartProgressBar
{
	if($i -le 5){
	    $pbrTest.Value = $i
	    $script:i += 1
	}
	else {
		$timer.enabled = $false
	}
	
}

$Form                            = New-Object system.Windows.Forms.Form
$Form.ClientSize                 = New-Object System.Drawing.Point(370,142)
$Form.text                       = "Waybill installing"
$Form.TopMost                    = $true

# Init ProgressBar
$pbrTest = New-Object System.Windows.Forms.ProgressBar
$pbrTest.Maximum = 100
$pbrTest.Minimum = 0
$pbrTest.width              = 330
$pbrTest.height             = 26
$pbrTest.Location = New-Object System.Drawing.Point(22,49)

$i = 0
$Form.Controls.Add($pbrTest)

$Label1                          = New-Object system.Windows.Forms.Label
$Label1.text                     = "Нажмите Загрузить и дождитесь запуска программы"
$Label1.AutoSize                 = $true
$Label1.width                    = 150
$Label1.height                   = 10
$Label1.location                 = New-Object System.Drawing.Point(20,21)
$Label1.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',10)


# Button
$btnConfirm = new-object System.Windows.Forms.Button
$btnConfirm.Text = "Загрузить"
$btnConfirm.width                   = 90
$btnConfirm.height                  = 25
$btnConfirm.Location = New-Object System.Drawing.Point(145,92)
$btnConfirm.Font = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Form.Controls.Add($btnConfirm)


$timer = New-Object System.Windows.Forms.Timer 
$timer.Interval = 1000

$timer.add_Tick({
StartProgressBar
})

$timer.Enabled = $true
$timer.Start()


# Кнопка запуска и процесс загрузки

$btnConfirm.Add_Click({
    try
    { 
        foreach ($link in $urls)
        {
            $name = $link.split("/")[-1]
            $fullname = $pathtoinstall + "\" + $name
            $name
            $link
            $fullname 
            #$Output = $wshell.Popup("Загрузка файла $name",2,"Waybill",0)
            $getfile = Invoke-WebRequest $link -outfile “$fullname” 
            #$Output = $wshell.Popup("Загрузка файла $name",2,"Waybill",0)
            $Label1.Text = "Загрузка $i % Пожалуйста подождите"    
            $pbrTest.Value = $i
            Start-Sleep -m 1
            $i += 20
        }
        
        $Label1.Text = "Программа обновлена. Запуск"     
        #$Output = $wshell.Popup("Программа обновлена, Запуск программы",0,"Waybill")
        Start-Sleep 3
        $Form.Close()
        #& $startpath

    }
    catch 
    {
        $Output = $wshell.Popup("Программу неудалось обновить, запуск предыдущей версии",1,"Waybill",0)
        #& $startpath1
    }
})


# Остановка процесса программы если запущен

Stop-Process -Name main -Force -ErrorAction SilentlyContinue


# Запуск обновления уведомление пользователя

$wshell = New-Object -ComObject Wscript.Shell
$Output = $wshell.Popup("Проверка обновления программы",1,"Waybill",0)


# Пути копирования и загрузки


$pathtoinstall = "C:\progra~1\waybill"
mkdir $pathtoinstall -ErrorAction SilentlyContinue


$pathversion = $pathtoinstall + "\" + "version.txt"

$currentversion = Get-Content -Path $pathversion -ErrorAction SilentlyContinue

$getversion = (Invoke-WebRequest -Uri 'https://raw.github.com/Shivaru/waybill/master/version.txt').content

$urls = 'https://raw.github.com/Shivaru/waybill/master/README.md',
        'https://raw.github.com/Shivaru/waybill/master/GetDataWialon.py',
        'https://raw.github.com/Shivaru/waybill/master/GA4-C.xls',
        'https://raw.github.com/Shivaru/waybill/master/LA.xls',
        'https://raw.github.com/Shivaru/waybill/master/main.exe',
        'https://raw.github.com/Shivaru/waybill/master/version.txt'

$startpath = $pathtoinstall + "\" + "main.exe"
$oldname = "main_old"+$currentversion + ".exe"
$startpath1 = $pathtoinstall + "\" + "$oldname"

# Проверка версии


if ($currentversion -eq $getversion)
{
    $Output = $wshell.Popup("Обновления не требуется. Запуск",1,"Waybill",0)        
    #& $startpath
}
else 
{
    $lsdir = ls $pathtoinstall | where name -Like "$oldname"     
    if ($lsdir)
    {
        #$Output = $wshell.Popup("Копирование не требуется",1,"Waybill",0)          
    }
    else 
    {
        #$Output = $wshell.Popup("Копируем",1,"Waybill",0)
        try
        {
            Copy-Item -Path $startpath -Destination $startpath1 -Force -ErrorAction SilentlyContinue
            Start-Sleep 2
        }
        catch 
        {
            $Output = $wshell.Popup("Копирование не получилось",1,"Waybill",0)
        }         
    }
    $Form.controls.AddRange(@($pbrTest,$Label1,$btnConfirm))
    $Form.Add_Shown({$Form.Activate()})
    $Form.ShowDialog()
}


try
{
    & $startpath
}
catch 
{
    try
    {
        & $startpath1
    }
    catch 
    {
        $Output = $wshell.Popup("Запустить программу не удалось!
     Проверьте соединение с интернетом, потом перезапустите программу.
      При повторном возникновении ошибки обратитесь к системному администратору.",10,"Waybill",48)
    }
}


