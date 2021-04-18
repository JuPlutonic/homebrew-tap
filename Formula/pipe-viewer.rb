class PipeViewer < Formula
  desc 'A lightweight YouTube client for Linux (fork of straw-viewer)'
  homepage 'https://trizenx.blogspot.com/2012/03/gtk-straw-viewer.html'
  url 'https://github.com/trizen/pipe-viewer/archive/refs/tags/0.0.9.tar.gz'
  sha256 '598ec7c39be0a42900ed1f4c5c68c26a728dd09b774e9dd38a873aa2def76e27'
  head 'https://github.com/trizen/pipe-viewer.git'

  resource 'inc::latest' do
    url 'https://cpan.metacpan.org/authors/id/D/DA/DAGOLDEN/inc-latest-0.500.tar.gz'
    sha256 'daa905f363c6a748deb7c408473870563fcac79b9e3e95b26e130a4a8dc3c611'
  end

  # Dep. for Module::Build
  resource 'TAP::Harness' do
    url 'https://cpan.metacpan.org/authors/id/L/LE/LEONT/Test-Harness-3.43_02.tar.gz'
    sha256 '019be59351a277c483f2bfb872294016c5831b67193825d5519dc773e11cc63e'
  end

  # Dep. for Module::Build
  resource 'CPAN::Meta' do
    url 'https://cpan.metacpan.org/authors/id/D/DA/DAGOLDEN/CPAN-Meta-2.143240.tar.gz'
    sha256 'c6d1aa77984154bf72bbca3ac30b6a092379ecd7fdc6d2ddc1addc0b6f5f00b5'
  end

  # Build dep.
  resource 'Module::Build' do
    url 'https://cpan.metacpan.org/authors/id/L/LE/LEONT/Module-Build-0.4231.tar.gz'
    sha256 '7e0f4c692c1740c1ac84ea14d7ea3d8bc798b2fb26c09877229e04f430b2b717'
  end

  # Runtime deps
  resource 'Data::Dump' do
    url 'https://cpan.metacpan.org/authors/id/G/GA/GAAS/Data-Dump-1.23.tar.gz'
    sha256 'af53b05ef1387b4cab4427e6789179283e4f0da8cf036e8db516ddb344512b65'
  end

  unless OS.linux?
    resource 'Encode' do
      url 'https://cpan.metacpan.org/authors/id/D/DA/DANKOGAI/Encode-3.08.tar.gz'
      sha256 'ed063d01d01a140a3a3ec0aeba2f2b4849a35c18ca96ac231a5d7c7d54d17b5b'
    end
  end

  resource 'File::Path' do
    url 'https://cpan.metacpan.org/authors/id/J/JK/JKEENAN/File-Path-2.18.tar.gz'
    sha256 '980f0a17edb353df46e9cd7b357f9f5929cde0f80c45fd7a06cf7e0e8bd6addd'
  end

  unless OS.linux?
    resource 'File::Spec' do
      # N.B. also includes File::Spec::Functions
      url 'https://cpan.metacpan.org/authors/id/X/XS/XSAWYERX/PathTools-3.75.tar.gz'
      sha256 'a558503aa6b1f8c727c0073339081a77888606aa701ada1ad62dd9d8c3f945a2'
    end
  end

  resource 'Getopt::Long' do
    url 'https://cpan.metacpan.org/authors/id/J/JV/JV/Getopt-Long-2.52.tar.gz'
    sha256 '9dc7a7c373353d5c05efae548e7b123aa8a31d1f506eb8dbbec8f0dca77705fa'
  end

  resource 'HTTP::Request' do
    url 'https://cpan.metacpan.org/authors/id/O/OA/OALDERS/HTTP-Message-6.29.tar.gz'
    sha256 'f4417970679e08f6deb0609009aa9515dee0c8d91dbadd6b86a26e2b8e0d6341'
  end

  resource 'JSON' do
    url 'https://cpan.metacpan.org/authors/id/I/IS/ISHIGAKI/JSON-4.03.tar.gz'
    sha256 'e41f8761a5e7b9b27af26fe5780d44550d7a6a66bf3078e337d676d07a699941'
  end

  unless OS.linux?
    resource 'JSON-PP' do
      url 'https://cpan.metacpan.org/authors/id/M/MA/MAKAMAKA/JSON-PP-2.27300.tar.gz'
      sha256 '5feef3067be4acd99ca0ebb29cf1ac1cdb338fe46977585bd1e473ea4bab71a3'
    end
  end

  resource 'LWP::Protocol::https' do
    url 'https://cpan.metacpan.org/authors/id/O/OA/OALDERS/LWP-Protocol-https-6.10.tar.gz'
    sha256 'cecfc31fe2d4fc854cac47fce13d3a502e8fdfe60c5bc1c09535743185f2a86c'
  end

  resource 'LWP::UserAgent' do
    url 'https://cpan.metacpan.org/authors/id/O/OA/OALDERS/libwww-perl-6.53.tar.gz'
    sha256 '9cbb7c688416a20c1aba9a32568504af1143ced58b572c502a1b2fb8a500f535'
  end

  unless OS.linux?
    resource 'List::Util' do
      url 'https://cpan.metacpan.org/authors/id/P/PE/PEVANS/Scalar-List-Utils-1.56.tar.gz'
      sha256 '15b8537d40fb3e6dae64b2e7e983c47a99b2c20816a180bb9c868b787a12ab5b'
    end
  end

  unless OS.linux?
    resource 'MIME::Base64' do
      url 'https://cpan.metacpan.org/authors/id/G/GA/GAAS/MIME-Base64-3.15.tar.gz'
      sha256 '7f863566a6a9cb93eda93beadb77d9aa04b9304d769cea3bb921b9a91b3a1eb9'
    end
  end

  resource 'Memoize' do
    url 'https://cpan.metacpan.org/authors/id/M/MJ/MJD/Memoize-1.03.tgz'
    sha256 '5239cc5f644a50b0de9ffeaa51fa9991eb06ecb1bf4678873e3ab89af9c0daf3'
  end

  resource 'Term::ANSIColor' do
    url 'https://cpan.metacpan.org/authors/id/R/RR/RRA/Term-ANSIColor-5.01.tar.gz'
    sha256 '6281bd87cced7a885c38aa104498e3cd4b5f4c276087442cf68c67379318f27d'
  end

  resource 'Term::ReadLine' do
    url 'https://cpan.metacpan.org/authors/id/F/FL/FLORA/Term-ReadLine-1.14.tar.gz'
    sha256 '54523c72b26a04608170849013a433ba400f66b4f9b0524201bfd37ff6e3c477'
  end

  resource 'Text::ParseWords' do
    url 'https://cpan.metacpan.org/authors/id/C/CH/CHORNY/Text-ParseWords-3.30.tar.gz'
    sha256 '85e0238179dd43997e58c66bd51611182bc7d533505029a2db0d3232edaff5e8'
  end

  resource 'Text::Wrap' do
    url 'https://cpan.metacpan.org/authors/id/M/MU/MUIR/modules/Text-Tabs+Wrap-2013.0523.tar.gz'
    sha256 'b9cb056fffb737b9c12862099b952bf4ab4b1f599fd34935356ae57dab6f655f'
  end

  resource 'URI::Escape' do
    url 'https://cpan.metacpan.org/authors/id/O/OA/OALDERS/URI-5.09.tar.gz'
    sha256 '03e63ada499d2645c435a57551f041f3943970492baa3b3338246dab6f1fae0a'
  end

  # Optional runtime deps
  resource 'LWP::UserAgent::Cached' do
    url 'https://cpan.metacpan.org/authors/id/O/OL/OLEG/LWP-UserAgent-Cached-0.08.tar.gz'
    sha256 '3dce5ab4c78041656ce78564f76033e5bd1ec386f54d2e7b30740ae48ee787c3'
  end

  resource 'Mozilla::CA' do
    url 'https://cpan.metacpan.org/authors/id/A/AB/ABH/Mozilla-CA-20200520.tar.gz'
    sha256 'b3ca0002310bf24a16c0d5920bdea97a2f46e77e7be3e7377e850d033387c726'
  end

  def install
    ENV.append 'PERL_MM_USE_DEFAULT', 1
    ENV.prepend_create_path 'PERL5LIB', libexec/'lib/perl5'

    resources.each do |r|
      r.stage do
        system 'perl', 'Makefile.PL', "INSTALL_BASE=#{libexec}"
        system 'make'
        system 'make', 'install'
      end
    end

    ENV.prepend_path 'PATH', libexec/'bin'

    system 'perl', 'Build.PL', '--install_base', libexec
    system './Build', 'install'

    %w[pipe-viewer].each do |cmd|
      (bin/cmd).write_env_script(libexec/"bin/#{cmd}", PERL5LIB: ENV['PERL5LIB'])
    end
  end

  test do
    assert_match( version.to_s,
                  shell_output("#{bin}/pipe-viewer --version").split(/ /)[3])
    assert_match( 'Returning',
                  shell_output("#{bin}/pipe-viewer --debug test").subs('Returning'))
  end
end
