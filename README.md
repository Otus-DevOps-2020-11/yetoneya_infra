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
      
testapp_IP: 178.154.226.248 testapp_port: 9292   

### homework 5

создан сервисный аккаунт и вм при помощи ec cli

создан образ на основе файла ubuntu16.json без параметризации

создан образ на основе файла immutable.json, создана vm на основе образа, выполнен вход в аккаунт

testapp_IP: 84.201.156.249 testapp_port: 9292 

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


### homework 6

установлeн terraform-0.12.8

при помощи terraform сгенерирован и запущен инстанс из базового образа, созданного на прошлом homework:

[![](https://github.com/yetoneya/pictures/blob/main/homework06-1.png)

[![](https://github.com/yetoneya/pictures/blob/main/homework06-2.png)

#### задания **
**

создан еще один инстанс и load balancer

подключение через load balancer

[![](https://github.com/yetoneya/pictures/blob/main/homework06-3.png)

остановлен один сервер, приложение доступно по адресу балансера

[![](https://github.com/yetoneya/pictures/blob/main/homework06-4.png)

**

count = var.count_app * 2

name = "reddit-app-${count.index}"

**

недостатки: нет возможности разделить - сколько серверов создать. а сколько запустить


testapp_IP: 84.201.131.206 testapp_port: 9292

testapp_IP: 84.201.172.101 testapp_port: 9292

testapp_IP: 178.154.226.220 testapp_port: 80


### homework 7


#### разделение конфигурации


созданы сеть, подсеть. разделена конфигурацию на части - сеть, приложение, база данных. проверка:

[![](https://github.com/yetoneya/pictures/blob/main/homework07-01.png)

 
#### модули


созданы модули app и db:

[![](https://github.com/yetoneya/pictures/blob/main/homework07-02.png)


проверка:

[![](https://github.com/yetoneya/pictures/blob/main/homework07-03.png)


#### профили


созданы профили prod и stage:

[![](https://github.com/yetoneya/pictures/blob/main/homework07-04.png)

[![](https://github.com/yetoneya/pictures/blob/main/homework07-05.png)


#### backend

создан бакет yc object storage и  файлы backend.tf для каждого профиля


[![](https://github.com/yetoneya/pictures/blob/main/homework07-06.png)

[![](https://github.com/yetoneya/pictures/blob/main/homework07-07.png)

[![](https://github.com/yetoneya/pictures/blob/main/homework07-08.png)


конфигурационные файлы из директории prod перенесены в директорию exp, из этой директории запущен terraform apply

terraform destroy запущен из директории prod:

[![](https://github.com/yetoneya/pictures/blob/main/homework07-09.png)

[![](https://github.com/yetoneya/pictures/blob/main/homework07-10.png)

[![](https://github.com/yetoneya/pictures/blob/main/homework07-11.png)


проверена работа блокировок: если запущено приложение из prod, то при попытке запустить из stage получаем:

[![](https://github.com/yetoneya/pictures/blob/main/homework07-12.png)


#### provisioners


добавлены provisioners, настроен удаленный доступ к mongo, версия terraform 0.13.6, проверка:

[![](https://github.com/yetoneya/pictures/blob/main/homework07-13.png)


testapp_IP = 178.154.226.47  testapp_port: 9292
db_IP = 178.154.226.47

### homework 8

установлен ansible, создан файл inventory, выполнены команды:

    ansible reddit -i ./inventory -m ping
    ansible db -i ./inventory -m ping

[![](https://github.com/yetoneya/pictures/blob/main/homework08-01.png)

хосты объединены в группы, теперь можно выполнять команды для группы хостов:

ansible app -m ping


создан файл inventory.yml:

[![](https://github.com/yetoneya/pictures/blob/main/homework08-02.png)


выполняем команды для хостов:

[![](https://github.com/yetoneya/pictures/blob/main/homework08-03.png)


создан файл inventory.json:

[![](https://github.com/yetoneya/pictures/blob/main/homework08-04.png)

при выполнении команды  ansible-playbook clone.yml получили changed=0,так как reddit уже установлен.

командой  ansible app -m command -a 'rm -rf ~/reddit' его удалаили, поэтому при следующем выполнении 

ansible-playbook clone.yml получили changed=1

#### задания *

#### плагин для создания динамического inventory.json

в проекте создан модуль ansible-yc-dinamic-inventory: maven/java. в нем класс YCInventory. 

как работает:

если при запуске не передавать никаких параметров, происходит считывание информации из указанного каталога yc,

с авторизацией по токену

если передать в качестве  путь к файлу, то проверяется. соответствует ли содержимое файла требуемой структуре. если да - 

то перезаписывается существующий inventory.json

файл компилируется в исполняемый файл inventory.jar 

написан скрипт для запуска файла - import-inventory.

чтобы запустить: установить maven, java. выполнить в директории модуля mvn clean package.

переместить созданный jar-файл в корень директории ansible. сделать файл import-inventory исполняемым

запуск из директории ansible: 

./import-inventory (записывается информация из каталога yc); 

./import_inventore <путь к файлу-источнику> (перезаписывается данными из файла-источника)

чтобы поменять каталог - надо изменить его идентфикатор в файле Inventory.java.

скомпилировать заново. в pom.xml в разделе build задать другое значение finalName.

например, соответствующее имени каталога. создастся исполняемый jar с именем каталога.

т.е. можно сделать jar файлы для всех каталогов.

заменять названия в import-inventory, или сделать отдельные файлы для запуска

(не универсально. подходит для определенной структуры)


### homework 9


#### один playbook - один сценарий


добавлено отключение провижинга в terraform

добавлен output для внутренних хостов

созданы инстансы без провижинга, файлы конфигурации, выполнены команды

    ansible-playbook reddit_app.yml --check --limit db --tags db-tag

    ansible-playbook reddit_app.yml --limit db --tags db-tag

    ansible-playbook reddit_app.yml --check --limit app --tags app-tag

    ansible-playbook reddit_app.yml  --limit app --tags app-tag

    ansible-playbook reddit_app.yml --check --limit app --tags deploy-tag

    ansible-playbook reddit_app.yml --limit app --tags deploy-tag


затем проверки:

    ansible db -m command -a 'systemctl status mongod'

    ansible app -m command -a 'systemctl status puma'


[![](https://github.com/yetoneya/pictures/blob/main/homework09-01.png)

[![](https://github.com/yetoneya/pictures/blob/main/homework09-02.png)

[![](https://github.com/yetoneya/pictures/blob/main/homework09-03.png)

[![](https://github.com/yetoneya/pictures/blob/main/homework09-04.png)



#### один playbook - много сценариев


создан playbook reddit-app2.yml, сценарий разделен на части:


[![](https://github.com/yetoneya/pictures/blob/main/homework09-05.png)

[![](https://github.com/yetoneya/pictures/blob/main/homework09-06.png)

[![](https://github.com/yetoneya/pictures/blob/main/homework09-07.png)


#### несколько playbooks, в каждом отдельный сценарий


[![](https://github.com/yetoneya/pictures/blob/main/homework09-08.png)


#### задание * (dynamic inventory gcp)

создан Compute Engine на Google Cloud (instance-app)

в проекте создан модуль ansible-gc-dinamic-inventory: maven/java. в нем класс GCInventory. 


как работает:

требуется установка java, maven

в директории ansible-gc-dinamic-inventory выполнить команду mvn clean package

полученный jar файл скопирован в директорию ansible-gcp

для запуска инвентаризации создан исполняемый файл import-inventory

создан play-book google_git_play.yml, который устанавливает git на instance-app 

запущен, проверено. что git установлен: git version:


[![](https://github.com/yetoneya/pictures/blob/main/homework09-09.png)


#### packer

в директории ansible:

создан playbook packer_app.yaml для установки Ruby and Bundler

создан playbook packer_db.yaml для скачивания MongoDB


в директории packer в в db.json и ap.json изменены provisioners:

     "provisioners": [
       {
         "type": "ansible",
         "playbook_file": "../ansible/packer_app.yml"
       }
     ]

     "provisioners": [
       {
       "type": "ansible",
       "playbook_file": "../ansible/packer_app.yml"
       }
     ]

созданы новые образы базы данных и приложения

в terraforme изменены id образов и созданы виртуалки на основе этих образов

запущен ./import-inventory

запущен playbook site.yml

[![](https://github.com/yetoneya/pictures/blob/main/homework09-10.png)

проверена доступность сервиса:

[![](https://github.com/yetoneya/pictures/blob/main/homework09-11.png)


     testapp_IP = 178.154.253.43 testapp_port: 9292


### homework 10


созданы роли db и app, проверка:

[![](https://github.com/yetoneya/pictures/blob/main/homework10-01.png)


созданы окружения stage и prod, проверка:

[![](https://github.com/yetoneya/pictures/blob/main/homework10-02.png)

[![](https://github.com/yetoneya/pictures/blob/main/homework10-03.png)



добавлена community-роль jdauphant.nginx, добавлен вызов роли jdauphant.nginx в app.yml

проверено. что приложение доступно на порту 80:

[![](https://github.com/yetoneya/pictures/blob/main/homework10-04.png)


создали пользователей, проверка:

[![](https://github.com/yetoneya/pictures/blob/main/homework10-05.png)


#### задания со *

#### динамическое инвентори: 

добавили файлы inventory-yc.jar и import-inventory(созданные на прошлом дз) в директории 

ansible/environment/stage и ansible/environment/prog. inventory осуществляется командой 

./import-inventory


#### travis

изменен файл .travis.yml











































