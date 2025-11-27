class Hitch < Formula
  desc "A CLI tool for managing environment-specific git branches and metadata"
  homepage "https://github.com/doomedramen/hitch"
  version "1.2.15"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/doomedramen/hitch/releases/download/v1.2.15/hitch-aarch64-apple-darwin.tar.xz"
      sha256 "684a26ef3fc80fc5ab3c853be1e3b70c9b8d4937c8610798ebaf90e7075ff514"
    end
    if Hardware::CPU.intel?
      url "https://github.com/doomedramen/hitch/releases/download/v1.2.15/hitch-x86_64-apple-darwin.tar.xz"
      sha256 "a964472808a3957f85c2c4199811324e1493bf93d60cf02d8257677214b40ed4"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/doomedramen/hitch/releases/download/v1.2.15/hitch-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "29c73ee30bf84cfae9489b5c0361a654e6dc3f35bcd35cf81b8ab70dedfb588d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/doomedramen/hitch/releases/download/v1.2.15/hitch-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e54b36f3569abb0fa526860cd8117d56f52b38442b0096b68a49eb3a574c30c7"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
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
