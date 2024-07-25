class Aiken < Formula
  desc "Cardano smart contract language and toolchain"
  homepage "https://github.com/aiken-lang/aiken"
  version "1.0.30-alpha"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/aiken-lang/aiken/releases/download/v1.0.30-alpha/aiken-aarch64-apple-darwin.tar.gz"
      sha256 "362995e2799537ee3ade8c96f4ebd09b6b179a70178704d5357aa68b13aa7d31"
    end
    if Hardware::CPU.intel?
      url "https://github.com/aiken-lang/aiken/releases/download/v1.0.30-alpha/aiken-x86_64-apple-darwin.tar.gz"
      sha256 "69a2d4918c6885e04c050e7ce9110f438fd3c2649bda4df6a0663b2523018039"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/aiken-lang/aiken/releases/download/v1.0.30-alpha/aiken-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "99a5a17979cadc052e47e728a9d62f501c6560006b57e3f52efca7de4215b451"
    end
  end
  license "Apache-2.0"

  BINARY_ALIASES = {"aarch64-apple-darwin": {}, "x86_64-apple-darwin": {}, "x86_64-unknown-linux-gnu": {}}

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
