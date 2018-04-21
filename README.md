# wwine - a wrapper for wine

wwine (wrapped wine) is a wrapper for the Windows compatibility layer
[wine](http://www.winehq.com/). It wraps various flavours of wine into a
single unified interface, complete with full bottle support for all of them.

It integrates well with how the various flavours mange their bottles, so for
instance applications isntalled using crossover will be manageable through the
usual crossover interface.

For vanilla wine, lutris and PlayOnLinux it uses WINEPREFIX to achieve bottle
support, creating bottles as ~/.wwinebottles/[BOTTLE NAME]

It supports the following flavours of wine:

- [vanilla wine (winehq)](http://www.winehq.com/)
- [wine-staging](https://github.com/wine-staging/wine-staging)
- [Crossover](https://codeweavers.com/)
- [wine from lutris](https://lutris.net/)
- [wine from PlayOnLinux](https://www.playonlinux.com/en/)
