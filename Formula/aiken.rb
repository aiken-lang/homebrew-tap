class Aiken < Formula
  desc "Cardano smart contract language and toolchain"
  homepage "https://github.com/aiken-lang/aiken"
  version "1.1.21"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/aiken-lang/aiken/releases/download/v1.1.21/aiken-aarch64-apple-darwin.tar.gz"
      sha256 "ec72510ba290799854798eb39eff222f8e03a0292d119e2bc4a493179654b31f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/aiken-lang/aiken/releases/download/v1.1.21/aiken-x86_64-apple-darwin.tar.gz"
      sha256 "4bd0817e7760913eb8770e0641dbeef1fb1ab787267df74ca7da2bd343492f4e"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/aiken-lang/aiken/releases/download/v1.1.21/aiken-x86_64-unknown-linux-musl.tar.gz"
    sha256 "9fe0bb94efbb79f4d351664def3da0d58c7e30716fcb65590ff9b6c6b0ffb715"
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
