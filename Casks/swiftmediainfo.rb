cask "swiftmediainfo" do
  version "2.0"

  # Replace with the output of:
  #   shasum -a 256 SwiftMediaInfo-2.0.dmg
  sha256 "76b4688e53d1192301b6296a8fed6120a78a4e2cce7f78a1090ed7b643a609b3"

  url "https://github.com/Undisclosed0369/SwiftMediaInfo/releases/download/v#{version}/SwiftMediaInfo-#{version}.dmg",
      verified: "github.com/Undisclosed0369/SwiftMediaInfo/"

  name "SwiftMediaInfo"
  desc "Native macOS front-end for the MediaInfo command-line tool"
  homepage "https://undisclosed0369.app/swiftmediainfo/"

  # Where `brew upgrade` looks to find out whether a newer version exists.
  # Reads the GitHub releases page rather than a version file, so publishing a
  # release is the only thing that has to happen for upgrades to be offered.
  livecheck do
    url :url
    strategy :github_latest
  end

  # MediaInfo does the actual reading. The app checks for it on launch and
  # offers to install it, but declaring it here means someone installing
  # through Homebrew never sees that prompt — the dependency arrives first.
  depends_on formula: "mediainfo"

  depends_on macos: ">= :tahoe"
  depends_on arch: :arm64

  app "SwiftMediaInfo.app"

  # WHY THIS IS HERE
  #
  # The app is not signed with an Apple Developer certificate. Homebrew used to
  # offer `--no-quarantine` for exactly this situation; that flag was removed in
  # 4.7, and unsigned casks are being dropped from the official tap altogether.
  #
  # Without this step, `brew install` would put the app in place and macOS would
  # then refuse to open it — an install that does not install. So the cask
  # removes the quarantine flag itself, and the caveat below says so in plain
  # words rather than letting it happen quietly.
  #
  # This block disappears the day the app is signed.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/SwiftMediaInfo.app"]
  end

  uninstall quit: "app.undisclosed0369.SwiftMediaInfo"

  # `brew uninstall --cask --zap` territory: everything the app leaves behind.
  # Deliberately does NOT touch anything of the user's own — no media files, no
  # exported reports, no MediaInfo. Only this app's own state.
  zap trash: [
    "~/Library/Preferences/app.undisclosed0369.SwiftMediaInfo.plist",
    "~/Library/Caches/app.undisclosed0369.SwiftMediaInfo",
    "~/Library/HTTPStorages/app.undisclosed0369.SwiftMediaInfo",
    "~/Library/Saved Application State/app.undisclosed0369.SwiftMediaInfo.savedState",
  ]

  caveats <<~EOS
    SwiftMediaInfo is not signed with an Apple Developer certificate, so macOS
    would normally refuse to open it. This cask has removed the quarantine flag
    from the installed app so that it launches:

      xattr -dr com.apple.quarantine #{appdir}/SwiftMediaInfo.app

    That command tells macOS to stop checking a file, and it is not something to
    run on software you have no reason to trust. The reason to trust this one is
    that the source is public — read it, or build it yourself:

      https://github.com/Undisclosed0369/SwiftMediaInfo

    Why the warning exists, and why it is worth taking seriously elsewhere:

      https://undisclosed0369.app/swiftmediainfo/download.html
  EOS
end
