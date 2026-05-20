class Gawk < Formula
  desc "GPU-accelerated gawk utility (Metal on macOS, Vulkan on Linux)"
  homepage "https://github.com/e-jerk/gawk"
  version "0.6.0"
  license "Unlicense"

  on_macos do
    on_arm do
      url "https://github.com/e-jerk/gawk/releases/download/v#{version}/gawk-macos-arm64-v#{version}.tar.gz"
      sha256 "b38eab41bf840a44c65425b060e5c94a930dac34ff3ad658f8772dc4d87f4cbd" # macos-arm64
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/e-jerk/gawk/releases/download/v#{version}/gawk-linux-arm64-v#{version}.tar.gz"
      sha256 "5672b7a00291103e954f532a779fd2a1a847c58cb9d4ef80b51b2bd24ff15c9a" # linux-arm64
    end
    on_intel do
      url "https://github.com/e-jerk/gawk/releases/download/v#{version}/gawk-linux-amd64-v#{version}.tar.gz"
      sha256 "fa641fa687fded1437223e542a8860464357a5ef7ebe10ae14dd9ebe9beb55ce" # linux-amd64
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
