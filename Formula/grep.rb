class Grep < Formula
  desc "GPU-accelerated grep utility (Metal on macOS, Vulkan on Linux)"
  homepage "https://github.com/e-jerk/grep"
  version "0.5.0"
  license "Unlicense"

  on_macos do
    on_arm do
      url "https://github.com/e-jerk/grep/releases/download/v#{version}/grep-macos-arm64-v#{version}.tar.gz"
      sha256 "978bc42c8c467220f476802aab5ed6c0eb5f54e513a7f5cae49fa7d78b1f1a84" # macos-arm64
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/e-jerk/grep/releases/download/v#{version}/grep-linux-arm64-v#{version}.tar.gz"
      sha256 "9e8888fab5137cbf5136df581d049cdd2ec09e495fc92c7d9b1767991c003643" # linux-arm64
    end
    on_intel do
      url "https://github.com/e-jerk/grep/releases/download/v#{version}/grep-linux-amd64-v#{version}.tar.gz"
      sha256 "44dee43baf61351563e0223e8abbac4e7e1f1796f5f4302adb1596894b63b0c1" # linux-amd64
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
