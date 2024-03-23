# Configuration

Prior to running `archlinux_init.sh`, a couple of steps need to be done first :

## 1. Pre installation

First we need to boot from Live CD, it's containing a basic version of arch with zsh and some useful utilities. We first need to configure the system on this liveCD (so we can use it while installing our arch system)

1. Change layout : `loadkeys fr`

2. Verify boot mode : `ls /sys/firmware/efi/efivars` , if no errors we're in uefi mode (good) otherwise we might be in bios.

3. connect to internet (wifi):

   - `iwctl` : launch the iwctl cli
   - `device list` : list interfaces
   - `station myinterface scan` : scan for networks
   - `station myinterface get-networks` : get networks
   - `station myinterface connect SSID`
   - exit iwctl cli and ping `google.com`

4. update clock:

   - `timedatectl status` : get the current clock status (generally will be utc+0)
   - `timedatectl list-timezones` : list all timezones
   - `timedatectl set-timezone Africa/Tunis` : Change timezone to Tunis

5. partition disks:

   - `fdisk -l` : List all disks
   - `fdisk /dev/nvme0n1` : Select the `nvme0n1` disk so we can manipulate it ( add / remove partitions )
   - `d->choose partition to delete` : Delete previous existing partitions first (delete efi partition too if we're not dual booting )
   - `g` : used to create an empty gpt partition table
   - `n->partition number: 1 -> start block 2048 -> end +300M` : Create our first partition (used as efi partition, it has to have 300M minimum)
     - `hit l` : list partition types, get the efi partition alias
     - `hit v -> select our partition 1 -> change its type to efi (based on alias)`
   - `n->partition number: 2 -> start block (default) -> end block (default, remainder of disk)`
     - `hit l` : list partition types to get `x86_64` root linux partition
     - `hit v -> select out partition 2 -> change its type to x86_64 linux root system`

6. Format partitions and create file systems

   - `mkfs.ext4 /dev/nvme0n1p2` : create ext4 filesystem for our main partition
   - `mkfs.fat -F32 /dev/nvme0n1p1` : create FAT32 filesystem for out EFI partition ( EFI partitions only accept FAT formats, and FAT32 is recommanded )

7. Mount new partitions

In this step, we mount the new partitions under `/mnt` and `/mnt/boot`. Our live CD is on `/` for now that's why we need to mount our system on `/mnt`, install the kernel and configure the bootloader. then it will be mounted to:

- `/` for main partition
- `/boot` for our EFI partition

So to start of we do this

- `mount /dev/nvme0n1p2 /mnt` : mount our main system on `/mnt`
- `mount /dev/nvme0n1p1 /mnt/boot` : mount our efi partition on `/mnt/boot`

## 2. Installation

1. Select mirrors ( if we want to change them, otherwise they're good )

2. `pacstrap -K /mnt base linux linux-firmware` : Install essential packages

## 3. Configure system

1. fstab

   - `genfstab -U /mnt >> /mnt/etc/fstab` : generate the file system table.
   - Check `/mnt/etc/fstab`, make sure the main and boot partition are **both** automounted on boot

2. Chroot

   - `arch-chroot /mnt` : change root so we login to our new system

3. Timezone

   - `ln -sf /usr/share/zoneinfo/Africa/Tunis /etc/localtime` : Change the local timezone
   - `hwclock --systohc` : needed to configure clock

4. Localization

   - edit `/etc/locale.gen` and uncomment `en_US.UTF-8 UTF-8` then generate the locales by running `locale-gen`
   - in `/etc/locale.conf` set the lang variable `LANG=en_US.UTF-8`
   - in `/etc/vconsole.conf` set the keyboard layout for the tty by doinng `localectl set-keymap fr`
   - The layout for Xorg will be configured after we install it

5. Network

   - in `/etc/hostname` add out machine hostname (e.g. `ideapad`)
   - in `/etc/hosts` we add the basic network config

   - ```bash
      127.0.0.1 localhost
      ::1 localhost
      127.0.1.1 ideapad.localdomain ideapad
      ```

6. Basic packages

   - Add the minmum packages needed for utilies : `pacman -S base-devel git openssh vi`
   - Add the minimum packages for networking : `pacman -S networkmanager`

7. User config

   - `usermod -m saief1999`
   - `passwd saief1999` : change password for newly created user
   - `usermod saief1999 -aG wheel,audio,video,optical,storage` : add necessary groups for our new user
   - `visudo` then uncomment the part `%wheel ALL=(ALL) NOPASSWD: ALL` so our user can `sudo`

8. Install microcode ( CPU optimizations )

   - `pacman -S amd-ucode` ( or `intel-ucode` )

9. Install bootloader ( We will use GRUB )
  
   - `pacman -S grub efibootmgr dosfstools os-prober mtools`
   - `mkdir /boot/EFI` : Create EFI boot directory
   - `mount /dev/nvme0n1p1 /boot/EFI`
   - `grub-install --target=x86_64-efi --bootloader-id=grub_uefi --efi-directory=/boot/EFI --recheck` : Install the grub bootloader to the partition
   - `grub-mkconfig -o /boot/grub/grub.cfg` : Write grub configuration

10. Create SWAP file

    - `fallocate -l 5G /swapfile` : create a 5GB swapfile ( size depends on system )
    - `chmod 600 /swapfile`
    - `mkswap /swapfile`
    - `echo '/swapfile none swap sw 0 0' | tee -a /etc/fstab`

11. Unmount and reboot

    - `exit` to return to LiveCd root
    - `umount -R /mnt` : unmount everything under /mnt
    - `reboot`

## 4. Post installation

1. login to our user

2. Clone the utility script repo under our home

3. **Enable Multilib Repo in archlinux** because some packages belong to it

4. Cd to the configuration dir and run `archlinux_init.sh`. And pray to god

5. run `archlinux_extras.sh`

6. run `archlinux_dotfiles.sh`
