class Sed < Formula
  desc "GPU-accelerated sed utility (Metal on macOS, Vulkan on Linux)"
  homepage "https://github.com/e-jerk/sed"
  version "0.4.0"
  license "Unlicense"

  on_macos do
    on_arm do
      url "https://github.com/e-jerk/sed/releases/download/v#{version}/sed-macos-arm64-v#{version}.tar.gz"
      sha256 "cf232fcbb0c5723d59d3c443a742eb26140e9f4a5a5e6cfa15af73c06d3a5ded" # macos-arm64
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/e-jerk/sed/releases/download/v#{version}/sed-linux-arm64-v#{version}.tar.gz"
      sha256 "434db2efc6a912b631eb98aeb3f4a9b5b9341f8ade4b34e3868547e699d4dcbc" # linux-arm64
    end
    on_intel do
      url "https://github.com/e-jerk/sed/releases/download/v#{version}/sed-linux-amd64-v#{version}.tar.gz"
      sha256 "cf59f89b54d7057cf3d5ea25774d774d4e656228c3c4157634526c9039451592" # linux-amd64
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
