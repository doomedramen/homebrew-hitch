# Cask published with desktop release workflow
# Created on 2026-04-18

cask "hitch-desktop" do
  version "v0.0.7"
  sha256 "0c16d231ad0fe0b65ff729820e6f4cfbf5a245e1b18e0c456590afe65de73cdb"

  url "https://github.com/doomedramen/hitch/releases/download/desktop-v0.0.7/Hitch.Desktop_0.0.6_aarch64.dmg"
  name "Hitch Desktop"
  desc "Git branch management for environment-based deployments"
  homepage "https://github.com/doomedramen/hitch"

  artifact :app, target: "Hitch Desktop.app"

  uninstall quit: "com.doomedramen.hitchdesktop"
end
