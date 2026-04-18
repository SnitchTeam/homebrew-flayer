cask "flayer" do
  version "1.1"
  sha256 "a3fb85606fb97fafbf9d111447b9c933ba21422d4c5c2deefcdb6817defdb52b"

  url "https://github.com/SnitchTeam/flayer/releases/download/v#{version}/FlaYer-#{version}.dmg"
  name "FlaYer"
  desc "Native macOS music player for audiophiles"
  homepage "https://github.com/SnitchTeam/flayer"

  depends_on macos: ">= :sonoma"

  app "FlaYer.app"

  postflight do
    # Ad-hoc signed build (no paid Apple Developer account), so Gatekeeper
    # would otherwise refuse to launch it. Homebrew Cask is trusted to strip
    # the quarantine attribute on its managed apps, turning `brew install`
    # into a one-step flow.
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/FlaYer.app"],
                   sudo: false
  end

  zap trash: [
    "~/Library/Application Support/FlaYer",
    "~/Library/Caches/CoverArt",
    "~/Library/Containers/com.flayer.macos",
    "~/Library/Group Containers/group.com.flayer",
    "~/Library/Preferences/com.flayer.macos.plist",
  ]
end
