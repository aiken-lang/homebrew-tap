class Aikup < Formula
  desc "Manage multiple versions of aiken"
  homepage "https://aiken-lang.org"
  version "0.0.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/aiken-lang/aikup/releases/download/v0.0.2/aikup-aarch64-apple-darwin.tar.gz"
      sha256 "58f74dcdbbff2a40d958fbef65f7084cd2741cbb0a862f3d0f7f56450e5e2ddd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/aiken-lang/aikup/releases/download/v0.0.2/aikup-x86_64-apple-darwin.tar.gz"
      sha256 "854e13b86d461f1a7057792438dd9aeb17db07653843bad04f3cf93033a61ab1"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/aiken-lang/aikup/releases/download/v0.0.2/aikup-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7fc8513664dd8f414366e47e921c3237bd462f3f4a510a669a75e87bde7c934c"
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
