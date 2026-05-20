class Sed < Formula
  desc "GPU-accelerated sed utility (Metal on macOS, Vulkan on Linux)"
  homepage "https://github.com/e-jerk/sed"
  version "0.6.0"
  license "Unlicense"

  on_macos do
    on_arm do
      url "https://github.com/e-jerk/sed/releases/download/v#{version}/sed-macos-arm64-v#{version}.tar.gz"
      sha256 "83578c0092ed28a196ebabeb08e1b564c4f2b28b168c20ffa6892c2b5e891850" # macos-arm64
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/e-jerk/sed/releases/download/v#{version}/sed-linux-arm64-v#{version}.tar.gz"
      sha256 "5439308b99d1c6df1ef5ce092a90cd2a2c8396b66f4b3fb09360056368ad3b33" # linux-arm64
    end
    on_intel do
      url "https://github.com/e-jerk/sed/releases/download/v#{version}/sed-linux-amd64-v#{version}.tar.gz"
      sha256 "f0ed3f3480179ed7b55656561570fcf8c99099212bc507535fdca6d514f06699" # linux-amd64
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
