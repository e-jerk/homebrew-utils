class Find < Formula
  desc "GPU-accelerated find utility (Metal on macOS, Vulkan on Linux)"
  homepage "https://github.com/e-jerk/find"
  version "0.6.0"
  license "Unlicense"

  on_macos do
    on_arm do
      url "https://github.com/e-jerk/find/releases/download/v#{version}/find-macos-arm64-v#{version}.tar.gz"
      sha256 "055b79cd784f28783f571b628f12075263982ae5327b3e485cc7e4e3a0fa4814" # macos-arm64
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/e-jerk/find/releases/download/v#{version}/find-linux-arm64-v#{version}.tar.gz"
      sha256 "f43b7f8fee5c63e581e1f5a61b3bb359f400df84813d7c0f65a945f7beb644c2" # linux-arm64
    end
    on_intel do
      url "https://github.com/e-jerk/find/releases/download/v#{version}/find-linux-amd64-v#{version}.tar.gz"
      sha256 "1cd59024ae7997624cd4c483720466fe8f8a9ca642d1a79a047322d921aa76db" # linux-amd64
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
