class Sed < Formula
  desc "GPU-accelerated sed utility (Metal on macOS, Vulkan on Linux)"
  homepage "https://github.com/e-jerk/sed"
  version "0.6.0"
  license "Unlicense"

  on_macos do
    on_arm do
      url "https://github.com/e-jerk/sed/releases/download/v#{version}/sed-macos-arm64-v#{version}.tar.gz"
      sha256 "3b7f5a90230a7f39d522f5618d7344fbf2a9800528c5c2dcfb5fe7392704a3e7" # macos-arm64
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/e-jerk/sed/releases/download/v#{version}/sed-linux-arm64-v#{version}.tar.gz"
      sha256 "a3ae56e79fb713924958f8e5821e205749c7048a02006923c50d2e9606648fcd" # linux-arm64
    end
    on_intel do
      url "https://github.com/e-jerk/sed/releases/download/v#{version}/sed-linux-amd64-v#{version}.tar.gz"
      sha256 "8a04ee4a373dddaf8b809be94e12746ecdbd64e4c8ac81a14161dc2122f98da4" # linux-amd64
    end
    depends_on "vulkan-loader"
  end

  def install
    bin.install "sed"
  end

  def caveats
    <<~EOS
      On macOS, Apple's /usr/bin/sed takes precedence over Homebrew.
      To use this version by default, ensure Homebrew bin is first in PATH:
        export PATH="$(brew --prefix)/bin:$PATH"
    EOS
  end

  test do
    system "#{bin}/sed", "--help"
  end
end
