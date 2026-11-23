cask "ramify" do
  version "0.2.0"
  sha256 "dc16b8f06136fa99ceb8ad15b4f98ed822a1cdf147a034fe77f6d3296cd2e922"

  url "https://github.com/ALMAZY/ramify/releases/download/v#\{version\}/Ramify_#\{version\}_universal.dmg"
  name "Ramify"
  desc "Keyboard-first mind map for fast notes"
  homepage "https://github.com/ALMAZY/ramify"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :big_sur"

  # Ramify updates itself from inside the app.
  auto_updates true

  app "Ramify.app"

  # The app is ad-hoc signed, not notarized (no paid Apple Developer ID yet).
  # Removing the quarantine flag lets it open without the "Open Anyway" step.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Ramify.app"],
                   sudo: false
  end

  zap trash: [
    "~/Library/Application Support/io.github.almazy.ramify",
    "~/Library/Caches/io.github.almazy.ramify",
    "~/Library/WebKit/io.github.almazy.ramify",
    "~/Library/Saved Application State/io.github.almazy.ramify.savedState",
  ]
end
