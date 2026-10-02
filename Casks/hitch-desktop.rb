# Cask published with desktop release workflow
# Created on 2026-10-02

cask "hitch-desktop" do
  version "v0.0.13"
  sha256 "deb7ae39b49ca3508be2d1a947ea4fb5c4c33999a7c19e32f3e329d4301f8557"

  url "https://github.com/doomedramen/hitch/releases/download/desktop-v0.0.13/Hitch-Desktop_0.0.13_aarch64.dmg"
  name "Hitch Desktop"
  desc "Git branch management for environment-based deployments"
  homepage "https://github.com/doomedramen/hitch"

  app "Hitch Desktop.app"

  uninstall quit: "com.doomedramen.hitchdesktop"
end
