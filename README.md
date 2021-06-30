# :rose::rose::rose:vicjax.dotfile :smile::smile::smile:

This is a dotfile which config your terminal.

A dotfile like `.vimrc`, `.bashrc`...which is a custom configuration file for a application.

Sometimes we need config our own enviroment and applications even our systems,but when we need know when and what changed have done after once or more times config,or we need use same configuration in ohter systerms,this make things difficult. So we using git to manage this configuration files.

Now you can use this to create,copy,restore your configuration quickly and efficiently.

## :hand:Getting Started :orange_book:

You need download or clone this repository first:

- using git by `git clone https://github.com/vicjax/vicjax-dotfiles.git`;
- or download .zip by click https://github.com/vicjax/vicjax-dotfiles/archive/master.zip and unzip it.

## :hand:Prerequisites:orange_book:

Before you config your softwares using `.dotfiles`, you should make sure you have installed that:

- the necessary tools `curl` or `wget` and `git`;
- the softwares you want to config like `vim` `neovim` ...

Also you can use the script `appcheck.sh` to check and install above software you just need execute in terminal:

```sh
cd /the/path/to/vicjax-dotfiles/
./appcheck.sh
```

and follow the prompts to continue.
> Note:speech_balloon:: This script can work if you use one of following package manager:
> - apt or apt-get
> - yum
> - pacman
## :hand:Using dotfiles:orange_book:
> you can select app you want to config by edit file : `apps_want2config`

Make sure you prepare to config your apps,you just need excute in terminal:

```sh
cd /the/path/to/vicjax-dotfiles/
./install.sh
```
