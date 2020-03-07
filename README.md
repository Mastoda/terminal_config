# terminal_config
This is my terminal configuration to work with tmux, powerline, tty, fbterm.

And my vimrc also

### STEPS:

#### 1. Powerline, fbterm, tmux

Install fbterm, tmux and powerline.
Usually these are packages which exists in any linux source repositories but powerline you can install using python-pip which is also usually a linux repository package.
I could not find tmux/powerline.conf in the powerline installed by package managerso I did not use it.

Then you can run:
```bash
sudo PACKAGE_MANAGER install fbterm python-pip
sudo pip install git+git://github.com/Lokaltog/powerline
```
After that you can run fbterm as a non-root user, do:
```bash
sudo gpasswd -a YOUR_USERNAME video
```
To enable keyboard shortcuts for non-root users, do:
```bash
sudo setcap 'cap_sys_tty_config+ep' /usr/bin/fbterm
```
or
```bash
sudo chmod u+s /usr/bin/fbterm
```

after this you can:
```bash
source ~/.bashrc
```

#### 2. Vim

Here you just need to enter `vim` and run:
```
:PlugInstall
```
Maybe you will need to install some missing packages with your package manager and also the youcompleteme plug which you should run:
```
cd ~/.vim/plugged/youcompleteme
.\install.sh
# OR
python3.7 install.py #recommended
```
