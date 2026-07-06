# Cask published with desktop release workflow
# Created on 2026-07-06

cask "hitch-desktop" do
  version "v0.0.12"
  sha256 "98769165a105dc7405af22150b2485b9e015975f20e42000f5c4e4e7a840175e"

  url "https://github.com/doomedramen/hitch/releases/download/desktop-v0.0.12/Hitch-Desktop_0.0.12_aarch64.dmg"
  name "Hitch Desktop"
  desc "Git branch management for environment-based deployments"
  homepage "https://github.com/doomedramen/hitch"

  app "Hitch Desktop.app"

  uninstall quit: "com.doomedramen.hitchdesktop"
end
