# My Aerospace Config

## What is Aerospace?



## How to Build Config File:

I use [Nickel](https://nickel-lang.org/stdlib/std-contract/#from_validator) to 
autogenerate the config file. See their 
[Getting Started](https://nickel-lang.org/getting-started/) guide for how to 
install. Once installed, run the following command to build the aerospace 
config file:

```sh
nickel export src/config.ncl --format toml --output aerospace.toml
```

## Automatic Reload

I use [bacon](https://crates.io/crates/bacon) in order to watch for changes in 
src and rerun `export-config.sh`. 

Install with `cargo install bacon` and run with `bacon run`.

You can also run `bacon check` to just run a check on each save and avoid 
building the full config each time.

## LSP Support

Use the
[Nickel](https://marketplace.visualstudio.com/items?itemName=Tweag.vscode-nickel)
extension. I personally had to install the LSP seprately 
via cargo with `cargo install nickel-lang-lsp` but YMMV.