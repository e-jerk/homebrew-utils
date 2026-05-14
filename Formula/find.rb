class Find < Formula
  desc "GPU-accelerated find utility (Metal on macOS, Vulkan on Linux)"
  homepage "https://github.com/e-jerk/find"
  version "0.4.0"
  license "Unlicense"

  on_macos do
    on_arm do
      url "https://github.com/e-jerk/find/releases/download/v#{version}/find-macos-arm64-v#{version}.tar.gz"
      sha256 "3e7b3c6a173234d2f7ad1e96297f16ec242c56b4eeb836ea79e09318634e5c07" # macos-arm64
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/e-jerk/find/releases/download/v#{version}/find-linux-arm64-v#{version}.tar.gz"
      sha256 "c8f7bdec7bd649af14dff091b748c235845aa6451226c2957f2a11892ceae395" # linux-arm64
    end
    on_intel do
      url "https://github.com/e-jerk/find/releases/download/v#{version}/find-linux-amd64-v#{version}.tar.gz"
      sha256 "1299edfcf7b72e4a69e6373ffed307c2f3ea60bdb67b0e1f7c3cafe550d07857" # linux-amd64
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
