## My dotfiles collection

This is a set of configuration files that I use for my X desktop, an Ubuntu 16.04 machine. The cast of
characters includes:

* i3 tiling window manager (the [i3-gaps fork](https://github.com/Airblader/i3))
* [i3-blocks](https://github.com/vivien/i3blocks) for status
* [font-awesome](http://fontawesome.io) for icons
* [compton](http://lubuntu.me/meet-compton/) for composing windows
* [variety](http://peterlevi.com/variety/how-to-install/) for backgrounds
* [gnome-terminal](https://git.gnome.org/browse/gnome-terminal/) for a terminal emulator
* [gruvbox](https://github.com/morhetz/gruvbox) color scheme for Vim (also available for [i3](https://github.com/acrisci/i3-style))
* [spotify](http://spotify.com), [dropbox](https://www.dropbox.com/install-linux), and [evernote](http:./evernote.com) of course
* [workrave](http://www.workrave.org/) to stand up every once in a while
* [hack](https://github.com/chrissimpkins/Hack) and [Ohsnap](https://sourceforge.net/projects/osnapfont/) fonts for terminal and status, respectively
* [vundle](https://github.com/VundleVim/Vundle.vim) plugins:  [airline](https://github.com/vim-airline/vim-airline), [nerdtree](https://github.com/scrooloose/nerdtree), [jedi-vim](https://github.com/davidhalter/jedi-vim)
* [davmail](http://http://davmail.sourceforge.net/) for LDAP and caldav translation.
* [vimium](https://vimium.github.io/) for chrome
* [neomutt](https://www.neomutt.org/) for mail, thanks to the great folks there for keeping the flame alive
* [calcurse](http://calcurse.org/) with [caldav](https://github.com/lfos/calcurse/tree/master/contrib/caldav), see below


## Mutt address completion with Office 365 and LDAP

I've yet to see a good writeup of how to do this, so here's the method
I used.

First run [davmail](http://http://davmail.sourceforge.net/) and
configure it with the LDAP box checked (I start it in my .local/i3/config).

Use the version of ldap.pl in this repo to set the
```query_command
```
option in mutt. This will enable the completion of addresses after you type a name and hit <tab>.  See the
config files in mutt/ and scripts/ for details.

## Calcurse with Office 365

One of the major drawbacks of [calcurse](http://calcurse.org/) is that
it doesn't understand timezones.  Stupidly, this caused me to miss a
meeting once.  Only once.  Follow this process to use calcurse for at
least a daily view of your calendar items.

* Install and initialize [caldav](https://github.com/lfos/calcurse/tree/master/contrib/caldav) 
according to the instructions.
* In the file ~/.calcurse/caldav/config, add the following configuration option with a path
to the ccursefix.sh file from this repo.
```
Binary = /home/username/bin/ccursefix.sh
```
* The above script will pre-process calendar files during a run of calcurse-caldav and set the
meeting times to the local timezone.  Make sure you have ccursefix.sh as well as fixtz.pl from this
repo.

Now make sure davmail is running.  I run it from i3 startup as follows:
```
exec --no-startup-id davmail /home/namato/.config/davmail/davmail.properties
```
In the properties window of davmail, ensure that LDAP and Calendar are running.

Now you can run:
```
calcurse-caldav --init=keep-remote
```
to provide a view of your calendar appointments from Office 365.  I do this in the morning
once when I login.  This solution has a few gaps, like if you accept an appointment in the same day you
might not see it.  There is a way you can add
appointments directly to calcurse from mutt, see [here](http://hentenaar.com/keeping-track-of-meetings-with-mutt-calcurse).

## Switching between notebook screen (eDP) and HDMI

There's a handy script here called 
```
switcheroo.sh
```
 that is run from <mod+shift>-s in i3 which toggles the screen between dual, extend, and one or the other.
This is useful when bringing your laptop to meeting rooms and replugging/unplugging at your desk.  


## Screenshot

![screenshot](images/ss2.png)
