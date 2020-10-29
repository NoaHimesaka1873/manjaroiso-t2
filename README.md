## iso-profiles


### profile.conf

~~~
##########################################
###### use this file in the profile ######
##########################################

## use multilib packages; x86_64 only
# multilib="true"

## use extra packages as defined in pkglist to activate a full profile
# extra="false"

################ install ################

## default displaymanager: none
## supported; lightdm, sddm, gdm, lxdm, mdm
# displaymanager="none"

## Set to false to disable autologin in the livecd
# autologin="true"

## nonfree xorg drivers
# nonfree_mhwd="true"

## possible values: grub;systemd-boot
# efi_boot_loader="grub"

## configure calamares for netinstall
# netinstall="false"

## configure calamares for mhwd
# mhwd_used="true"

## configure calamares for oem
# oem_used="false"

## configure calamares to use chrootcfg instead of unpackfs; default: unpackfs
# chrootcfg="false"

## use geoip
# geoip="true"

## unset defaults to given values
## names must match systemd service names
# enable_systemd=('bluetooth' 'cronie' 'ModemManager' 'NetworkManager' 'org.cups.cupsd' 'tlp' 'tlp-sleep')
# disable_systemd=()

## unset defaults to given values
# addgroups="video,power,disk,storage,optical,network,lp,scanner,wheel"

## the same workgroup name if samba is used
# smb_workgroup="Manjaro"

## default system shell is bash
## '/etc/defaults/useradd': " "
## userShell              : "/bin/zsh"
## empty value will not be used
# user_shell=" "

## use calamares office installer
## supported: true,false
# office_installer="false"

## add strict snaps: strict_snaps="snapd core core18 gnome-3-28-1804 gtk-common-themes snap-store"
# strict_snaps=""

## add classic snaps: classic_snaps="code"
# classic_snaps=""

## choose the snap channel.
## supported:: stable,candidate,beta,edge
# snap_channel="candidate"

########## calamares preferences ##########
# See /etc/manjaro-tools/branding.desc.d for reference
# These settings will override settings from manjaro-tools.conf

## welcome style for calamares
## true="Welcome to the %1 installer."
## false="Welcome to the Calamares installer for %1." (default)
# welcomestyle=false

## welcome image scaled (productWelcome)
# welcomelogo=true

## size and expansion policy for Calamares
## supported: normal,fullscreen,noexpand
# windowexp=noexpand

## size of Calamares window, expressed as w,h
## supported: pixel (px) or font-units (em))
# windowsize="800px,520px"

## placement of Calamares window
## supported: center,free
# windowplacement="center"

## colors for text and background components:

## background of the sidebar
# sidebarbackground=#454948

## text color
# sidebartext=#efefef

## background of the selected step
# sidebartextselect=#4d915e

## text color of the selected step
# sidebartexthighlight=#1a1c1b

################# live-session #################

## unset defaults to given value
# hostname="manjaro"

## unset defaults to given value
# username="manjaro"

## unset defaults to given value
# password="manjaro"

## the login shell
## defaults to bash
# login_shell=/bin/bash

## unset defaults to given values
## names must match systemd service names
## services in enable_systemd array don't need to be listed here
# enable_systemd_live=('manjaro-live' 'mhwd-live' 'pacman-init' 'mirrors-live')
disable_systemd_live=('tlp' 'tlp-sleep')

~~~

### Packagelist tags

~~~
>systemd

>x86_64
>multilib

>nonfree_default
>nonfree_x86_64
>nonfree_multilib

>manjaro

>basic
>extra
~~~

### Packages-Root

* Contains root image packages
* ideally no xorg

### Packages-Desktop

* Contains the desktop image packages
* desktop environment packages go here

### Packages-Mhwd

* Contains the MHWD driver packages repo

### Packages-Live

* Contains packages you only want in live session but not installed on the target system with installer
* default files are in shared folder and can be symlinked or defined in a real file

### buildiso can be configured to use custom repos

* create a user-repos.conf

~~~
${profile_dir}/user-repos.conf
~~~

**Add only your repos to user-repos.conf!**

**Important**: Only online repos is allowed in the user-repos.conf. Buildiso will fail on file-based repos.


### Calamares
netgroups definitions go in [this](https://github.com/manjaro/calamares-netgroups) repo please
