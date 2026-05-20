class Grep < Formula
  desc "GPU-accelerated grep utility (Metal on macOS, Vulkan on Linux)"
  homepage "https://github.com/e-jerk/grep"
  version "0.6.0"
  license "Unlicense"

  on_macos do
    on_arm do
      url "https://github.com/e-jerk/grep/releases/download/v#{version}/grep-macos-arm64-v#{version}.tar.gz"
      sha256 "f1914490efe5bffe45da7dd1317ed07985925f6eb42a8ff6cd8f9f2c346ccb82" # macos-arm64
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/e-jerk/grep/releases/download/v#{version}/grep-linux-arm64-v#{version}.tar.gz"
      sha256 "e007771670f6a79753adaea42a72bdff2453d250259fe3fac88be4cf790dcecc" # linux-arm64
    end
    on_intel do
      url "https://github.com/e-jerk/grep/releases/download/v#{version}/grep-linux-amd64-v#{version}.tar.gz"
      sha256 "898cc44fb70798c2cbdc9dd0497efc5c2859d5fa8f350b3a487231cf34cd2b53" # linux-amd64
    end
    depends_on "vulkan-loader"
  end

  def install
    bin.install "grep"
  end

  def caveats
    s = <<~EOS
      This installs 'grep' to #{bin}/grep.
      On macOS, Apple's /usr/bin/grep may take precedence.

      To use this version by default, ensure it's first in PATH:
        export PATH="$(brew --prefix)/bin:$PATH"
    EOS
    s
  end

  test do
    system "#{bin}/grep", "--help"
  end
end
