# deepfry-cli

DeepFry is a tool to create and write NAND images for CHIP, the $9 computer.

```
NOTE: DeepFry is in an unstable alpha state.
      While flashing will work in most cases, it might also corrupt data on your
      CHIP. Use on your on risk - I can't take responsibility for what happens
      when you use this software (c.f. legal section below). 
      As of now, it is only possible to clone CHIP's that have an UBI created
      with kernel 4.4. Support for the 4.3 kernel is possible in theory.
```

```
CAUTION: When creating and distributing images with be careful not to violate
         copyright. Also do remove your private data such as wifi and ssh keys
         before you distribute an image.
```

## flash an image
```
deepfry-cli flash <image file name>
```

## clone (backup) a chip
```
deepfry-cli clone <image file name>
``` 

## create a multi-nand chip (TOSHIBA & HYNIX) image
```
deepfry-cli image <image file name>
``` 

## build from source
```
git clone https://gitlab.com/kaplan2539/deepfry-cli
cd deepfry-cli
make chip_defconfig
make all
sudo make install #root password required; installs to /usr/local/
```

## legal
Copyright (C) 2018, 2019 Alexander Kaplan

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.

DeepFry is distributed with the following software binaries:

deepfry:                    The DeepFry script (GPLv3+)
zImage:                     The Linux Kernel for CHIP (GPLv2+)
sun5i-r8-chip.dtb:          Device Tree for CHIP (GPLv2+)
u-boot-sunxi-with-spl.bin:  U-Boot for CHIP (GPLv2+)
spl-hynix-mlc.bin           U-Boot SPL for CHIP (GPLv2+)
spl-toshiba-mlc.bin         U-Boot SPL for CHIP (GPLv2+)
boot.scr.bin                DeepFry U-Boot script (GPLv3+)
rootfs.cpio.uboot           DeepFry initrd consisting of various open source software:
  - uclibc (GPLv2.1+)
  - BusyBox (GPLv2)
  - Dropbear (various parts under several open source licenses)
  - zlib (zlib License)
  - cdb (GPLv2+)
  - lzo (GPLv2+)
  - gadget-init-scripts (part of GadgetOS GPLv3+)
  - dnsmasq (GPLv2+/GPLv3+)
  - util-linux (various parts under several open source licenses)

More detailed license information and the exact source code including patches
are available for download together with the binary packages at
https://gitlab.com/kaplan2539/deepfry-cli.
