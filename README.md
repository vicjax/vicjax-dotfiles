# :rose::rose::rose:vicjax.dotfile :smile::smile::smile: #

This is a dotfile that config your terminal.

A dotfile like `.vimrc`, `.bashrc`...which is a custom configuration file for an application.

Sometimes we need to config our environment and applications even our systems, but when we need to know when and what changed have been done after once or more times config, or we need to use the same configuration in other systems, this makes things difficult. So we using git to manage these configuration files.

Now you can use this to create, copy, restore your configuration quickly and efficiently.

## :hand:Getting Started :orange_book:

You need to download or clone this repository first:

- using git by `git clone https://github.com/vicjax/vicjax-dotfiles.git`;
- or download .zip by click [vicjax-dotfile](https://github.com/vicjax/vicjax-dotfiles/archive/master.zip and unzip it.)

## :hand:Prerequisites:orange_book:

Before you config your software using `.dotfiles`, you should make sure you have installed that:

- the necessary tools `curl` or `wget` and `git`;
- the software you want to config like `vim` `neovim` ...

Also, you can use the script `appcheck.sh` to check and install the above software you just need to execute in the terminal:

```sh
cd /the/path/to/vicjax-dotfiles/
./appcheck.sh
```

and follow the prompts to continue.

> Note:speech_balloon:: This script can work if you use one of the following package managers:
>
> - apt or apt-get
> - yum
> - pacman

## :hand:Using dotfiles:orange_book:

> you can select the app you want to config by edit the file: `apps_want2config`

Make sure you prepare to config your apps,you just need excute in terminal:

```sh
cd /the/path/to/vicjax-dotfiles/
./install.sh
```
