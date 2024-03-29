﻿# Окно с предупреждением что программа обновляется

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

$Form0                            = New-Object system.Windows.Forms.Form
$Form0.ClientSize                 = New-Object System.Drawing.Point(262,142)
$Form0.text                       = "Form"
$Form0.TopMost                    = $true

$Label0                          = New-Object system.Windows.Forms.Label
$Label0.text                     = "Проверка обновления программы"
$Label0.AutoSize                 = $true
$Label0.width                    = 25
$Label0.height                   = 10
$Label0.location                 = New-Object System.Drawing.Point(15,57)
$Label0.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Form0.controls.AddRange(@($Label0))

$Form                            = New-Object system.Windows.Forms.Form
$Form.ClientSize                 = New-Object System.Drawing.Point(262,142)
$Form.text                       = "Waybill installing"
$Form.TopMost                    = $true

# Init ProgressBar
$pbrTest = New-Object System.Windows.Forms.ProgressBar
$pbrTest.Maximum = 100
$pbrTest.Minimum = 0
$pbrTest.width              = 222
$pbrTest.height             = 26
$pbrTest.Location = New-Object System.Drawing.Point(22,49)

$i = 0
$Form.Controls.Add($pbrTest)

$Label1                          = New-Object system.Windows.Forms.Label
$Label1.text                     = "Нажми для загрузки"
$Label1.AutoSize                 = $true
$Label1.width                    = 130
$Label1.height                   = 10
$Label1.location                 = New-Object System.Drawing.Point(20,21)
$Label1.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',10)


# Button
$btnConfirm = new-object System.Windows.Forms.Button
$btnConfirm.Text = "Install"
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
            $fullname = $PSScriptRoot + "\" + $name
            $name
            $link
            $fullname 
            #$Output = $wshell.Popup("Загрузка файла $name",2,"Waybill",0)
            $getfile = Invoke-WebRequest $link -outfile “$fullname” 
            #$Output = $wshell.Popup("Загрузка файла $name",2,"Waybill",0)
            $Label1.Text = "Загрузка $i % Пожалуйста подождите"    
            $pbrTest.Value = $i
            Start-Sleep -m 1
            $i += 17
        }
        $Label1.Text = "Программа обновлена. Запуск"
        Start-Sleep 3
        $Form.Close()      
        #$Output = $wshell.Popup("Программа обновлена, Запуск программы",0,"Waybill")

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

# Проверка версии

$pathversion = $PSScriptRoot + "/" + "version.txt"

$currentversion = Get-Content -Path $pathversion
$getversion = (Invoke-WebRequest -Uri 'https://raw.github.com/Shivaru/waybill/master/version.txt').content

$urls = 'https://raw.github.com/Shivaru/waybill/master/README.md',
        'https://raw.github.com/Shivaru/waybill/master/GetDataWialon.py',
        'https://raw.github.com/Shivaru/waybill/master/GA4-C.xls',
        'https://raw.github.com/Shivaru/waybill/master/LA.xls',
        'https://raw.github.com/Shivaru/waybill/master/main.exe',
        'https://raw.github.com/Shivaru/waybill/master/version.txt'

$startpath = $PSScriptRoot + "/" + "main.exe"
$startpath1 = $PSScriptRoot + "/" + "main_old.exe"

if ($currentversion -eq $getversion)
{
    $Output = $wshell.Popup("Обновления не требуется. Запуск",1,"Waybill",0)        
    & $startpath
}
else 
{
    $lsdir = ls $PSScriptRoot | where name -Like "main_old.exe"     
    if ($lsdir)
    {
        #$Output = $wshell.Popup("Копирование не требуется",1,"Waybill",0)          
    }
    else 
    {
        #$Output = $wshell.Popup("Копируем",1,"Waybill",0)
        try
        {
            Copy-Item -Path $startpath -Destination $startpath1 -Force 
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