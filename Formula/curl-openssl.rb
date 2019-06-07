class CurlOpenssl < Formula
  desc "Get a file from an HTTP, HTTPS or FTP server"
  homepage "https://curl.haxx.se/"
  url "https://curl.haxx.se/download/curl-7.65.1.tar.bz2"
  sha256 "cbd36df60c49e461011b4f3064cff1184bdc9969a55e9608bf5cadec4686e3f7"

  bottle do
    sha256 "5f265df38e121f3514c2923e016b843f2062b738e3b5659d40030f4fb6b22294" => :mojave
    sha256 "2cde93c00a3db5578bc9af336bee3d0c45255279d600d4bcfb259a9586d193fd" => :high_sierra
    sha256 "9068eedd390a3ae63e582e4bd556c1858707d91cc77ed0f0c2b3082f199d5e6b" => :sierra
  end

  head do
    url "https://github.com/curl/curl.git"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  keg_only :provided_by_macos

  option "with-openssl@1.1", "Build with OpenSSL 1.1"

  depends_on "pkg-config" => :build
  depends_on "brotli"
  depends_on "c-ares"
  depends_on "libidn"
  depends_on "libmetalink"
  depends_on "libssh2"
  depends_on "nghttp2"
  depends_on "openldap"
  if build.with?("openssl@1.1")
    depends_on "openssl@1.1"
  else
    depends_on "openssl"
  end
  depends_on "rtmpdump"

  def install
    system "./buildconf" if build.head?

    args = %W[
      --disable-debug
      --disable-dependency-tracking
      --disable-silent-rules
      --prefix=#{prefix}
      --enable-ares=#{Formula["c-ares"].opt_prefix}
      --with-gssapi
      --with-libidn2
      --with-libmetalink
      --with-librtmp
      --with-libssh2
    ]

    if build.with?("openssl@1.1")
      ENV.prepend_path "PKG_CONFIG_PATH", "#{Formula["openssl@1.1"].opt_lib}/pkgconfig"
      args << "--with-ca-bundle=#{etc}/openssl@1.1/cert.pem"
      args << "--with-ca-path=#{etc}/openssl@1.1/certs"
      args << "--with-ssl=#{Formula["openssl@1.1"].opt_prefix}"
    else
      ENV.prepend_path "PKG_CONFIG_PATH", "#{Formula["openssl"].opt_lib}/pkgconfig"
      args << "--with-ca-bundle=#{etc}/openssl/cert.pem"
      args << "--with-ca-path=#{etc}/openssl/certs"
      args << "--with-ssl=#{Formula["openssl"].opt_prefix}"
    end

    system "./configure", *args
    system "make", "install"
    libexec.install "lib/mk-ca-bundle.pl"
  end

  test do
    # Fetch the curl tarball and see that the checksum matches.
    # This requires a network connection, but so does Homebrew in general.
    filename = (testpath/"test.tar.gz")
    system "#{bin}/curl", "-L", stable.url, "-o", filename
    filename.verify_checksum stable.checksum

    system libexec/"mk-ca-bundle.pl", "test.pem"
    assert_predicate testpath/"test.pem", :exist?
    assert_predicate testpath/"certdata.txt", :exist?
  end
end
