# Cask published with desktop release workflow
# Created on 2026-07-06

cask "hitch-desktop" do
  version "v0.0.10"
  sha256 "f2f0bb060bf6cf019f5e58baa3b640012f10e3b3814f4dbd86ef433a70b25ac3"

  url "https://github.com/doomedramen/hitch/releases/download/desktop-v0.0.10/Hitch%20Desktop_0.0.10_aarch64.dmg"
  name "Hitch Desktop"
  desc "Git branch management for environment-based deployments"
  homepage "https://github.com/doomedramen/hitch"

  app "Hitch Desktop.app"

  uninstall quit: "com.doomedramen.hitchdesktop"
end
