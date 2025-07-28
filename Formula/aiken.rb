class Aiken < Formula
  desc "Cardano smart contract language and toolchain"
  homepage "https://github.com/aiken-lang/aiken"
  version "1.1.19"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/aiken-lang/aiken/releases/download/v1.1.19/aiken-aarch64-apple-darwin.tar.gz"
      sha256 "fb4bb47616f869add6da45213aed335fde8a80da1fb1e1390c4fff70fd197daa"
    end
    if Hardware::CPU.intel?
      url "https://github.com/aiken-lang/aiken/releases/download/v1.1.19/aiken-x86_64-apple-darwin.tar.gz"
      sha256 "7659ba68e5ddcefff79f9bc56daa4e63524f814943b43d24d91336aec17563c4"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/aiken-lang/aiken/releases/download/v1.1.19/aiken-x86_64-unknown-linux-musl.tar.gz"
    sha256 "7f65700902050e2b4e5830bfce7afff8d5f87d70774277f731203e7d5d6c8eff"
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
