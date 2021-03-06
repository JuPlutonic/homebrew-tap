require "language/go"

class Nali < Formula
  desc "An offline tool for querying IP geographic information and CDN provider."
  homepage "https://github.com/zu1k/nali"
  version "0.2.4"
  license "MIT"

  livecheck do
    url "https://github.com/zu1k/nali/releases/latest"
    regex(%r{href=.*?/tag/v?(\d+(?:\.\d+)+[a-z]?)["' >]}i)
  end

  bottle :unneeded

  option "without-prebuilt", "Skip prebuilt binary and build from source"

  if !build.without?("prebuilt")
    on_macos do
      url "https://github.com/zu1k/nali/releases/download/v#{version}/nali-darwin-amd64-v#{version}.gz"
    end
    on_linux do
      url "https://github.com/zu1k/nali/releases/download/v#{version}/nali-linux-amd64-v#{version}.gz"
    end
  else
    # http downloading is quick than git cloning
    url "https://github.com/zu1k/nali/archive/refs/tags/v#{version}.tar.gz"
    # Git repo is not cloned into a sub-folder
    # url "https://github.com/zu1k/nali.git", tag: "v#{version}"

    depends_on "go" => :build
  end

  head do
    # version: HEAD
    url "https://github.com/zu1k/nali/archive/refs/heads/master.zip"
    # # Git repo is not cloned into a sub-folder. version, HEAD-1234567
    # url "https://github.com/zu1k/nali.git"

    # Warn: build.head doesn't work under "class"
    depends_on "go" => :build
  end

  def install
    if build.without?("prebuilt") || build.head?
      # Warning: don't put GOPATH in CWD, failed to build cause packr err raised
      buildpath_parent = File.dirname(buildpath)
      ENV["GOPATH"] = "#{buildpath_parent}/go"
      ENV["GOCACHE"] = "#{ENV["GOPATH"]}/go-build"
      ENV["PATH"] = "#{ENV["PATH"]}:#{HOMEBREW_PREFIX}/opt/node/libexec/bin"

      system "go", "build", "-o", bin/"nali"
    else
      Dir["nali*"].each do |i|
        bin.install i => "nali"
        break
      end
    end
    prefix.install_metafiles
  end

  def caveats; <<~EOS
    zu1k/nali has support for different geoip databases. Related
    environment varialbles are:
    - NALI_DB, default chunzhen
    - NALI_DB_HOME, default ~/.nali
    Check the project's README for detail. https://github.com/zu1k/nali
  EOS
  end

  test do
    system "#{bin}/nali", "-h"
  end
end
