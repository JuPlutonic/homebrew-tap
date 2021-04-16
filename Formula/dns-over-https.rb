require "language/go"

class DnsOverHttps < Formula
  desc "High performance DNS over HTTPS client & server"
  homepage "https://github.com/m13253/dns-over-https"
  head "https://github.com/m13253/dns-over-https.git"
  url "https://github.com/m13253/dns-over-https/archive/v2.2.5.tar.gz"
  sha256 "2e7464195975619e1c2745195a3506e423eca9ccddb2234fd4b2ad9c17abb025"


  conflicts_with "doh-proxy", because: "both install binaries `doh-proxy`, `doh-client`"
  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    path = buildpath/"github.com/m13253/dns-over-https"
    path.install Dir["*"]

    cd path do
      # the Makefile handles dependencies itself
      system "make"

      (etc/"dns-over-https").mkpath

      # https://stackoverflow.com/questions/690794/ruby-arrays-w-vs-w
      %W[
        doh-client
        doh-server
      ].each do |i|
        bin.install("#{i}/#{i}" => "#{i}")
        etc.install("#{i}/#{i}.conf" => "dns-over-https/#{i}.conf")
      end

      prefix.install_metafiles
    end
  end

  test do
    system bin/"doh-client", "-version"
  end

  # TODO: run multiple plists under one formula #192
  #   https://github.com/Homebrew/homebrew-services/issues/192

end
