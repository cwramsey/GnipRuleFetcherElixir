# Gnip Rules - In Elixir

Fetches GNIP rules and pretty prints them to the terminal

## Installation

Run `mix deps.get` to install dependencies.

Compile with `mix escript.build`.

Run with `./gnip --network=somenetwork`

## Options

`--network` The network you want to fetch.

These match to the networks in you `config/config.exs` file. See `config/sample.exs` for config layout.

## TODO

* Write tests
* Get rid of `def start`
* Error checking
