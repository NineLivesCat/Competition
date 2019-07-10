# Introduction

* This directory is an demo configuration files for `chibios19.1` Other project should keep project structure the same as this configuration files

# Author

* NineLivesCat

# Structure

* core      :    core library
    * chibios       :   chibios19.1.0
    * source        :   shared header and code
    * syscfg.mk     :   system configuration makefile rule
    * oscfg.mk      :   chibios configuration makefile rule
    * STM32F429.ld  :   STM32F429 ld file
* source       :   header and code
* tool      :   some tool for user
    * ChibiOS_19.1.0            :   original chibios file
    * fmpp                      :   fmpp tool
    * ftl                       :   ftl file
    * mk                        :   automake rule
    * updater                   :   updater
* Makefile  :   personal makefile
* README.md :   this file

# Todo

* nothing currently

# Update

* 2019/7/11     By:NLC          remove todo list
* 2019/7/4      By:NLC          merge inc and src
* 2019/6/23     By:NLC          Refactor project and finish configuration

# Configure Environment

## For Linux (tested on Ubuntu 18.04)

* run command `sudo apt-get install openocd gcc-arm-none-eabi`
* download the configurations flies and put it on any directory you want
* change to directory where you put configurations flies
* run command `make` or `make -j`
* if `build` directory and `*.elf` is created, the environment is configured well
* (optional) download VSCode and buy a Jlink for better coding and debugging 

## For MAC OSX

* install homebrew via https://brew.sh
* install XCode command line toolchain
 `xcode-select --install`
 `brew cask install xquartz java`
 `brew install open-ocd`
 `brew tap PX4/px4`
 `brew install px4-dev`
* download the configurations flies and put it on any directory you want
* change to directory where you put configurations flies
* run command `make` or `make -j`
* if `build` directory and `*.elf` is created, the environment is configured well
* (optional) download VSCode and buy a Jlink for better coding and debugging

## For Windows

* download configurations flies
* copy `./tools/fmpp`(ues`{FMPP_Directory}` to represent its directory below), `../GNU/GNU Tools`(ues`{GNUTOOLS_Directory}` to represent its directory below) and `../GNU/GNU Tools for ARM Embedded`(ues`{ARMTOOLS_Directory}` to represent its directory below) to another directory
* install `JDK` ,configure the system environment and restart computer 
* run cmd or powershell enter `java -version` to check if JDK is installed
* add `{FMPP_Directory}/fmpp/bin` 
 `{GNUTOOLS_Directory}/GNU Tools/bin` 
 `{ARMTOOLS_Directory}/GNU Tools ARM Embedded\7.0 2017q4\bin`
 to system environment and restart computer
* run cmd or powershell enter `fmpp -v`,`arm-none-eabi-gcc -v` and `make -v` to check the environment configuration
* change to directory where you put configurations flies
* run command `make` or `make -j`
* if `build` directory and `*.elf` is created, the environment is configured well
* (optional) download VSCode and buy a Jlink for better coding and debugging

