#!/bin/bash
##Question 1
groupadd guests -g 9090
groupadd boss -g 2222
##Question 2
mkdir /usr/home
useradd -u 6969 -G guests,boss -m -d /usr/home/jason jason
##Question 3
cd /usr/home/jason
touch -d '1979-11-27' test.sh
##Question 4
mkdir /usr/home/jason/dev
ln -s /usr/home/jason/test.sh /usr/home/jason/dev/appli
#Question 5
echo '#!/bin/bash\nps -eo comm,cmd' > process.sh
chmod +x process.sh
##Question 6
chmod 644 $(find /usr/home/jason/ -type f)
chmod 755 $(find /usr/home/jason/ -type d)

