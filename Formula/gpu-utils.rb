class GpuUtils < Formula
  desc "GPU-accelerated Unix utilities (pure e-jerk implementation)"
  homepage "https://github.com/e-jerk/homebrew-utils"
  version "0.1.0"
  license "Unlicense"

  depends_on "e-jerk/utils/find"
  depends_on "e-jerk/utils/gawk"
  depends_on "e-jerk/utils/grep"
  depends_on "e-jerk/utils/sed"

  def install
    ohai "GPU-accelerated utilities installed: find, gawk, grep, sed (pure e-jerk)"
  end

  def caveats
    <<~EOS
      GPU-accelerated utilities have been installed (pure e-jerk implementation).
      These utilities do not include GNU fallback code.

      These support GPU acceleration via --gpu, --metal, or --vulkan flags.
      Use --cpu to force CPU-only mode.

      Each utility can be upgraded independently:
        brew upgrade e-jerk/utils/find
        brew upgrade e-jerk/utils/gawk
        brew upgrade e-jerk/utils/grep
        brew upgrade e-jerk/utils/sed

      Or upgrade all at once:
        brew upgrade e-jerk/utils/gpu-utils
    EOS
  end

  test do
    system "find", "--help"
    system "gawk", "--help"
    system "grep", "--help"
    system "sed", "--help"
  end
end
