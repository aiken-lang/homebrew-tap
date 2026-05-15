class Aiken < Formula
  desc "Cardano smart contract language and toolchain"
  homepage "https://github.com/aiken-lang/aiken"
  version "1.1.22"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/aiken-lang/aiken/releases/download/v1.1.22/aiken-aarch64-apple-darwin.tar.gz"
      sha256 "9b271bc2efc991a4fd3ec7c24d36b1c654621670903a731fc68a8251443d1de8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/aiken-lang/aiken/releases/download/v1.1.22/aiken-x86_64-apple-darwin.tar.gz"
      sha256 "e1f652c2e78df264da0b547bc6e4d470d1d42a6e3f248ccd5df95f2ac79011cb"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/aiken-lang/aiken/releases/download/v1.1.22/aiken-aarch64-unknown-linux-musl.tar.gz"
      sha256 "2ad7e407131bf51d059a9365b1c63320697e3fe8b170af673d20a1b7280b21e6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/aiken-lang/aiken/releases/download/v1.1.22/aiken-x86_64-unknown-linux-musl.tar.gz"
      sha256 "d443f9deab109fd75ae19e22f7dfce4cdd2f70b3f68c152a6a23db6bc1ea76e1"
    end
  end
  license "Apache-2.0"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-pc-windows-gnu":              {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
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
    bin.install "aiken" if OS.linux? && Hardware::CPU.arm?
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
