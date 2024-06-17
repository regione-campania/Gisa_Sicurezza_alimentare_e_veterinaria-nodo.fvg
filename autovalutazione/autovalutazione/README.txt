nstall Dependencies
yum install fontconfig libXrender libXext xorg-x11-fonts-Type1 xorg-x11-fonts-75dpi freetype libpng zlib libjpeg-turbo

wget https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6-1/wkhtmltox-0.12.6-1.centos7.x86_64.rpm
yum localinstall wkhtmltox-0.12.6-1.centos7.x86_64.rpm

Verify
wkhtmltopdf --version