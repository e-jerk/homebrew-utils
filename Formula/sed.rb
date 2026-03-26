class Sed < Formula
  desc "GPU-accelerated sed utility (Metal on macOS, Vulkan on Linux)"
  homepage "https://github.com/e-jerk/sed"
  version "0.2.0"
  license "Unlicense"

  on_macos do
    on_arm do
      url "https://github.com/e-jerk/sed/releases/download/v#{version}/sed-macos-arm64-v#{version}.tar.gz"
      sha256 "0fc4081fa308ebe24a84ea981424b15111c68ecd79553671cb94b0ef05ea89bf" # macos-arm64
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/e-jerk/sed/releases/download/v#{version}/sed-linux-arm64-v#{version}.tar.gz"
      sha256 "9d71b69c00df2772962f0055b523577402d8ad2019776cb3cd08c4bc63454de7" # linux-arm64
    end
    on_intel do
      url "https://github.com/e-jerk/sed/releases/download/v#{version}/sed-linux-amd64-v#{version}.tar.gz"
      sha256 "aff0c3ad41b50d10326b4671b52f31a1de1c8d034b1c9081bcb18e8f5e2ebfd7" # linux-amd64
    end
    depends_on "vulkan-loader"
  end

  def install
    bin.install "sed"
  end

  test do
    system "#{bin}/sed", "--help"
  end
end
