class Aikup < Formula
  desc "Manage multiple versions of aiken"
  homepage "https://aiken-lang.org"
  version "0.0.10"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/aiken-lang/aikup/releases/download/v0.0.10/aikup-aarch64-apple-darwin.tar.gz"
      sha256 "8e3f4382457bfe921be864668892b9f440ff7e899c039bf765ffef3f8f1bef59"
    end
    if Hardware::CPU.intel?
      url "https://github.com/aiken-lang/aikup/releases/download/v0.0.10/aikup-x86_64-apple-darwin.tar.gz"
      sha256 "40b76b085bc2ef6e7c95447488b0f44914d9fe01d0defbbb4395a564d5a0418e"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/aiken-lang/aikup/releases/download/v0.0.10/aikup-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "479066800d27976744155d2b1e2b1a146b3ffceabcc7d72c148a0927cb7c6f4c"
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
