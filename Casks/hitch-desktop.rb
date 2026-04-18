# Cask published with desktop release workflow
# Created on 2026-04-18

cask "hitch-desktop" do
  version "0.0.5"
  sha256 "20c4789ff9eb5a07ad33e9daa51439b54a102d3c11f0a090a0b7df11c3d213c8"

  url "https://github.com/doomedramen/hitch/releases/download/desktop-v0.0.5/Hitch.Desktop_0.0.5_aarch64.dmg"
  name "Hitch Desktop"
  desc "Git branch management for environment-based deployments"
  homepage "https://github.com/doomedramen/hitch"

  app "Hitch Desktop.app"

  uninstall quit: "com.doomedramen.hitchdesktop"
end
