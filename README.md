# [mywarp.github.io](https://mywarp.github.io)
[![Build Status](https://github.com/MyWarp/mywarp.github.io/workflows/publish%20website/badge.svg)](https://github.com/MyWarp/mywarp.github.io/actions)

Website for the [MyWarp project](https://github.com/MyWarp/MyWarp), hosted on GitHub pages.

The `master` branch contains the final website, `src` contains the source. Whenever changes are pushed to `src`, it is automatically build by a Github Action and results are - upon success - pushed to `master`.

## Development

We use [Middleman](https://middlemanapp.com) to build the site. Javascript is bundled using [esbuild](https://esbuild.github.io), stylesheets using [Dart SASS](https://sass-lang.com/dart-sass).

Middleman automatically calls both tools during the build process via its [external pipeline](https://middlemanapp.com/advanced/external-pipeline/). This allows us to manage frontend dependencies via NPM, import them in SASS and Javascript, and parse Javascript via [Babel](https://babeljs.io). After the build, Middlemann calls [PurgeCSS](https://purgecss.com) to remove unused CSS.

Assets build by via the external pipeline can be found in the `assets` folder, assets build by Middleman in the `source` folder. For the configuration of the external tools, check the `scripts` section in `package.json`.

## Build

Install Ruby, Node (including NPM) and ImageOptim. Then, run:

```
bundle install
npm install
bundle exec middleman build
```

For development you might want to use Middleman's build-in server: `bundle exec middleman`.