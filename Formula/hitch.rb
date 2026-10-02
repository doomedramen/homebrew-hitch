class Hitch < Formula
  desc "A CLI tool for managing environment-specific git branches and metadata"
  homepage "https://github.com/doomedramen/hitch"
  version "2.0.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/doomedramen/hitch/releases/download/v2.0.0/hitch-aarch64-apple-darwin.tar.xz"
      sha256 "f9c34211b32f360fbc7a12c794457e70dd56300ba642fd1a99570b03393d4836"
    end
    if Hardware::CPU.intel?
      url "https://github.com/doomedramen/hitch/releases/download/v2.0.0/hitch-x86_64-apple-darwin.tar.xz"
      sha256 "513a7b81206a071faf22bf94b773179b65bd351f8e08c4310141c49600fc4a6d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/doomedramen/hitch/releases/download/v2.0.0/hitch-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "2bb43e28d73d3d5ac29d03f35bb2a95da4094bdf47982f9aa51590b579c81dd8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/doomedramen/hitch/releases/download/v2.0.0/hitch-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d8d42e9411e8dd8e27dd2796f2ac79f18ac50e0794bd4afc54c58e4e0a8ef8fa"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "hitch"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "hitch"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "hitch"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "hitch"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
