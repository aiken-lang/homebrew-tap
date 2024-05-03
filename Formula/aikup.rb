class Aikup < Formula
  desc "Manage multiple versions of aiken"
  homepage "https://aiken-lang.org"
  version "0.0.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/aiken-lang/aikup/releases/download/v0.0.4/aikup-aarch64-apple-darwin.tar.gz"
      sha256 "4d08d2d67ec239f12076ea32c5fb4d8d69dc91dfbe6948863f94ccd9fc8914d3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/aiken-lang/aikup/releases/download/v0.0.4/aikup-x86_64-apple-darwin.tar.gz"
      sha256 "710e040b6a569913263ece0584514acdc686dc1a69042ccb96933b4686b0ca64"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/aiken-lang/aikup/releases/download/v0.0.4/aikup-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7c25e26c0ac259659800642c43f9d37367d6be660a963b99f4c812125da48491"
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
