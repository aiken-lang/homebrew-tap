class Aiken < Formula
  desc "Cardano smart contract language and toolchain"
  homepage "https://github.com/aiken-lang/aiken"
  version "1.0.28-alpha"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/aiken-lang/aiken/releases/download/v1.0.28-alpha/aiken-aarch64-apple-darwin.tar.gz"
      sha256 "e4acdada00117197f3d01e97e11438fbbd5bd0415c0466f3b3fdc13db1da8c99"
    end
    if Hardware::CPU.intel?
      url "https://github.com/aiken-lang/aiken/releases/download/v1.0.28-alpha/aiken-x86_64-apple-darwin.tar.gz"
      sha256 "c8e7192fdbdd952e3dd2e77b3fdca9fae98e829a8ce6a0acd0402adee53b52b7"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/aiken-lang/aiken/releases/download/v1.0.28-alpha/aiken-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1f16202fa669bda97c5410e6e660c339b161f20373b37bf0be8515e67eccd520"
    end
  end
  license "Apache-2.0"

  BINARY_ALIASES = {"aarch64-apple-darwin": {}, "x86_64-apple-darwin": {}, "x86_64-pc-windows-gnu": {}, "x86_64-unknown-linux-gnu": {}}

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
      bin.install "aiken"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "aiken"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "aiken"
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
