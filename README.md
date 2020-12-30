# yetoneya_infra
yetoneya Infra repository

#homework2

elena@debian:~/Documents/dev-ops/yetoneya_infra$ travis login --github-token 2729297f8391fac858eecdabced9bd4421d21a9f
Successfully logged in as yetoneya!
elena@debian:~/Documents/dev-ops/yetoneya_infra$ travis encrypt "yetoneyacorporation:9wkNPLiiyVuTl0MgSu8NJ0yJ" --add notifications.slack -r yetoneya/yetoneya_infra


Overwrite the config file /home/elena/Documents/dev-ops/yetoneya_infra/.travis.yml with the content below?

This reformats the existing file.

---
dist: trusty
sudo: required
language: bash
before_install:
- curl https://raw.githubusercontent.com/express42/otus-homeworks/2020-11/run.sh | bashdist: trusty
notifications:
  slack:
    secure: CnfC/mjT4es1vCvMvho4BAuPzEEpeVLqOYqK5eycBoIgL0rO9BreKitgYwS2hVF1itOfSneVMRwsDVo8IL49xi2Px2itQ11tUAIUWn2DISihVHmH8oIpVGQSJOuklHDIYpMuvuiBx8V550lN9rZnY7GK0jHvIqrkgXCIycdLX1EUAbMJAuNOAZKZM7+SmrGodOJxQP9QGHg1v3gaNdtrWboukNV6xdEoYR40zlBI65AfI+0TFxqc8elUQJb8jgcwAyZqlMLSUu5RvF9VMXisXzwzh/eVCHwReS6s/GrajxjmLriqAuyJVx/zSpT3UOTKmPBKArdH01xlznecOo+cZsurkm0T27KOZaO+5Kk9nfvhi6p91jlu4rbXvdHuHXOpeu2+3830YMkq7/lFu+pH2+XRsah3seE9GYdaj72KGrd/OABGmc+6cjrW9EEloRP0jLpxOI2CcYzdk/lLMLa7FPzWvTLBoAW2K01hBZgrNK2OEMY+pXfnLkOaqKLn6Ad+vVKzp//6iWorbi/MbwMapo8Hpv9c9GmUFi4CU7wRow2rl2KoPSBbiV4hbkmy+lt1qF36L4jYJhWYZHNk/BihdeB7+Gh/SlJztrs9t9piHhyEO5Mm5X8ZwhFXMyhUKJ6lGkeq/4Od5ALOVjZ3aXlS5pD6eIACNC2IHLXC4n2IXf8=


(y/N)
y

сообщение в slack отGitHub:

GitHubAPP  8:04 PM
This channel will get notifications from Otus-DevOps-2020-11/yetoneya_infra for:
issues, pulls, deployments, statuses, public, commits:all, releases
Learn More

сообщение от Travis:

elena  2:02 PM
added an integration to this channel: Travis CI

#homework 3

ssh elena@130.193.50.142

sctl net.ipv4.ip_forward
net.ipv4.ip_forward = 0

elena@bastion:~$ sudo sysctl -w net.ipv4.ip_forward=1
net.ipv4.ip_forward = 1

elena@debian:~$ ssh -A elena@130.193.50.142
elena@bastion:~$ ssh 10.130.0.24
elena@innerhost:~$ 

elena@debian:~$ ssh -J 130.193.50.142:22 elena@10.130.0.24
elena@innerhost:~$ 

Host innerhost
    HostName 10.130.0.24
    ProxyJump 130.193.50.142:22
    User elena

elena@debian:~$ ssh innerhost
elena@innerhost:~$ 

установила pritunl, проверила:

elena@bastion:~$ pritunl version
pritunl v1.29.2664.67

запустила. проверила:

elena@bastion:~$ netstat -tlpn
(Not all processes could be identified, non-owned process info
 will not be shown, you would have to be root to see it all.)
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name    
tcp        0      0 127.0.0.53:53           0.0.0.0:*               LISTEN      -                   
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN      -                   
tcp        0      0 127.0.0.1:9755          0.0.0.0:*               LISTEN      -                   
tcp        0      0 127.0.0.1:27017         0.0.0.0:*               LISTEN      -                   
tcp6       0      0 :::22                   :::*                    LISTEN      -                   
tcp6       0      0 :::443                  :::*                    LISTEN      -                   
tcp6       0      0 :::80                   :::*                    LISTEN

дальше все по инструкциям:

sudo pritunl setup-key

sudo pritunl default-password

добавила юзера, организацию и сервер. добавила серверу адрес innerhost

sudo apt install openvpn

elena@debian:~$ sudo openvpn ~/Downloads/test/test_test_server.ovpn

elena@debian:~$ ssh elena@innerhost
Welcome to Ubuntu 20.04 LTS (GNU/Linux 5.4.0-26-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

Failed to connect to https://changelogs.ubuntu.com/meta-release-lts. Check your Internet connection or proxy settings

Last login: Wed Dec 30 08:14:53 2020 from 10.130.0.7
elena@innerhost:~$

сертификат:
setting -> Lets Encrypt Domain -> www.130.193.50.142.xip.io -> вход по www.130.193.50.142.xip.io

