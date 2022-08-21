# Keyboard Deck
![GitHub all releases](https://img.shields.io/github/downloads/francescocaracciolo/KeyboardDeck-App/total)
<br />
![gif](https://media0.giphy.com/media/nYa2AaUmwKxYEBnSrW/giphy.gif?cid=790b76117d0cee5d9c7bbef071fe3039dc2311b03dd2c493&rid=giphy.gif&ct=g)
<br />

Have you ever felt the **need to have a bongocat typing as you type?** No? Well, probably you need it anyway.

Keyboard deck is a simple application that supports **Windows, Mac OS, Linux, Android and IOS** and, at least for now, only shows a BongoCat typing as you type. The initial idea is taken from [here](https://www.reddit.com/r/MechanicalKeyboards/comments/h0a7kq/i_made_an_oled_animation_of_bongo_cat_that/).

**Its main purpose is to give a use to unused devices**, in fact, **the keystokes are sent from your computer to any device you want via UDP**.
## Download
<details>
  <summary><h3>KeyboardDeck - APP</h1></summary>

<table border=4>
<thead>
<tr>
<th><img src="https://upload.wikimedia.org/wikipedia/commons/thumb/6/64/Android_logo_2019_%28stacked%29.svg/2346px-Android_logo_2019_%28stacked%29.svg.png" width=40></th>
<th><img src="https://effatta.it/wp-content/uploads/2018/10/logo-apple-ios-png-recently-2480-300x146.png" width=40></th>
<th><img src="https://pnggrid.com/wp-content/uploads/2021/06/Windows-11-Icon-Logo.png" width=40></th>
<th><img src="https://upload.wikimedia.org/wikipedia/commons/a/af/Tux.png" width=40></th>
<th><img src="https://upload.wikimedia.org/wikipedia/commons/thumb/2/22/MacOS_logo_%282017%29.svg/2060px-MacOS_logo_%282017%29.svg.png" width=40></th>
</tr>
</thead>
<tbody>
<tr>
<td><a href="https://app.keyboarddeck.space/apk">APK</a></td>
<td><a href="https://app.keyboarddeck.space/apk">IPA</a></td>
<td><a href="https://app.keyboarddeck.space/apk">exe</a></td>
<td><a href="https://app.keyboarddeck.space/apk">AppImage</a></td>
<td><a href="https://app.keyboarddeck.space/apk">idk</a></td>
</tr>
<tr>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
</tr>
<tr>
<td></td>
<td></td>
<td></td>
<td></td>
</tr>
</tbody>
</table>

</details>
<details>
  <summary><h3>KeyboardDeck - Server</h1></summary>
<table border=4>
<thead>
<tr>
<th><img src="https://pnggrid.com/wp-content/uploads/2021/06/Windows-11-Icon-Logo.png" width=40></th>
<th><img src="https://upload.wikimedia.org/wikipedia/commons/a/af/Tux.png" width=40></th>
<th><img src="https://upload.wikimedia.org/wikipedia/commons/thumb/2/22/MacOS_logo_%282017%29.svg/2060px-MacOS_logo_%282017%29.svg.png" width=40></th>
</tr>
</thead>
<tbody>
<tr>
<td><a href="https://app.keyboarddeck.space/apk">exe</a></td>
<td><a href="https://app.keyboarddeck.space/apk">AppImage</a></td>
<td><a href="https://app.keyboarddeck.space/apk">idk</a></td>
</tr>
<tr>
<td></td>
<td></td>
<td></td>
</tr>
<tr>
<td></td>
<td></td>
</tr>
</tbody>
</table>
</details>
<br />

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
