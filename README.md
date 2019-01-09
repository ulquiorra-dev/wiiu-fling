# wiiu-fling
A (dkp)-pacman for Wii U tools, libraries and toolchains

## About/Rationale
For a good while now, Wii U homebrew has used ad-hoc methods for handling
dependencies, libraries and toolchains - installing untracked files into /opt,
sharing around zips containing binary files, and plenty of other methods. This
leads to people having vastly different environments, toolchains and setups;
frequently in conflict with each other.

devkitPro has recently switched to pacman for managing its toolchains and
libraries, so it makes sense for Wii U developers to do the same! Fling is a
collection of PKGBUILDs and GitLab CI scripts that allow us to do just that.
You can add fling as a repository to any pacman, devkitPro or otherwise, and
start installing a wide range of Wii U-related packages! Fling has packages for
wut, sdl2-wiiu, libdynamiclibs, libiosuhax, libutils and more! If a package you
want is missing from both devkitPro's repositories and Fling's, feel free to
[file an issue](https://gitlab.com/QuarkTheAwesome/wiiu-fling/issues).

Due to a lack of support from wut, Fling does not ship any Windows-specific
packages. For Windows 10, I recommend using
[WSL](https://docs.microsoft.com/en-us/windows/wsl/install-win10); older
versions of Windows will require a
[virtual machine](https://www.psychocats.net/ubuntu/virtualbox). Make sure to
install devkitPro inside your new Linux platform.

OSX support is still experimental - depending on the package, you may have to do
some extra work (such as setting the `WUT_ROOT` environment variable).

## Installing
Fling is a normal pacman repo, so installing it is simply a matter of editing a
few config files. Make sure you have devkitPro installed and working before
trying this.

When I write `(dkp)-pacman` below, subsitute `dkp-pacman` or `pacman` as
appropriate, depending on how devkitPro packages are installed on your system.

First, install the Fling signing key:
```shell
(dkp-)pacman-key --recv-key 6F986ED22C5B9003
```
`6F986ED22C5B9003` is the keyid for Fling's key, used to sign all our packages.
If that command gives an error, try:
```shell
curl https://fling.heyquark.com/fling-key.pub | (dkp-)pacman-key -a -
```
Once the key is installed, sign it to make it trusted:
```shell
(dkp-)pacman-key --lsign 6F986ED22C5B9003
```
Packages from Fling will now be trusted by pacman!

Now, open your pacman configuration file:
 - On systems where `pacman` installs devkitPro packages, this is
 `/etc/pacman.conf`
 - On systems where `dkp-pacman` installs devkitPro packages, this is
 `/opt/devkitpro/pacman/etc/pacman.conf`

For example, the command `nano /etc/pacman.conf` would use `nano` to edit the
pacman configuration on a native-pacman system, while
`vim /opt/devkitpro/pacman/etc/pacman.conf` would use `vim` to do the same on a
`dkp-pacman` system.

Once in your config file, scroll to the bottom and add the following lines:
```ini
[wiiu-fling]
Server = https://fling.heyquark.com
```

Save and exit (using Nano this is Ctrl-X, Y, Enter; on Vim this is :wq) then run
the following to check it worked:
```shell
(dkp-)pacman -Syu
```
You should see a "wiiu-fling" entry downloading during the "Synchronizing
package databases" step.

Congrats! You can now use `(dkp-)pacman -S <package>` to install any of our
available packages!

## For Homebrew Developers
There's a few small things different about wiiu-fling compared to traditional
methods. For example, in order to avoid messing with Wii or GameCube programs,
all Wii U-only libraries (libiosuhax, sdl2, etc.) are installed to
`/opt/devkitpro/portlibs/wiiu`; rather than the usual
`/opt/devkitpro/portlibs/ppc`. You'll have to add this path to your Makefile or
CMakeLists.txt in order to link with wiiu-fling's libraries.

For example, vgmoose was able to adapt their app, hb-appstore, to work with
Fling in
[this commit](https://github.com/vgmoose/hb-appstore/commit/520efb9d7065e72e55f83cd575f0f9de0c54c06e).
If you do the same, please link to this page rather than writing instructions to
install the wiiu-fling repository (
[vgmoose has since done this!](https://github.com/vgmoose/hb-appstore/commit/e16f6fec893b284403e8758acb7edb47b5db1b6b))
That said, including a list of packages to install is a great idea!

Let me know if one of your projects ends up with a simple commit to add fling to
a wut CMakeLists.txt file, and I'll add it here.

We also ship `wiiu-pkg-config`, which wraps the system pkg-config to work with
the packages in `$DEVKITPRO/portlibs/wiiu` and `$DEVKITPRO/portlibs/ppc`. When
used in your build system, `wiiu-pkg-config` can manage the compiler and linker
flags for your libraries.

Fling isn't purely for Wii U-specific libraries: one of the goals here is to
compile all Wii U homebrew purely with packages from the devkitPro or Fling
repos. To that end, a few packages have been submitted to devkitPro for
upstreaming. Sometimes this takes a while, so Fling can sometimes provide
"transitional" packages - the same package as the devkitPro version, but with a
spoofed version number such that devkitPro's version will overwrite any
transitional packages on release. You'll get a warning when one of these are
installed. These are purely intended as stopgaps until devkitPro upstreams an
equivalent package.

## License and Contact
Everything that I've written here (CI scripts, PKGBUILDs, etc.) is public
domain as writen in [LICENSE.md](LICENSE.md). I may need to sublicense in other
places (e.g. devkitPro upstreams), but generally just do whatever. I appreciate,
but don't require, credit when appropriate.

You can find me at all the places listed on my
[website](https://heyquark.com/aboutme) - feel free to reach out with comments,
questions, conversation, memes, whatever.
