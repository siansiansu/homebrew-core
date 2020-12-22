class AmazonEcsCli < Formula
  desc "CLI for Amazon ECS to manage clusters and tasks for development"
  homepage "https://aws.amazon.com/ecs"
  url "https://github.com/aws/amazon-ecs-cli/archive/v1.21.0.tar.gz"
  sha256 "27e93a5439090486a2f2f5a9b02cbbd1493e3c14affbbe2375ed57f8f903e677"
  license "Apache-2.0"
  head "https://github.com/aws/amazon-ecs-cli.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "b3b90826d45578c484184dc19278ff520e7a98087886552d13448b9f119cd7b7" => :big_sur
    sha256 "b0f0e3d37c75477cefbc53567e788a348b582c3d27143fab2fcb2c249946cff6" => :catalina
    sha256 "e8fae3c0310d8313ab091892fbebef49215f282f60372b15460e0726b892cb1f" => :mojave
    sha256 "d5d67c5dd5fa49c3899e664e593c81f60ee49b8fa8c5c63d2515babf9abfc5aa" => :high_sierra
  end

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    (buildpath/"src/github.com/aws/amazon-ecs-cli").install buildpath.children
    cd "src/github.com/aws/amazon-ecs-cli" do
      system "make", "build"
      bin.install "bin/local/ecs-cli"
      prefix.install_metafiles
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ecs-cli -v")
  end
end
