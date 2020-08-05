<#



Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$Form                            = New-Object system.Windows.Forms.Form
$Form.ClientSize                 = New-Object System.Drawing.Point(262,142)
$Form.text                       = "Form"
$Form.TopMost                    = $true

$ProgressBar1                    = New-Object system.Windows.Forms.ProgressBar
$ProgressBar1.width              = 222
$ProgressBar1.height             = 26
$ProgressBar1.location           = New-Object System.Drawing.Point(22,49)

$Label1                          = New-Object system.Windows.Forms.Label
$Label1.text                     = "label"
$Label1.AutoSize                 = $true
$Label1.width                    = 25
$Label1.height                   = 10
$Label1.location                 = New-Object System.Drawing.Point(25,21)
$Label1.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Button1                         = New-Object system.Windows.Forms.Button
$Button1.text                    = "button"
$Button1.width                   = 60
$Button1.height                  = 30
$Button1.location                = New-Object System.Drawing.Point(185,92)
$Button1.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Form.controls.AddRange(@($ProgressBar1,$Label1,$Button1))

FORM 0

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$Form0                            = New-Object system.Windows.Forms.Form
$Form0.ClientSize                 = New-Object System.Drawing.Point(262,142)
$Form0.text                       = "Form"
$Form0.TopMost                    = $true

$Label0                          = New-Object system.Windows.Forms.Label
$Label0.text                     = "label"
$Label0.AutoSize                 = $true
$Label0.width                    = 25
$Label0.height                   = 10
$Label0.location                 = New-Object System.Drawing.Point(113,57)
$Label0.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Form.controls.AddRange(@($Label1))




#>




<#


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

$Form = New-Object System.Windows.Forms.Form
$Form.width = 250
$Form.height = 150
$Form.Text = "Add Resource"

# Init ProgressBar
$pbrTest = New-Object System.Windows.Forms.ProgressBar
$pbrTest.Maximum = 100
$pbrTest.Minimum = 0
$pbrTest.Location = new-object System.Drawing.Size(10,10)
$pbrTest.size = new-object System.Drawing.Size(100,10)
$i = 0
$Form.Controls.Add($pbrTest)

# Button
$btnConfirm = new-object System.Windows.Forms.Button
$btnConfirm.Location = new-object System.Drawing.Size(120,10)
$btnConfirm.Size = new-object System.Drawing.Size(100,30)
$btnConfirm.Text = "Start Progress"
$Form.Controls.Add($btnConfirm)

$timer = New-Object System.Windows.Forms.Timer 
$timer.Interval = 1000

$timer.add_Tick({
StartProgressBar
})

$timer.Enabled = $true
$timer.Start()


# Button Click Event to Run ProgressBar
$btnConfirm.Add_Click({
    
    While ($i -le 100) {
        $pbrTest.Value = $i
        Start-Sleep -m 1
        "VALLUE EQ"
        $i
        $i += 1
    }
})




# Button Click Event to Run ProgressBar
$btnConfirm.Add_Click({
    
    While ($i -le 100) {
        $pbrTest.Value = $i
        Start-Sleep -m 1
        "VALLUE EQ"
        $i
        $i += 1
        $Form.Text = "Add Resource $i"
    }
})



# Show Form
$Form.Add_Shown({$Form.Activate()})
$Form.ShowDialog()


#>


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
#$pbrTest.size = new-object System.Drawing.Size(100,10)
$i = 0
$Form.Controls.Add($pbrTest)

$Label1                          = New-Object system.Windows.Forms.Label
$Label1.text                     = "Нажми для загрузки"
$Label1.AutoSize                 = $true
$Label1.width                    = 85
$Label1.height                   = 10
$Label1.location                 = New-Object System.Drawing.Point(25,21)
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


# Button Click Event to Run ProgressBar
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
            $Label1.Text = "Загрузка $name $i %"
            
            $pbrTest.Value = $i
            Start-Sleep -m 1
            "VALLUE EQ"
            $i
            $i += 20
            $Label1.Text = "Загрузка $i %"


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








# Окно с предупреждением что программа обновляется

Stop-Process -Name main -Force -ErrorAction SilentlyContinue


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

$pathversion

$currentversion
$getversion



if ($currentversion -eq $getversion)
{
    $Output = $wshell.Popup("Обновления не требуется. Запуск",1,"Waybill",0)        
    & $startpath
}
else 
{
    #$Output = $wshell.Popup("Устанавливается обновление, пожалуйста подождите",1,"Waybill",0)

    $lsdir = ls $PSScriptRoot | where name -Like "main_old.exe"     
    if ($lsdir)
    {
        $Output = $wshell.Popup("Копирование не требуется",1,"Waybill",0)          
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






### Old Version


# Окно с предупреждением что программа обновляется

<#

-------------------------------------------------



if ($currentversion -eq $getversion)
{
    $Output = $wshell.Popup("Обновления не требуется",0,"Waybill")        
    #& $startpath
}
else 
{
    $Output = $wshell.Popup("Устанавливается обновление, пожалуйста подождите",0,"Waybill")


    $Form.controls.AddRange(@($pbrTest,$Label1,$btnConfirm))
    $Form.Add_Shown({$Form.Activate()})
    $Form.ShowDialog()

    # Копируем предыдущую версию
   
    $lsdir = ls $PSScriptRoot | where name -Like "main_old.exe"     
    if ($lsdir)
    {
        Write-Host "Копирование не требуется"        
    }
    else 
    {
        Write-Host "Копируем" 
        Copy-Item -Path $pathversion -Destination $startpath1 -Force        
    }

# ОТОБРАЖЕНИЕ ЗАГРУЗКИ
    
    # Обновление файлов
   
    try
    {
        foreach ($link in $urls)
        {
            $name = $link.split("/")[-1]
            $fullname = $PSScriptRoot + "\" + $name
            #$Output = $wshell.Popup("Загрузка файла $name",2,"Waybill",0)
            #$getfile = Invoke-WebRequest $link -outfile “$fullname”
            $Output = $wshell.Popup("Загрузка файла $name",2,"Waybill",0)

        }      
        $Output = $wshell.Popup("Программа обновлена, Запуск программы",0,"Waybill")
        #& $startpath
    }
    catch 
    {
        $Output = $wshell.Popup("Программу неудалось обновить, запуск предыдущей версии",0,"Waybill")
        #& $startpath1
    }
    
}



















-----------------------------------

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



#>