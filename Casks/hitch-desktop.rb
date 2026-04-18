# Cask published with desktop release workflow
# Created on 2026-04-18

cask "hitch-desktop" do
  version "v0.0.7"
  sha256 "ffaca1c8bf0d995c458a03900a71838e30e8667d8e2eafd914a6e4244ce94c8f"

  url "https://github.com/doomedramen/hitch/releases/download/desktop-v0.0.7/Hitch%20Desktop_0.0.7_aarch64.dmg"
  name "Hitch Desktop"
  desc "Git branch management for environment-based deployments"
  homepage "https://github.com/doomedramen/hitch"

  artifact :app, target: "Hitch Desktop.app"

  uninstall quit: "com.doomedramen.hitchdesktop"
end
