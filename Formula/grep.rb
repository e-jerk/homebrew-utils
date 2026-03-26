class Grep < Formula
  desc "GPU-accelerated grep utility (Metal on macOS, Vulkan on Linux)"
  homepage "https://github.com/e-jerk/grep"
  version "0.1.0"
  license "Unlicense"

  on_macos do
    on_arm do
      url "https://github.com/e-jerk/grep/releases/download/v#{version}/grep-macos-arm64-v#{version}.tar.gz"
      sha256 "d8134daa573bb18cc5035531986839fb438151b4c4c0784813c22c9f004da940" # macos-arm64
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/e-jerk/grep/releases/download/v#{version}/grep-linux-arm64-v#{version}.tar.gz"
      sha256 "b6d840c55aa9db5a7e94faf175c1426f6b3c8b7cd6d72a5363eb876f8e2512bb" # linux-arm64
    end
    on_intel do
      url "https://github.com/e-jerk/grep/releases/download/v#{version}/grep-linux-amd64-v#{version}.tar.gz"
      sha256 "421d751883a272bfc48cdd91c350f50fe49e56c96c4f74b92a5b0c02cf266859" # linux-amd64
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
