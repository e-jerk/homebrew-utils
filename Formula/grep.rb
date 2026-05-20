class Grep < Formula
  desc "GPU-accelerated grep utility (Metal on macOS, Vulkan on Linux)"
  homepage "https://github.com/e-jerk/grep"
  version "0.6.0"
  license "Unlicense"

  on_macos do
    on_arm do
      url "https://github.com/e-jerk/grep/releases/download/v#{version}/grep-macos-arm64-v#{version}.tar.gz"
      sha256 "3166c9bb7c577d75e35c0d6c69d27058b77cbc32981ac7f1c5a44128efd424f9" # macos-arm64
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/e-jerk/grep/releases/download/v#{version}/grep-linux-arm64-v#{version}.tar.gz"
      sha256 "4feec7577ae1cfdbbe15530a0d80d3a6a511ee7dfb85721d6c2494ce5eb0ec78" # linux-arm64
    end
    on_intel do
      url "https://github.com/e-jerk/grep/releases/download/v#{version}/grep-linux-amd64-v#{version}.tar.gz"
      sha256 "5ad0261fe4761ea0d61374d0436e3f51b286739f3a2b6a2b1f820ec94656d2bb" # linux-amd64
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
