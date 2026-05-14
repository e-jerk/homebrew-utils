class Gawk < Formula
  desc "GPU-accelerated gawk utility (Metal on macOS, Vulkan on Linux)"
  homepage "https://github.com/e-jerk/gawk"
  version "0.5.0"
  license "Unlicense"

  on_macos do
    on_arm do
      url "https://github.com/e-jerk/gawk/releases/download/v#{version}/gawk-macos-arm64-v#{version}.tar.gz"
      sha256 "9b14fd0a39f063f304d9a2b9d5baf86c5fe2fe7253718c85e4085299d221c2da" # macos-arm64
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/e-jerk/gawk/releases/download/v#{version}/gawk-linux-arm64-v#{version}.tar.gz"
      sha256 "0b0886348dde7dffab45de80577461e8e8e1b90778024fc6050bd267674eabd9" # linux-arm64
    end
    on_intel do
      url "https://github.com/e-jerk/gawk/releases/download/v#{version}/gawk-linux-amd64-v#{version}.tar.gz"
      sha256 "4574b551ac5d893dd9bd3b8a3aa5227cc8d9162e311a0a9f46c8a69fd0345daa" # linux-amd64
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
