class Aiken < Formula
  desc "Cardano smart contract language and toolchain"
  homepage "https://github.com/aiken-lang/aiken"
  version "1.1.14"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/aiken-lang/aiken/releases/download/v1.1.14/aiken-aarch64-apple-darwin.tar.gz"
      sha256 "b6531fddd7d7ee3ceeb3f57c40144e3a1449c9c49d925e8bc28a9dd040a240ba"
    end
    if Hardware::CPU.intel?
      url "https://github.com/aiken-lang/aiken/releases/download/v1.1.14/aiken-x86_64-apple-darwin.tar.gz"
      sha256 "e3d984289b08ead4098dfdae4357c42649c748c387652f044a69efe57057189c"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/aiken-lang/aiken/releases/download/v1.1.14/aiken-x86_64-unknown-linux-musl.tar.gz"
    sha256 "64b45d919c167c4a264c6db8b6778666448fcabd90281c6fc2b9ea59986fc472"
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
