# Keyboard Deck

Have you ever felt the need to have a bongocat typing as you type? No? Well, probably you need it anyway.

Keyboard deck is a simple application that supports **Windows, Mac OS, Linux, Android and IOS** and, at least for now, only shows a BongoCat typing as you type. The initial idea is taken from [here](https://www.reddit.com/r/MechanicalKeyboards/comments/h0a7kq/i_made_an_oled_animation_of_bongo_cat_that/).

**Its main purpose is to give a use to unused devices**, in fact, **the keystokes are sent from your computer to any device you want via UDP**.

## Installation

First of all, you need to install and run [KeyboardDeck-Server](https://github.com/FrancescoCaracciolo/KeyboardDeck-Server) on your main device, where the keyboard is attached to.

After running both Capture and Server, you can run the app on your device, go to settings and input the Address of the server.

## Security concerns

The app is not complete yet, and many things are waiting to be added. 
At the moment, it sends using unencrypted UDP requests anything you type, and it wouldn't be very hard to intercept the content of these requests for someone on your LAN.
**For the moment, it is strongly advised to not run the script over the internet, but only in lan.**

## Planned features

- [X] Fix images glitch
- [X] Add more themes
- [ ] Add different themes from just Bongocats
- [ ] Give an actual utility to this thing
- [ ] Add music visualizers
- [ ] Automatically detect servers on your local network