class TmuxOptions < Formula
  desc "Terminal multiplexer with custom FPS"
  homepage "https://tmux.github.io/"
  url "https://github.com/tmux/tmux/releases/download/3.1a/tmux-3.1a.tar.gz"
  sha256 "10687cbb02082b8b9e076cf122f1b783acc2157be73021b4bedb47e958f4e484"

  bottle :unneeded

  head do
    url "https://github.com/tmux/tmux.git"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  # devel do
  #   url "https://github.com/tmux/tmux/releases/download/3.1/tmux-3.1-rc.tar.gz"
  #   sha256 "9fd91ff2048c9a445e99698e20e20bb64a4b5fd316d2a842b1726de6bc49f9b6"
  # end

  option "with-fps=", "FPS (default 20)"

  depends_on "pkg-config" => :build
  depends_on "libevent"
  depends_on "ncurses"

  resource "completion" do
    url "https://raw.githubusercontent.com/imomaliev/tmux-bash-completion/homebrew_1.0.0/completions/tmux"
    sha256 "05e79fc1ecb27637dc9d6a52c315b8f207cf010cdcee9928805525076c9020ae"
  end

  def install
    if ! (ARGV.value("with-fps").nil? || ARGV.value("with-fps").empty?)
      fps=ARGV.value("with-fps").to_i
    else
      fps=20
    end

    redraw_interval=(1000000/fps).round
    inreplace "tty.c" do |s|
      s.gsub! /^#define TTY_BLOCK_INTERVAL .*$/, "#define TTY_BLOCK_INTERVAL (#{redraw_interval} /* #{fps} fps */)"
    end

    system "sh", "autogen.sh" if build.head?

    args = %W[
      --disable-Dependency-tracking
      --prefix=#{prefix}
      --sysconfdir=#{etc}
    ]

    ENV.append "LDFLAGS", "-lresolv"
    system "./configure", *args

    system "make", "install"

    pkgshare.install "example_tmux.conf"
    bash_completion.install resource("completion")
  end

  def caveats; <<~EOS
    Example configuration has been installed to:
      #{opt_pkgshare}
  EOS
  end

  test do
    system "#{bin}/tmux", "-V"
  end
end