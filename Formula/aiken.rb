class Aiken < Formula
  desc "Cardano smart contract language and toolchain"
  homepage "https://github.com/aiken-lang/aiken"
  version "1.1.15"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/aiken-lang/aiken/releases/download/v1.1.15/aiken-aarch64-apple-darwin.tar.gz"
      sha256 "2c08ac5ad290a2324a8fa72d4690df696853c50d5d32f7aeb6d2cd1a65f16262"
    end
    if Hardware::CPU.intel?
      url "https://github.com/aiken-lang/aiken/releases/download/v1.1.15/aiken-x86_64-apple-darwin.tar.gz"
      sha256 "b7781ad43ad8605c8fdf424e2a626c7b5e9bdfe01f39e70394d165c5f43512b3"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/aiken-lang/aiken/releases/download/v1.1.15/aiken-x86_64-unknown-linux-musl.tar.gz"
    sha256 "9ed5f1faaf5f22098c211ae10cdbff820d46a29791b42208e4903044b0fc9bf1"
  end
  license "Apache-2.0"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":              {},
    "x86_64-apple-darwin":               {},
    "x86_64-pc-windows-gnu":             {},
    "x86_64-unknown-linux-gnu":          {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static":  {},
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
    bin.install "aiken" if OS.mac? && Hardware::CPU.arm?
    bin.install "aiken" if OS.mac? && Hardware::CPU.intel?
    bin.install "aiken" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
