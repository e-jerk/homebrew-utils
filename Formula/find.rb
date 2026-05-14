class Find < Formula
  desc "GPU-accelerated find utility (Metal on macOS, Vulkan on Linux)"
  homepage "https://github.com/e-jerk/find"
  version "0.5.0"
  license "Unlicense"

  on_macos do
    on_arm do
      url "https://github.com/e-jerk/find/releases/download/v#{version}/find-macos-arm64-v#{version}.tar.gz"
      sha256 "7eaadf07a971c28c71569ba671fef426a296ced5763a1de1685cf9ad3c01b466" # macos-arm64
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/e-jerk/find/releases/download/v#{version}/find-linux-arm64-v#{version}.tar.gz"
      sha256 "2e2e555b845897652dd7f8292e8804821fad475837aa428cea8c597ce7388bf2" # linux-arm64
    end
    on_intel do
      url "https://github.com/e-jerk/find/releases/download/v#{version}/find-linux-amd64-v#{version}.tar.gz"
      sha256 "4e80f29de71c6e87c5ea2c2acd164b56fec33d3d650228e78999c12bc4c626ac" # linux-amd64
    end
    depends_on "vulkan-loader"
  end

  def install
    bin.install "find"
  end

  def caveats
    <<~EOS
      On macOS, Apple's /usr/bin/find takes precedence over Homebrew.
      To use this version by default, ensure Homebrew bin is first in PATH:
        export PATH="$(brew --prefix)/bin:$PATH"
    EOS
  end

  test do
    system "#{bin}/find", "--help"
  end
end
