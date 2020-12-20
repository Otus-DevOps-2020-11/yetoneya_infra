# yetoneya_infra
yetoneya Infra repository

==================================================================================================================================================================
homework-02b

elena@debian:~/Documents/yetoneya_infra$ travis login --github-token xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
Successfully logged in as yetoneya!
elena@debian:~/Documents/yetoneya_infra$ travis encrypt "yetoneyacorporation:XXXXXXXXXXXXXXXXXXXXXXXXXXXX" --add notifications.slack -r yetoneya/yetoneya_infra


Overwrite the config file /home/elena/Documents/yetoneya_infra/.travis.yml with the content below?

This reformats the existing file.

---
dist: trusty
sudo: required
language: bash
before_install:
- curl https://raw.githubusercontent.com/express42/otus-homeworks/2020-11/run.sh | bashdist: trusty
notifications:
  slack:
    secure: eeQ3UShI6zQXRJ9bPxNeVOFw/vE5nQn/2RHYE1mJQ5EPsRoyQsyAPArKYiTbEJO5On+8d3McUkJ1hpBRGP26I40txr1FUyKXdlQovF1iAMYZmNMbE1JB767p4HPOo+PNVFSDMxCnPrlbut6NuaYIfbPtBqb/H+v1FOuhBriMQkx3QPMaeLTbvaFh/kFpyzbEDip8xRVEuGnYIoTfwOSUP4xg3zJSqnPloojpmT9XjyE3yIgEGFLDkSq3oGMTxViv2j5+LbEnezqht/HknySgIuWQgRLnuyrmkaceMyP/dpPLZvvl3OyK00FXav7TDnbXcZKx6RTfYn+I8O7NlKqBMUvHOVdg9IvzUGJU3mPDW1lqotcSwhyGRgHn7kmb9BuWA0BIFCpz0uyyoFtu8f7p8bDy82IovLCtW2U2bnWhQCVphBH/tt/m8+saDJPxZabZkn76io2gjzYK3aRLOWrlrha4YGtd9XfuqY51QwNWQsxSJy5H9DFetoV5KdD4k48H/oKd+g0ZO3zxomEOl09XDePsECCc0q0+J6fXFszpRjZaohLvpJTizU+rg/y35YExM6w5XeUuJ7eNbiLSCTn66IiMkdQeL489MQlbF3ReZf4yE1eERsTIf/tH96bqXz7dmIkxbOEvGjo+ojvAUhoz4J4exa981m9U06MMBNEg52A=


(y/N)
y

==================================================================================================================================================================
