# References
# - https://github.com/Homebrew/homebrew-core/commit/f75cb092032c2eb921ba0bcdcf6a45af5cf86714
# - https://github.com/Homebrew/homebrew-core/pull/33065/files
# - https://github.com/homebrew-ffmpeg/homebrew-ffmpeg/blob/master/Formula/ffmpeg.rb
# - https://github.com/homebrew-ffmpeg/homebrew-ffmpeg/blob/master/Formula/ffmpeg.rb
class FfmpegOptions < Formula
  desc 'Play, record, convert, and stream audio and video'
  homepage 'https://ffmpeg.org/'
  # None of these parts are used by default, you have to explicitly pass `--enable-gp>
  # to configure to activate them. In this case, FFmpeg's license changes to GPL v2+.
  license 'GPL-2.0-or-later'
  head 'https://github.com/FFmpeg/FFmpeg.git'

  stable do
    url 'https://ffmpeg.org/releases/ffmpeg-4.4.tar.xz'
    sha256 '06b10a183ce5371f915c6bb15b7b1fffbe046e8275099c96affc29e17645d909'
  end

  livecheck do
    url 'https://ffmpeg.org/download.html'
    regex(/href=.*?ffmpeg[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle :unneeded

  option 'with-chromaprint', 'Enable the Chromaprint audio fingerprinting library'
  option 'with-decklink', 'Enable DeckLink support'
  option 'with-fdk-aac', 'Enable the Fraunhofer FDK AAC library'
  option 'with-game-music-emu', 'Enable Game Music Emu (GME) support'
  option 'with-librsvg', 'Enable SVG files as inputs via librsvg'
  option 'with-libssh', 'Enable SFTP protocol via libssh'
  option 'with-openh264', 'Enable OpenH264 library'
  option 'with-openssl', 'Enable SSL support'
  option 'with-rtmpdump', 'RTMPDump support'
  option 'with-zeromq', 'Enable using libzeromq to receive ZeroMQ-commands'
  option 'with-zimg', 'Enable z.lib zimg library'
  # option "with-srt", "Enable SRT library"
  option 'with-libvmaf', 'Enable libvmaf scoring library'

  depends_on 'nasm' => :build
  depends_on 'pkg-config' => :build
  depends_on 'aom'
  depends_on 'dav1d'
  depends_on 'fontconfig'
  depends_on 'freetype'
  depends_on 'frei0r'
  depends_on 'lame'
  depends_on 'libass'
  depends_on 'libbluray'
  depends_on 'libsoxr'
  depends_on 'libvidstab'
  depends_on 'libvorbis'
  depends_on 'libvpx'
  depends_on 'opencore-amr'
  depends_on 'openjpeg'
  depends_on 'opus'
  depends_on 'rav1e'
  depends_on 'rubberband'
  depends_on 'sdl2'
  depends_on 'snappy'
  depends_on 'speex'
  depends_on 'srt'
  depends_on 'tesseract'
  depends_on 'theora'
  depends_on 'webp'
  depends_on 'x264'
  depends_on 'x265'
  depends_on 'xvid'
  depends_on 'xz'

  uses_from_macos 'bzip2'
  uses_from_macos 'libxml2'
  uses_from_macos 'zlib'

  on_linux do
    depends_on 'libxv'
  end

  if build.with? 'openssl'
    depends_on 'openssl'
  else
    depends_on 'gnutls'
  end

  depends_on 'chromaprint' => :optional
  depends_on 'fdk-aac' => :optional
  depends_on 'game-music-emu' => :optional
  depends_on 'libbs2b' => :optional
  depends_on 'libcaca' => :optional
  depends_on 'libgsm' => :optional
  depends_on 'libmodplug' => :optional
  depends_on 'librsvg' => :optional
  depends_on 'libssh' => :optional
  depends_on 'libvmaf' => :optional
  depends_on 'openh264' => :optional
  depends_on 'rtmpdump' => :optional
  depends_on 'two-lame' => :optional
  depends_on 'wavpack' => :optional
  depends_on 'zeromq' => :optional
  depends_on 'zimg' => :optional

  def install
    args = %W[
      --prefix=#{prefix}
      --enable-shared
      --enable-pthreads
      --enable-version3
      --enable-avresample
      --cc=#{ENV.cc}
      --host-cflags=#{ENV.cflags}
      --host-ldflags=#{ENV.ldflags}
      --enable-ffplay
      --enable-gpl
      --enable-libaom
      --enable-libbluray
      --enable-libdav1d
      --enable-libmp3lame
      --enable-libopus
      --enable-librav1e
      --enable-librubberband
      --enable-libsnappy
      --enable-libsrt
      --enable-libtesseract
      --enable-libtheora
      --enable-libvidstab
      --enable-libvorbis
      --enable-libvpx
      --enable-libwebp
      --enable-libx264
      --enable-libx265
      --enable-libxml2
      --enable-libxvid
      --enable-lzma
      --enable-libfontconfig
      --enable-libfreetype
      --enable-frei0r
      --enable-libass
      --enable-libopencore-amrnb
      --enable-libopencore-amrwb
      --enable-libopenjpeg
      --enable-libspeex
      --enable-libsoxr
      --disable-libjack
      --disable-indev=jack
    ]

    on_macos do
      # Since Mountain Lion it needs corefoundation, coremedia, corevideo
      args << '--enable-videotoolbox'
      # Deleted line (args << '--enable-opencl' if MacOS.version > :lion)
    end

    args << (build.with?('openssl') ? '--enable-openssl' : '--enable-gnutls')
    args << '--enable-chromaprint' if build.with? 'chromaprint'
    args << '--enable-libbs2b' if build.with? 'libbs2b'
    args << '--enable-libcaca' if build.with? 'libcaca'
    args << '--enable-libfdk-aac' if build.with? 'fdk-aac'
    args << '--enable-libgme' if build.with? 'game-music-emu'
    args << '--enable-libgsm' if build.with? 'libgsm'
    args << '--enable-libmodplug' if build.with? 'libmodplug'
    args << '--enable-libopenh264' if build.with? 'openh264'
    args << '--enable-librsvg' if build.with? 'librsvg'
    args << '--enable-librtmp' if build.with? 'rtmpdump'
    # args << "--enable-libsrt" if build.with? "srt"
    args << '--enable-libssh' if build.with? 'libssh'
    args << '--enable-libtwolame' if build.with? 'two-lame'
    args << '--enable-libvmaf' if build.with? 'libvmaf'
    args << '--enable-libwavpack' if build.with? 'wavpack'
    args << '--enable-libzimg' if build.with? 'zimg'
    args << '--enable-libzmq' if build.with? 'zeromq'

    # These librares are GPL-incompatible, and require ffmpeg be built with
    # the "--enable-nonfree" flag, which produces unredistributable libraries
    args << '--enable-nonfree' if build.with?('decklink') || build.with?('fdk-aac') || build.with?('openssl')

    if build.with? 'decklink'
      args << '--enable-decklink'
      args << "--extra-cflags=-I#{include}"
      args << "--extra-ldflags=-L#{include}"
    end

    system './configure', *args
    system 'make', 'install'

    # Build and install additional FFmpeg tools
    system 'make', 'alltools'
    bin.install(Dir['tools/*'].select { |f| File.executable? f })

    # Fix for Non-executables that were installed to bin/
    mv(bin/'python', pkgshare/'python', force: true)
  end

  test do
    # Create an example mp4 file
    mp4out = testpath/'video.mp4'
    system(bin/'ffmpeg', '-filter_complex', 'testsrc=rate=1:duration=1', mp4out)
    assert_predicate mp4out, :exist?
  end
end
