class Aikup < Formula
  desc "Manage multiple versions of aiken"
  homepage "https://aiken-lang.org"
  version "0.0.6"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/aiken-lang/aikup/releases/download/v0.0.6/aikup-aarch64-apple-darwin.tar.gz"
      sha256 "82d31c6e1d0c02f8befd1931190b2d6a6ff37e8e8a2d5c54202b4326e0e6a151"
    end
    if Hardware::CPU.intel?
      url "https://github.com/aiken-lang/aikup/releases/download/v0.0.6/aikup-x86_64-apple-darwin.tar.gz"
      sha256 "cc8e6841681a31139abf4e654ff36e0c05bfda2253e1b4a8e3db7545b31520d0"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/aiken-lang/aikup/releases/download/v0.0.6/aikup-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e2444c57c87f850edd7571822fd95c828b3f7617a2352dc88e93dc975db21ab3"
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
