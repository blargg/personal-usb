# Status
Experimental. Making rapid changes to better support the goals.

This might mean that programs and features might be removed in future releases, though, it should always be pretty easy to add them back in.

# Goals / Roadmap

* Easy to build and install. Build and install with a few commands.
* Easy to customize. Add what ever programs and options you want, with little addtional work.
* Good defaults. The default iso should be good enough for most people.

# Implementation
## Export a module.
* This makes it easy to install the needed modules in to any configuration that
    you need.
* You can export multiple modules, one for base, one for opinionated.
* Users can import the module, then make their own changes on top of that.
* Which module will be the default?

## Nixos System
* a simple default system that people can build.


## what should this be used for?
* install nixos
* boot up your busted nixos system.
* home away from home
* read a windows install.

# How to build and install
TODO

1. Nix command to build from the git repo
2. Command to copy onto your usb.

# How to test.
TODO

Either:
* nixos-rebuild build-vm
* qemu

# How to use the base module
* example config
    + add some custom stuff that you cannot do on your own.
* build command


# TODO
[] search for all previous attempts, see what they can offer.
[] address all todos in the doc.
[] install nmap, and short guide to use it.
