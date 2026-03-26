class Utils < Formula
  desc "GPU-accelerated Unix utilities (pure GPU versions)"
  homepage "https://github.com/e-jerk/homebrew-utils"
  url "https://github.com/e-jerk/homebrew-utils/archive/refs/heads/main.tar.gz"
  version "0.1.0"

  depends_on "e-jerk/utils/grep"
  depends_on "e-jerk/utils/find"
  depends_on "e-jerk/utils/gawk"
  depends_on "e-jerk/utils/sed"

  def install
    prefix.install "README.md" if File.exist?("README.md")
  end

  def caveats
    <<~EOS
      e-jerk GPU-accelerated utilities have been installed:
        grep, find, gawk, sed

      To use them instead of system versions, ensure Homebrew's
      bin directory comes first in your PATH:

        echo 'export PATH="$(brew --prefix)/bin:$PATH"' >> ~/.zshrc
        source ~/.zshrc

      Verify with:
        which grep   # should show #{HOMEBREW_PREFIX}/bin/grep
        which sed    # should show #{HOMEBREW_PREFIX}/bin/sed
    EOS
  end
end
