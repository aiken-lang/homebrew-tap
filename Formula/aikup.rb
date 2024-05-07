class Aikup < Formula
  desc "Manage multiple versions of aiken"
  homepage "https://aiken-lang.org"
  version "0.0.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/aiken-lang/aikup/releases/download/v0.0.5/aikup-aarch64-apple-darwin.tar.gz"
      sha256 "bdf31c1ebb17c9e125f6e8dec8ad030cef08925a07b44a543538e37aba7b3952"
    end
    if Hardware::CPU.intel?
      url "https://github.com/aiken-lang/aikup/releases/download/v0.0.5/aikup-x86_64-apple-darwin.tar.gz"
      sha256 "d784175c57cac47de9c0f648daf540a8db0974dc2a93298c60ce1536a3d5fecc"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/aiken-lang/aikup/releases/download/v0.0.5/aikup-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "68ee7944d2644c4aa996a2804c4e03a3cbb289b3b260a164892985cbfb90e7b3"
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
