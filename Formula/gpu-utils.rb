class GpuUtils < Formula
  desc "GPU-accelerated Unix utilities (find, grep, sed) using Metal and Vulkan"
  homepage "https://github.com/e-jerk/homebrew-utils"
  version "0.1.0"
  license "GPL-3.0-or-later"

  depends_on "e-jerk/find/find"
  depends_on "e-jerk/grep/grep"
  depends_on "e-jerk/sed/sed"

  def install
    ohai "GPU-accelerated utilities installed: find, grep, sed"
  end

  def caveats
    <<~EOS
      GPU-accelerated utilities have been installed and will
      override the system find, grep, and sed commands.

      These support GPU acceleration via --gpu, --metal, or --vulkan flags.
      Use --cpu to force CPU-only mode.

      Each utility can be upgraded independently:
        brew upgrade e-jerk/find/find
        brew upgrade e-jerk/grep/grep
        brew upgrade e-jerk/sed/sed

      Or upgrade all at once:
        brew upgrade e-jerk/utils/gpu-utils
    EOS
  end

  test do
    system "find", "--help"
    system "grep", "--help"
    system "sed", "--help"
  end
end
