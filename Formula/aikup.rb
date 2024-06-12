class Aikup < Formula
  desc "Manage multiple versions of aiken"
  homepage "https://aiken-lang.org"
  version "0.0.9"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/aiken-lang/aikup/releases/download/v0.0.9/aikup-aarch64-apple-darwin.tar.gz"
      sha256 "ce9e229817cbfd260f8afc5ed74fe0f02a21e2871df62a2a369e9a7c00da74cf"
    end
    if Hardware::CPU.intel?
      url "https://github.com/aiken-lang/aikup/releases/download/v0.0.9/aikup-x86_64-apple-darwin.tar.gz"
      sha256 "db33cf902af31672ddce173f1bfa48e580f44803b31fd939aa7286f716b48431"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/aiken-lang/aikup/releases/download/v0.0.9/aikup-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1b3bb7b2d971d9565d9f348f823788ebe0c10a3d388a737a486871982a85f6a9"
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
      bin.install "aikup"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "aikup"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "aikup"
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
