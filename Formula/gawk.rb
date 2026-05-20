class Gawk < Formula
  desc "GPU-accelerated gawk utility (Metal on macOS, Vulkan on Linux)"
  homepage "https://github.com/e-jerk/gawk"
  version "0.6.0"
  license "Unlicense"

  on_macos do
    on_arm do
      url "https://github.com/e-jerk/gawk/releases/download/v#{version}/gawk-macos-arm64-v#{version}.tar.gz"
      sha256 "3185c787cb4f6d5548b45081bf4550633cddfbaf12cf89ea9b0ea7fc9e9c9a51" # macos-arm64
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/e-jerk/gawk/releases/download/v#{version}/gawk-linux-arm64-v#{version}.tar.gz"
      sha256 "56603e82b7fb47abf071be6778c916984d9d60fb2029e6e5496e011a2144b90e" # linux-arm64
    end
    on_intel do
      url "https://github.com/e-jerk/gawk/releases/download/v#{version}/gawk-linux-amd64-v#{version}.tar.gz"
      sha256 "926a44a96c1fd3a3271d4d140a2fddd532ed8f8f92e46850d8644d800007cf19" # linux-amd64
    end
    depends_on "vulkan-loader"
  end

  def install
    bin.install "gawk"
  end

  def caveats
    <<~EOS
      macOS does not include gawk by default. This installs 'gawk' to #{bin}/gawk.
      If you also have GNU awk installed elsewhere, ensure Homebrew bin is first:
        export PATH="$(brew --prefix)/bin:$PATH"
    EOS
  end

  test do
    system "#{bin}/gawk", "--help"
  end
end
