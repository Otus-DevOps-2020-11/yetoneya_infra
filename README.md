# yetoneya_infra

## yetoneya Infra repository

### homework 2

Установила утилиту travis, создала workspace в slack, сделала  интеграцию

elena@debian:/Documents/dev-ops/yetoneya_infra$ travis login --github-token 1111111111111111111111111111111111111111 

Successfully logged in as yetoneya!

elena@debian:/Documents/dev-ops/yetoneya_infra$ travis encrypt "yetoneyacorporation:AAAAAAAAAAAAAAAAAAAAAAAA" --add notifications.slack -r yetoneya/yetoneya_infra

Overwrite the config file /home/elena/Documents/dev-ops/yetoneya_infra/.travis.yml with the content below?

This reformats the existing file.

    dist: trusty 

    sudo: required 

    language: bash before_install:

      curl https://raw.githubusercontent.com/express42/otus-homeworks/2020-11/run.sh | bash

        notifications: 
  
          slack: 
    
            secure: CnfC/mjT4es1vCvMvho4BAuPzEEpeVLqOYqK5eycBoIgL0rO9BreKitgYwS2hVF1itOfSneVMRwsDVo8IL49xi2Px2itQ11tUAIUWn2DISihVHmH8oIpVGQSJOuklHDIYpMuvuiBx8V550lN9rZnY7GK0jHvIqrkgXCIycdLX1EUAbMJAuNOAZKZM7+SmrGodOJxQP9QGHg1v3gaNdtrWboukNV6xdEoYR40zlBI65AfI+0TFxqc8elUQJb8jgcwAyZqlMLSUu5RvF9VMXisXzwzh/eVCHwReS6s/GrajxjmLriqAuyJVx/zSpT3UOTKmPBKArdH01xlznecOo+cZsurkm0T27KOZaO+5Kk9nfvhi6p91jlu4rbXvdHuHXOpeu2+3830YMkq7/lFu+pH2+XRsah3seE9GYdaj72KGrd/OABGmc+6cjrW9EEloRP0jLpxOI2CcYzdk/lLMLa7FPzWvTLBoAW2K01hBZgrNK2OEMY+pXfnLkOaqKLn6Ad+vVKzp//6iWorbi/MbwMapo8Hpv9c9GmUFi4CU7wRow2rl2KoPSBbiV4hbkmy+lt1qF36L4jYJhWYZHNk/BihdeB7+Gh/SlJztrs9t9piHhyEO5Mm5X8ZwhFXMyhUKJ6lGkeq/4Od5ALOVjZ3aXlS5pD6eIACNC2IHLXC4n2IXf8=     

(y/N) y

сообщение в Slack от GitHub:

GitHubAPP  8:04 PM This channel will get notifications from Otus-DevOps-2020-11/yetoneya_infra for: issues, pulls, deployments, statuses, public, commits:all, releases Learn More

сообщение от Travis:

elena 2:02 PM added an integration to this channel: Travis CI

### homework 3

ssh elena@130.193.50.142

#### настройка forwarding:

elena@bastion:~$ sudo sysctl -w net.ipv4.ip_forward=1

net.ipv4.ip_forward = 1

elena@debian:$ ssh -A elena@130.193.50.142 

elena@bastion:$ ssh 10.130.0.24

elena@innerhost:~$

elena@debian:$ ssh -J 130.193.50.142:22 elena@10.130.0.24

elena@innerhost:$

#### proxy jump:

    Host innerhost 

      HostName 10.130.0.24 

      ProxyJump 130.193.50.142:22 

      User elena

elena@debian:$ ssh innerhost 

elena@innerhost:$

#### pritunl

установила pritunl, проверила установку:

elena@bastion:~$ pritunl version pritunl v1.29.2664.67

запустила. проверила:

elena@bastion:~$ netstat -tlpn 

(Not all processes could be identified, non-owned process info will not be shown, you would have to be root to see it all.) Active Internet connections (only servers) Proto Recv-Q Send-Q Local Address Foreign Address State PID/Program name

tcp 0 0 127.0.0.53:53 0.0.0.0:* LISTEN -

tcp 0 0 0.0.0.0:22 0.0.0.0:* LISTEN -

tcp 0 0 127.0.0.1:9755 0.0.0.0:* LISTEN -

tcp 0 0 127.0.0.1:27017 0.0.0.0:* LISTEN -

tcp6 0 0 :::22 :::* LISTEN -

tcp6 0 0 :::443 :::* LISTEN -

tcp6 0 0 :::80 :::* LISTEN

дальше по инструкциям:

sudo pritunl setup-key

sudo pritunl default-password

добавила юзера, организацию, сервер. Добавила серверу адрес innerhost

установила openvpn на своем компьютере:

sudo apt install openvpn

elena@debian:~$ sudo openvpn ~/Downloads/test/test_tester_server.ovpn

подключилась к innerhost:

elena@debian:~$ ssh elena@innerhost 

Welcome to Ubuntu 20.04 LTS (GNU/Linux 5.4.0-26-generic x86_64)
    • Documentation: https://help.ubuntu.com
    • Management: https://landscape.canonical.com
    • Support: ttps://ubuntu.com/advantage
Failed to connect to https://changelogs.ubuntu.com/meta-release-lts. Check your Internet connection or proxy settings
Last login: Wed Dec 30 08:14:53 2020 from 10.130.0.7 

elena@innerhost:~$


#### сертификат:

setting -> Lets Encrypt Domain ->www.130.193.50.142.xip.io

так как виртуалка была прерываемой. то новые ip для проверки

#### test

bastion_IP = 178.154.225.152

innerhost_IP = 10.130.0.30

www.178.154.225.152.xip.io

### homework 4

[![](https://github.com/yetoneya/pictures/blob/main/homework04.jpg)

    yc compute instance create \
      --folder-name catalog \
      --name reddit-app \
      --hostname reddit-app \
      --memory=4 \
      --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
      --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1604-lts,size=10GB \
      --metadata-from-file user-data=./metadata.yaml \
      --metadata serial-port-enable=1 \
      --ssh-key ~/.ssh/id_rsa.pub

### homework 5

создан сервисный аккаунт и вм при помощи ec cli

создан образ на основе файла ubuntu16.json без параметризации

создан образ на основе файла immutable.json, создана vm на основе образа, выполнен вход в аккаунт

testapp_IP: 178.254.246.75 testupp_port: 9292 (прерываемая, если остановится, могу пересоздать для проверки)

[![](https://github.com/yetoneya/pictures/blob/main/homework05-1.png)

[![](https://github.com/yetoneya/pictures/blob/main/homework05-2.png)

[![](https://github.com/yetoneya/pictures/blob/main/homework05-3.png)

[![](https://github.com/yetoneya/pictures/blob/main/homework05-4.png)

[![](https://github.com/yetoneya/pictures/blob/main/homework05-5.png)

[![](https://github.com/yetoneya/pictures/blob/main/homework05-6.png)


создание vm из образа:
     
     yc compute instance create \
       --name vm-from-image \
       --folder-id=b1gbj6r7clnrmifr988p
       --zone ru-central1-a \
       --create-boot-disk name=disk1,size=5,image-id=fd88sfr4itgrb19srt81 \
       --public-ip \
       --ssh-key ~/.ssh/id_rsa.pub


образ для Ubuntu-20 собирается без sleep в скриптах
