
$getversion = (Invoke-WebRequest -Uri 'https://raw.github.com/Shivaru/waybill/master/version.txt').content

$getfile = Invoke-WebRequest $link -outfile “.\name”


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
