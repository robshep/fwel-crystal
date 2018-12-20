# Fun With Emerging Languages - Crystal

    https://pastebin.com/raw/KzwWFYJL

## Code

see src/fwel.cr

## Build

    $ shards update
    $ crystal build --release src/fwel.cr -o fwel-osx

I'm on a Mac, so to build for linux in docker:

    docker run --rm -it -v `pwd`:/app -v `pwd`/lib/linux:/app/lib -w /app crystallang/crystal /bin/bash -c "shards update; crystal build --release src/fwel.cr"



## Usage

    ./fwel
    Linus Torvalds