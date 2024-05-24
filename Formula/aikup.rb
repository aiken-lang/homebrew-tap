class Aikup < Formula
  desc "Manage multiple versions of aiken"
  homepage "https://aiken-lang.org"
  version "0.0.7"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/aiken-lang/aikup/releases/download/v0.0.7/aikup-aarch64-apple-darwin.tar.gz"
      sha256 "10a690da857ad17b85791b4c9a00e4d45434bfa3626b044973fde28e00f53c43"
    end
    if Hardware::CPU.intel?
      url "https://github.com/aiken-lang/aikup/releases/download/v0.0.7/aikup-x86_64-apple-darwin.tar.gz"
      sha256 "d26a5dbc42bc9b08337960705774be3e482a20a31484b9c1109f5a8ab3be1559"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/aiken-lang/aikup/releases/download/v0.0.7/aikup-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0f458ed9e6fc6ecdc01b4c0fb5fef124ac243cc0473c6dda44b671dbb4419ca7"
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
