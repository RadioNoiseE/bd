# bd

## Intro

Bangumi scraper for bilibili written in OCaml | 扫荡小破站的番剧 [WIP]

## Status

Under development.
Currently tested on (Gentoo) Linux and MacOS, should run on Windows.

## Build

### Dependencies

1. OCaml development environment:
   - On Gentoo Linux run `emerge --ask dev-lang/ocaml`;
   - On MacOS run `sudo pkgin install ocaml`.
2. C complier (gcc/clang).
3. C Library `libcurl`:
   - On Gentoo Linux run `emerge --ask net-misc/curl`;
   - On MacOS you are recommended to run `xcode-select --install` to install Xcode command line tools which included `libcurl`.

### Build the binary

Fetch the repository using:
```sh
git clone https://github.com/RadioNoiseE/bd
```
then kindly `cd`:
```sh
cd bd
```
If necessary, specify the C complier in `makefile` line 5:
```makefile
cc := clang
```
Finally generate the binary:
```sh
make
```
and cleanup the current directory (optional):
```sh
make clean_aux
```

The generated standalone binary `bd` is what you want. All the libraries are statically linked.
