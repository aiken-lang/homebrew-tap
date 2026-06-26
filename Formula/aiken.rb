class Aiken < Formula
  desc "Cardano smart contract language and toolchain"
  homepage "https://github.com/aiken-lang/aiken"
  version "1.1.23"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/aiken-lang/aiken/releases/download/v1.1.23/aiken-aarch64-apple-darwin.tar.gz"
      sha256 "6c03b072a599e1899accf7666c46f2d811d56d4605f9bb097aff38047ce8fa02"
    end
    if Hardware::CPU.intel?
      url "https://github.com/aiken-lang/aiken/releases/download/v1.1.23/aiken-x86_64-apple-darwin.tar.gz"
      sha256 "78f1c962e213addd786664cdf5c279292448332bc78f5728740419b20c840c63"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/aiken-lang/aiken/releases/download/v1.1.23/aiken-aarch64-unknown-linux-musl.tar.gz"
      sha256 "72a40b4e1b8e2219c4d655590d6a6e868d858386db780a36971bd3aaf4d89290"
    end
    if Hardware::CPU.intel?
      url "https://github.com/aiken-lang/aiken/releases/download/v1.1.23/aiken-x86_64-unknown-linux-musl.tar.gz"
      sha256 "b98c4ccbada5e35f15ba417a52872aeaf0c65998aed77351769ce5fd2506b570"
    end
  end
  license "Apache-2.0"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static": {},
    "x86_64-apple-darwin": {},
    "x86_64-pc-windows-gnu": {},
    "x86_64-unknown-linux-gnu": {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static": {}
  }

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
    if OS.linux? && Hardware::CPU.arm?
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
