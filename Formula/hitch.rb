class Hitch < Formula
  desc "A CLI tool for managing environment-specific git branches and metadata"
  homepage "https://github.com/doomedramen/hitch"
  version "1.2.43"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/doomedramen/hitch/releases/download/v1.2.43/hitch-aarch64-apple-darwin.tar.xz"
      sha256 "22bf9c3fd7738ae78f8af2f6f6f9a381856416fc506be229e05aed7bfb0323a9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/doomedramen/hitch/releases/download/v1.2.43/hitch-x86_64-apple-darwin.tar.xz"
      sha256 "85ede4f3c990dbb1e5698c2df5fabb78c8e482fb4542ed55a4d7877ff5a96d88"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/doomedramen/hitch/releases/download/v1.2.43/hitch-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "65625c95d3616036534172b485a3914ea89555ad2edcbd2f40f28d89d9ff84a0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/doomedramen/hitch/releases/download/v1.2.43/hitch-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "4359738882e4da754a122825dce4c544b8c333ff12923b14ff14459a31ce5490"
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
    bin.install "hitch" if OS.mac? && Hardware::CPU.arm?
    bin.install "hitch" if OS.mac? && Hardware::CPU.intel?
    bin.install "hitch" if OS.linux? && Hardware::CPU.arm?
    bin.install "hitch" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
