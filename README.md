# [mywarp.github.io](https://mywarp.github.io)
[![Build Status](https://travis-ci.org/MyWarp/mywarp.github.io.svg?branch=src)](https://travis-ci.org/MyWarp/mywarp.github.io)

Website for the [MyWarp project](https://github.com/MyWarp/MyWarp), hosted on GitHub pages.

The `master` branch contains the final website, `src` contains the source. Whenever changes are pushed to `src`, it is automatically build by Travis and results are - upon success - pushed to `master`.

## Build

The site is build with [Middleman](https://middlemanapp.com). To build it yourself, make sure that Ruby, Rubygems and Imagemagick are installed and configured, then clone this repository and run:

```
bundle install
middleman build
```

For development you might want to use Middleman's build-in server: `middleman server`.
