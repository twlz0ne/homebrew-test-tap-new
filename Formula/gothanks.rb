class Gothanks < Formula
  desc "Automatically star your go.mod Github dependencies"
  homepage "https://github.com/psampaz/gothanks"
  url "https://github.com/psampaz/gothanks/archive/v0.4.0.tar.gz"
  sha256 "300b705751a43f6ae25df57d6c9a5b0c859e92d61fa83cf894329ea9662525f2"
  license "MIT"

  bottle do
    root_url "https://github.com/twlz0ne/homebrew-test-tap-new/releases/download/gothanks-0.4.0"
    sha256 cellar: :any_skip_relocation, catalina:     "774a80c6e98782592408fb98d1620c8f0ab977da3d5d111fae01dd510c2d55cf"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "198677980d4a2ec409ff4d406ab26e9c7bbd3273fc95214b484cdb33a2ffb143"
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
