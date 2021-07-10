class Sshfs < Formula
  desc "File system client based on SSH File Transfer Protocol"
  homepage "https://github.com/libfuse/sshfs"
  url "https://github.com/libfuse/sshfs/archive/sshfs-3.7.2.tar.gz"
  sha256 "8a9b0d980e9d34d0d18eacb9e1ca77fc499d1cf70b3674cc3e02f3eafad8ab14"
  license any_of: ["LGPL-2.1-only", "GPL-2.0-only"]

  bottle do
    sha256 cellar: :any, catalina:     "aceff3131dd0b098bdef8b5dda54d117b5dd5269ca146f7a5032ecde3c99b6d2"
    sha256 cellar: :any, mojave:       "5f69267c0f1f2489989e108919d66210e058423d0d1f1661812c0194b164619c"
    sha256 cellar: :any, high_sierra:  "58d222f37622b399352f16eaf823d3e564445d9e951629e965281ac31de5ef4a"
    sha256 cellar: :any, sierra:       "dc4a7f24c2cbebd7c35891200b043d737ba6586a28992708ef849ffedff7bb01"
    sha256               x86_64_linux: "7b1ef421c8ede5412ed54d81cefd327bf80a75f5652f44507003a8b46cefb005"
  end

  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  depends_on "glib"

  on_macos do
    disable! date: "2021-04-08", because: "requires closed-source macFUSE"
  end

  on_linux do
    depends_on "libfuse"
  end

  def install
    mkdir "build" do
      system "meson", ".."
      system "meson", "configure", "--prefix", prefix
      system "ninja", "--verbose"
      system "ninja", "install", "--verbose"
    end
  end

  def caveats
    on_macos do
      <<~EOS
        The reasons for disabling this formula can be found here:
          https://github.com/Homebrew/homebrew-core/pull/64491

        An external tap may provide a replacement formula. See:
          https://docs.brew.sh/Interesting-Taps-and-Forks
      EOS
    end
  end

  test do
    system "#{bin}/sshfs", "--version"
  end
end
