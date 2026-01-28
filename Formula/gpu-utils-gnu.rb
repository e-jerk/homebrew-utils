class GpuUtilsGnu < Formula
  desc "GPU-accelerated Unix utilities with GNU fallback"
  homepage "https://github.com/e-jerk/homebrew-utils"
  version "0.1.0"
  license "GPL-3.0-or-later"

  depends_on "e-jerk/utils/find-gnu"
  depends_on "e-jerk/utils/gawk-gnu"
  depends_on "e-jerk/utils/grep-gnu"
  depends_on "e-jerk/utils/sed-gnu"

  def install
    ohai "GPU-accelerated utilities installed: find, gawk, grep, sed"
  end

  def caveats
    <<~EOS
      GPU-accelerated utilities have been installed and will
      override the system find, grep, and sed commands.

      These support GPU acceleration via --gpu, --metal, or --vulkan flags.
      Use --cpu to force CPU-only mode.

      Each utility can be upgraded independently:
        brew upgrade e-jerk/utils/find-gnu
        brew upgrade e-jerk/utils/gawk-gnu
        brew upgrade e-jerk/utils/grep-gnu
        brew upgrade e-jerk/utils/sed-gnu

      Or upgrade all at once:
        brew upgrade e-jerk/utils/gpu-utils-gnu
    EOS
  end

  test do
    system "find", "--help"
    system "gawk", "--help"
    system "grep", "--help"
    system "sed", "--help"
  end
end
