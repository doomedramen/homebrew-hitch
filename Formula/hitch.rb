class Hitch < Formula
  desc "A CLI tool for managing environment-specific git branches and metadata"
  homepage "https://github.com/doomedramen/hitch"
  version "1.2.31"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/doomedramen/hitch/releases/download/v1.2.31/hitch-aarch64-apple-darwin.tar.xz"
      sha256 "af0d246b8762cd8ead4491b50c15a3d047d9c102cd53ca375f9b5af3199e4f80"
    end
    if Hardware::CPU.intel?
      url "https://github.com/doomedramen/hitch/releases/download/v1.2.31/hitch-x86_64-apple-darwin.tar.xz"
      sha256 "80ae8fe8fba7f46f6663f2d540b0e34162efb8b0f1ea64d1eb8c012dea5256d7"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/doomedramen/hitch/releases/download/v1.2.31/hitch-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9de8cedd58d278f55e2f05ffb35dd4f997429776505647d6a05beefb5ff677df"
    end
    if Hardware::CPU.intel?
      url "https://github.com/doomedramen/hitch/releases/download/v1.2.31/hitch-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "aa8db3ed0391069a9b3ac76bed3eae6f1b09d66cb2a9f15467e140f4625c6f16"
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
