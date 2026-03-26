class Find < Formula
  desc "GPU-accelerated find utility (Metal on macOS, Vulkan on Linux)"
  homepage "https://github.com/e-jerk/find"
  version "0.2.0"
  license "Unlicense"

  on_macos do
    on_arm do
      url "https://github.com/e-jerk/find/releases/download/v#{version}/find-macos-arm64-v#{version}.tar.gz"
      sha256 "26d746e772091358ef5604643af310f29b7439ff2dcda2b5e868d016fc890385" # macos-arm64
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/e-jerk/find/releases/download/v#{version}/find-linux-arm64-v#{version}.tar.gz"
      sha256 "9060ab331d21c4f996f543f86b0fc1f73ce5f791c29a87f268e3f466f04bb0dc" # linux-arm64
    end
    on_intel do
      url "https://github.com/e-jerk/find/releases/download/v#{version}/find-linux-amd64-v#{version}.tar.gz"
      sha256 "d65e7601d5edc18db5f554031cf7f0596614e83566e5ee73c10ef95d35fca9a8" # linux-amd64
    end
    depends_on "vulkan-loader"
  end

  def install
    bin.install "find"
  end

  test do
    system "#{bin}/find", "--help"
  end
end
