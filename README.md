# deepfry-cli

DeepFry is a tool to write NAND image onto CHIP the $9 computer.

`NOTE: deepfry-cli is in an unstable alpha state.
Flashing might or might not work.
It might also corrupt data on your CHIP.
It's only possible to clone CHIP's that have an UBI created with kernel 4.4.
Support for the 4.3 kernel is possible in theory.`

## build from source

```
git clone https://gitlab.com/kaplan2539/deepfry-cli
cd deepfry-cli
make chip_defconfig
make all
```

## usage


