class Grep < Formula
  desc "GPU-accelerated grep utility (Metal on macOS, Vulkan on Linux)"
  homepage "https://github.com/e-jerk/grep"
  version "0.6.0"
  license "Unlicense"

  on_macos do
    on_arm do
      url "https://github.com/e-jerk/grep/releases/download/v#{version}/grep-macos-arm64-v#{version}.tar.gz"
      sha256 "fa25a438816857b7ec7e4eb97dd18fd76052270ebf32938ea06bf2d27e07a1ed" # macos-arm64
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/e-jerk/grep/releases/download/v#{version}/grep-linux-arm64-v#{version}.tar.gz"
      sha256 "0ed6cd7180b30608081f9e780bcc2a52ba285c1e1fb07b9159ed4bbd56d6a589" # linux-arm64
    end
    on_intel do
      url "https://github.com/e-jerk/grep/releases/download/v#{version}/grep-linux-amd64-v#{version}.tar.gz"
      sha256 "a37f16022d299b4f17742ac74964622f38679d2f7e3592491bb39b064d99e7ef" # linux-amd64
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
