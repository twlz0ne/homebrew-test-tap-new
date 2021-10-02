class Gothanks < Formula
  desc "Automatically star your go.mod Github dependencies"
  homepage "https://github.com/psampaz/gothanks"
  url "https://github.com/psampaz/gothanks/archive/v0.3.0.tar.gz"
  sha256 "ce5440334b3eac2e058724faa4c6e4478ca1d81ea087e55ccca33f1996752aad"
  license "MIT"

  bottle do
    root_url "https://github.com/twlz0ne/homebrew-test-tap-new/releases/download/gothanks-0.3.0"
    sha256 cellar: :any_skip_relocation, catalina:     "50d93fc34822023fc9155a461c7423fecbadeed211eb31c2ee0175fff8926c1a"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "60874cd13d651a3499984f02b6b094da458b99e9dd2bc55646a69f702c78b2be"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args
  end

  test do
    ENV.delete "GITHUB_TOKEN"
    assert_match "no Github token found", shell_output(bin/"gothanks", 255)
  end
end
