# Cask published with desktop release workflow
# Created on 2026-07-06

cask "hitch-desktop" do
  version "v0.0.11"
  sha256 "8366e31f7b68ce82871cd29dd22a186054fb0cd69653fdabb9549e8d5e73dd58"

  url "https://github.com/doomedramen/hitch/releases/download/desktop-v0.0.11/Hitch-Desktop_0.0.11_aarch64.dmg"
  name "Hitch Desktop"
  desc "Git branch management for environment-based deployments"
  homepage "https://github.com/doomedramen/hitch"

  app "Hitch Desktop.app"

  uninstall quit: "com.doomedramen.hitchdesktop"
end
