class Aikup < Formula
  desc "Manage multiple versions of aiken"
  homepage "https://aiken-lang.org"
  version "0.0.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/aiken-lang/aikup/releases/download/v0.0.3/aikup-aarch64-apple-darwin.tar.gz"
      sha256 "057cc7ccdc5164fe2c201060564bcd15f53c12e02fc62b81fa8501128bec5b23"
    end
    if Hardware::CPU.intel?
      url "https://github.com/aiken-lang/aikup/releases/download/v0.0.3/aikup-x86_64-apple-darwin.tar.gz"
      sha256 "90adece8da9981cec7d1c732c26343e88605ea4d567b7005ce0c32756f36537e"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/aiken-lang/aikup/releases/download/v0.0.3/aikup-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8b5c246951449036d88e1e5b6fca0efdd3f2f9edf7ff26e5599f3654097d5903"
    end
  end
  license "Apache-2.0"

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

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
