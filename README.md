﻿# yetoneya_infra
 ## yetoneya Infra repository


### homework-02b

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

