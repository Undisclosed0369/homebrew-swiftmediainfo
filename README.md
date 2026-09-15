# SwiftMediaInfo — Homebrew tap

The Homebrew cask for **[SwiftMediaInfo](https://undisclosed0369.app/swiftmediainfo/)**, a native macOS front-end for MediaInfo.

## Install

```bash
brew tap --trust undisclosed0369/swiftmediainfo
brew install --cask swiftmediainfo
```

MediaInfo is declared as a dependency, so Homebrew installs it for you if you do not already have it.

## Update

```bash
brew update
brew upgrade --cask swiftmediainfo
```

## Uninstall

```bash
brew uninstall --cask swiftmediainfo
```

To remove its settings and cached data as well:

```bash
brew uninstall --cask --zap swiftmediainfo
```

The zap removes only this app's own state. It does not touch your media files, your exported reports, or MediaInfo.

---

## Why `--trust`

Since Homebrew 6.0, a tap that is not one of the official ones has to be trusted before Homebrew will run any code from it. That is a good change: a cask is a Ruby file that executes on your machine, not a download link, and it is right that you say yes to that once rather than implicitly every time.

`brew tap --trust undisclosed0369/swiftmediainfo` is you saying yes to this one.

---

## Links

- **[Website](https://undisclosed0369.app/swiftmediainfo/)**
- **[Main repository](https://github.com/Undisclosed0369/SwiftMediaInfo)**
- **[Issues](https://github.com/Undisclosed0369/SwiftMediaInfo/issues)** — please report problems there rather than here, unless they are about the cask itself
