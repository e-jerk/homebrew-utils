class Gawk < Formula
  desc "GPU-accelerated gawk utility (Metal on macOS, Vulkan on Linux)"
  homepage "https://github.com/e-jerk/gawk"
  version "0.4.0"
  license "Unlicense"

  on_macos do
    on_arm do
      url "https://github.com/e-jerk/gawk/releases/download/v#{version}/gawk-macos-arm64-v#{version}.tar.gz"
      sha256 "09f02c4b125924dc6bdb630275d5583a9ae0c3bb72fc50164b92c2436e52046c" # macos-arm64
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/e-jerk/gawk/releases/download/v#{version}/gawk-linux-arm64-v#{version}.tar.gz"
      sha256 "bb8b07c3cbec21170bc5365e0f85dd731f25f79cb6288102d5ec27a2b8657b23" # linux-arm64
    end
    on_intel do
      url "https://github.com/e-jerk/gawk/releases/download/v#{version}/gawk-linux-amd64-v#{version}.tar.gz"
      sha256 "4595c441735b51cfd7cb5c3bfe229ce69534619297c1b0102861e725b1221eec" # linux-amd64
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
