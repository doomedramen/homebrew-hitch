class Hitch < Formula
  desc "A CLI tool for managing environment-specific git branches and metadata"
  homepage "https://github.com/doomedramen/hitch"
  version "1.2.13"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/doomedramen/hitch/releases/download/v1.2.13/hitch-aarch64-apple-darwin.tar.xz"
      sha256 "c4694112c924e0acc895c80fd310eed80026f814ea300d97353df41b6fddd837"
    end
    if Hardware::CPU.intel?
      url "https://github.com/doomedramen/hitch/releases/download/v1.2.13/hitch-x86_64-apple-darwin.tar.xz"
      sha256 "97a1df87c5e6f729129c98fa4eb205bb5fa97ce6d88001634195c994a5da40e2"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/doomedramen/hitch/releases/download/v1.2.13/hitch-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b4dae34ff49810af532ad3ce70e6c514c897cd781373f6bb4cfca3f2a5200bff"
    end
    if Hardware::CPU.intel?
      url "https://github.com/doomedramen/hitch/releases/download/v1.2.13/hitch-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "54ae309315967f7c6e358998092b2fc5fe0dbb6ff3d2855a99fd66c7f12c075d"
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
