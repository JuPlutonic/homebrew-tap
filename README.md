# Custom Formulae

Originally cr8d by laggardkernel as a place for:

- Homebrew commands removed from [there](https://github.com/Homebrew/brew).

- Mac-centric formulas with options (passed away in original Homebrew-core repo).

- DNS cli-apps, Python package managment.

This tap will be more Linuxbrew-core centric, w/o intention to lose darwin platform
compabillity.

All Python's whistles and bells were removed, formulas-with-options only for Mac
also were deleted.

## News

   Big changes made in this repo.

~~~
- 2021-04-16
  - Readme was fixed, adguard was fixed
      dns- and options-formulae were upd, brew-gem was removed
- 2021-04-15 mpdscribble formula
- 2021-04-14 smlnj formula, trouble to get in work on linux
- 2021-04-13
  - New Readme, first watchlists for Homebrew's livecheck
      python's venv/conda, casks/formulas w/ options only for Mac were removed.
  - Backported new updates from original repo.
- 12-01-2020
  - `Homebrew.args` is deprecated in 2.6.0.
      Pass value into formula build with
      `--with-key=value` is not possible anymore.
~~~

## Installation

```bash

brew tap juplutonic/homebrew-tap
brew install juplutonic/homebrew-tap/<formula>

```

## External Commands

- switch ```brew switch```, the old goodie dropped by brew in 2.6.0;

- fix-perm ```brew fix-perm```, fix formula file perms broke by ```sudo brew services```;

- git-gc `brew git-gc`, copied from ymyzk/homebrew-ymyzk, original tap removed;

- pip `brew-pip`, official repo's [brew pip](https://github.com/josegonzalez/brew-pip),
   doesn't work / [my PR](https://github.com/josegonzalez/brew-pip/pull/2), works.

## The workflow to manage my tap

Check the `Livechecks/` folder for watchlists:

* * *

- 1 `brew livecheck brew-pip`

- 2_maintained_formulas

- 3_options_formulas

- 4_dns_formulas

- 🕗️Coming soon: 5_maintained_linuxbrew_formulas

- 🕗️Coming soon: 6_maintained_linuxbinary_formulas

Command ([more info about usage of the Homebrew Livecheck][Homebrew/Livecheck]):

```bash
# cd into the folder, in which
# you cloned Homebrew-tap / copied Livechecks/ folder, then run
brew livecheck < Livechecks/3_options_formulas
# or
brew livecheck --tap=juplutonic/homebrew-tap

```

## Formulae

  Check the `Formula/` folder:
* * *

### 🛡️ Adguard Home DNS

> TODO: livecheck. \
> GPL-3.0 License.

### 🔲🔘🔳 Aria2

> `aria2-options`
> - Header 'Want-Digest' is removed;
> - `--with-gnutls` (no TLSv1.3 support in appletls).
> * * *
> Livecheck ✔️ \
> GPL-2.0-or-later.

### 🛠 Bing Wallpaper

> `bing-wallpaper` \
> `--HEAD` only

### 🛠 BrowserSh

> 🕗️Coming soon

### 🛡️ CDNS

### 🛡️ ChinaDNS

> `chinadns`, fork [aa65535/ChinaDNS][aa65535/ChinaDNS].
> - more exact [17mon/china_ip_list][17mon/china_ip_list] is recommended.

### 🛠 Cht.Sh

> 🕗️Coming soon

### 🛡️ ClashPremium

> TODO: livecheck. \
> GPL-3.0 License.

### 🛡️ CureDNS

> [cdns][curedns], filter poisoned result with EDNS option.
> - fails to build from `--HEAD` for the time being.

### 🔲🔘🔳 cURL

> `curl-options`: \
> `--with-brotli`, lossless compression support; \
> `--with-c-ares`, C-Ares async DNS support; \
> `--with-gssapi`, GSSAPI/Kerberos authentication support; \
> `--with-libidn`, international domain name support; \
> `--with-libmetalink`, Metalink XML support; \
> `--with-libssh2`, scp and sftp support; \
> `--with-libressl`, LibreSSL instead of Secure Transport or OpenSSL; \
> `--with-nghttp2`, HTTP/2 support (requires OpenSSL or LibreSSL); \
> `--with-openldap`, OpenLDAP support; \
> `--with-openssl@1.1`, OpenSSL 1.1 support; \
> `--with-rtmpdump`, RTMPDump support.
> * * *
> Livecheck ✔️ \
> curl License.

### 🛡️ curl-doh

### 🔲🔘🔳 🛡️ DNSmasq

> `dnsmasq-options`:
> - `--with-dnssec`;
> - `--with-libidn`.
> * * *
> Livecheck ✔️ \
> GPL-2.0-only or GPL-3.0-only.

### 🛡️ dns-over-https

> Livecheck ✔️ \
> MIT.

### 🛡️ doh-proxy

### 🛠 Git Log Compact

> git-log-compact:
> - [Fork ofbcxw42/git-log-compact][cxw42/git-log-compact], with added options.
> `--HEAD` only.

### 🛠 Git Open

> git-open from paulirish/git-open support open repo, branch, issue from terminal.

### 🛠 Grc

> Rust implementation of git-cz, standard git commit.

### 🔲🔘🔳 FFMpeg

> `ffmpeg-options`: \
> --with-chromaprint - the Chromaprint audio fingerprinting library; \
> --with-decklink - DeckLink support; \
> --with-fdk-aac - the Fraunhofer FDK AAC library; \
> --with-game-musi-emu - Game Music Emu (GME) support; \
> --with-librsvg - SVG files as inputs via librsvg; \
> --with-libssh - SFTP protocol via libssh; \
> --with-openh264 - OpenH264 library; \
> --with-openssl - SSL support; \
> --with-rtmpdump - RTMPDump support; \
> --with-zeromq - using libzeromq to receive ZeroMQ-commands; \
> --with-zimg - z.lib zimg library; \
> --with-libvmaf - libvmaf scoring library.
> * * *
> Livecheck ✔️ \
> GPL-2.0-or-later License.

### 🛠 FilebrowserBin

> **filebrowser-bin**
> * * *
> Livecheck  ✔️ \
> Apache-2.0 License.

### 🛡️ iTerm2 ZModem

> **iterm2-zmodem** \
> The script to send/recieve files, exchange can be done with remote 💻️, \
> that have installed `lrzsz` app on it. \
> `--HEAD` only.
> * * *
> No license.

### 🛠 License

> It is nishanths's [license][license] script, usage: \
> `license mit > LICENSE.txt`
> * * *
> Livecheck ✔️ \
> MIT.

### 🛡️ MEOW

> **meow** \
> Works as a proxy or as a direct connect according to geolocation, \
> it is a fork of COW that uses whitelist mode. See [MEOW's site][meow]. \
> `--HEAD` only.
> * * *
> TODO: livecheck. \
> BSD-2-Clause License.

### 🛡️ MosDNS

> **mosdns-bin** \
> Older versions called `mos-chinadns-bin`.
> * * *
> Livecheck ✔️ \
> GPL-3.0 License.

### 🛠 mpdscribble

> **mdpscribble** is a `MPD scrobbler`
> * * *
> TODO: transfer to linuxbrew-core. \
> Livecheck ✔️ \
> GPL-2.0 License.

### 🛠 Nali

> Livecheck ✔️ \
> MIT.

### 🔲🔘🔳 OpenSSH

> `openssh-options`:
> - `--with-libressl`
> * * *
> Livecheck ✔️ \
> SSH-OpenSSH License.

### 🛡️ Overture

> TODO: linux install. \
> Livecheck ✔️ \
> MIT.

### 🛠 Pipe-viewer

> **pipe-viever** (former straw-viewer, former youtube-viewer).
> A lightweight YouTube client for Linux. \
> `--HEAD` only.
> * * *
> TODO: transfer to linuxbrew-core. \
> Livecheck ✔️ \
> Artistic-2.0 License / GPLv1.

### 🛠 plan9port

> Standalone `Plan 9 from User Space` working over 9p protocol. \
> See [original jacobvosmaer's formula][jacobvosmaer_plan9port].
> * * *
> TODO: PR to jacobvosmaer / linuxbrew-core. \
> Livecheck ✔️ \
> MIT.

### 🛠 QWT

> 🕗️Coming soon

### 🛡️ Pcap DNS proxy

### 🔲🔘🔳 Ranger

> **ranger-fm** with optional dependencies:
> - `chardet` for better encoding detection;
> - `Pillow` (depended by image preview in kitty); \
> `--HEAD` only.
> * * *
> TODO: add livecheck, do tTerm2+python3 errors appears? \
> GPL-3.0 License.

### 🛡️ Routedns

### 🛡️ sans

> [sans][sans]

### 🛡️ ShDNS

> [shdns][shdns], A port of ChinaDNS (DNS filter) in golang with IPv6 support.
> Only works if shdns-bin is installed (with `brew install`).

### 🛠 SML NJ

> **smlnj** \
>Standard ML of New Jersey. \
> For darwin see [macports][smlnjs].
> * * *
> TODO: transfer to linuxbrew-core because it now x86_64. \
> Livecheck ✔️ \
> BSD like.

### 🛠 sshpass

> [sshpass][sshpass] is easier, less secure way to do SSH-authentification,
> mostly for home use. Will not be maintained in official Homebrew repos.
> * * *
> Livecheck ✔️ \
> GPLv2 License.

### 🔲🔘🔳 tmux

> `tmux-options`:
> - `--with-fps=`, `--with-fps=30` custom FPS 30, default 10.
> * * *
> Livecheck ✔️ \
> ISC License.

### 🔲🔘🔳 🛡️ Unbound

> Livecheck ✔️ \
> BSD-3-Clause.

### 🛡️ V2ray2Clash

> [Ne1llee's v2ray2clash][v2ray2clash] a web API used to convert v2ray and ssr
> subscription lists into clash, QuantumultX format (for VPN creation). \
> `--HEAD` only.

* * *

## References

- [Formula Cookbook](https://docs.brew.sh/Formula-Cookbook)

- [Formula API](https://rubydoc.brew.sh/Formula)

- [example-formula.rb](https://github.com/syhw/homebrew/blob/master/Library/Contributions/example-formula.rb)

[aa65535/ChinaDNS]: https://github.com/aa65535/ChinaDNS

[curedns]: https://github.com/semigodking/cdns

[17mon/china_ip_list]: https://github.com/17mon/china_ip_list

[cxw42/git-log-compact]: https://github.com/cxw42/git-log-compact

[license]: https://github.com/nishanths/license

[Homebrew/Livecheck]: https://docs.brew.sh/Brew-Livecheck

[meow]: https://github.com/netheril96/MEOW

[jacobvosmaer_plan9port]: https://github.com/jacobvosmaer/homebrew-stuff

[sans]: https://github.com/puxxustc/sans

[shdns]: https://github.com/domosekai/shdns

[smlnjs]: https://ports.macports.org/port/smlnj/summary

[sshpass]: https://sourceforge.net/projects/sshpass/

[v2ray2clash]: https://github.com/xch04028/v2ray2clash

> TODO: Transfer non-DNS binaries to [homebrew-linuxbinary](https://github.com/athrunsun/homebrew-linuxbinary)
> TODO: Transfer GNU/MIT soft to [linuxbrew-core](https://github.com/Homebrew/linuxbrew-core)
> TODO: (Optional) Add Penguin/Apple emoticons per apps.
