class Gawk < Formula
  desc "GPU-accelerated gawk utility (Metal on macOS, Vulkan on Linux)"
  homepage "https://github.com/e-jerk/gawk"
  version "0.6.0"
  license "Unlicense"

  on_macos do
    on_arm do
      url "https://github.com/e-jerk/gawk/releases/download/v#{version}/gawk-macos-arm64-v#{version}.tar.gz"
      sha256 "9df25c289e38c7457fae5fee6dc14efc30123c7a97f76681844a9bb534e3fed0" # macos-arm64
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/e-jerk/gawk/releases/download/v#{version}/gawk-linux-arm64-v#{version}.tar.gz"
      sha256 "d9065006fe553e72810887cb0f3983f19561e447727643f1024aba60b1986989" # linux-arm64
    end
    on_intel do
      url "https://github.com/e-jerk/gawk/releases/download/v#{version}/gawk-linux-amd64-v#{version}.tar.gz"
      sha256 "f0958435591a4aab5a1b392ea144716ffa8579b4a7c03b703eb40d900fb867ed" # linux-amd64
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
