class Hitch < Formula
  desc "A CLI tool for managing environment-specific git branches and metadata"
  homepage "https://github.com/doomedramen/hitch"
  version "1.2.37"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/doomedramen/hitch/releases/download/v1.2.37/hitch-aarch64-apple-darwin.tar.xz"
      sha256 "3f2cd4b4ffdf8919f779de79321e435f5f342614283e110bb217a404b6aa1911"
    end
    if Hardware::CPU.intel?
      url "https://github.com/doomedramen/hitch/releases/download/v1.2.37/hitch-x86_64-apple-darwin.tar.xz"
      sha256 "ae89d597234ae59cbcdd322d81e9af689febcc0987c215e261946713fd66efe8"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/doomedramen/hitch/releases/download/v1.2.37/hitch-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "0a34512d57392c7bf3543c886f4f79dac98f691ccead3dad1742786435784c5f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/doomedramen/hitch/releases/download/v1.2.37/hitch-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b0a3ab75bc58ffc7b8e5d2172d7422306a327decc04ef53117dd30d3ee3cec97"
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
