class Readline < Formula
  desc "Library for command-line editing"
  homepage "https://tiswww.case.edu/php/chet/readline/rltop.html"
  url "https://ftp.gnu.org/gnu/readline/readline-8.1.tar.gz"
  mirror "https://ftpmirror.gnu.org/readline/readline-8.1.tar.gz"
  sha256 "f8ceb4ee131e3232226a17f51b164afc46cd0b9e6cef344be87c65962cb82b02"
  license "GPL-3.0-or-later"

  livecheck do
    url :stable
    regex(/href=.*?readline[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/twlz0ne/homebrew-test-tap-new/releases/download/readline-8.1"
    sha256 cellar: :any, catalina: "5b25587e49d735aa7f9f44e2f6328939365d5bb7af2737a91a3e7b82dd52be25"
  end

  keg_only :shadowed_by_macos, "macOS provides BSD libedit"

  uses_from_macos "ncurses"

  def install
    args = ["--prefix=#{prefix}"]
    args << "--with-curses" if OS.linux?
    system "./configure", *args

    args = []
    args << "SHLIB_LIBS=-lcurses" if OS.linux?
    # There is no termcap.pc in the base system, so we have to comment out
    # the corresponding Requires.private line.
    # Otherwise, pkg-config will consider the readline module unusable.
    inreplace "readline.pc", /^(Requires.private: .*)$/, "# \\1"
    system "make", "install", *args
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <stdio.h>
      #include <stdlib.h>
      #include <readline/readline.h>

      int main()
      {
        printf("%s\\n", readline("test> "));
        return 0;
      }
    EOS
    system ENV.cc, "-L", lib, "test.c", "-L#{lib}", "-lreadline", "-o", "test"
    assert_equal "test> Hello, World!\nHello, World!",
      pipe_output("./test", "Hello, World!\n").strip
  end
end
