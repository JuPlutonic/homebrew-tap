class Smlnj < Formula
  desc "Standard ML of New Jersey"
  homepage "https://www.smlnj.org/"
  url "http://smlnj.cs.uchicago.edu/dist/working/110.99.1/config.tgz"
  sha256 "1fe1121e833053be2a659840a464f0c4cb3fc3e7a5b0beff6acd0e0b21b5a488"

  livecheck do
    url :homepage
    strategy :page_match
    regex(%r{href=.*?/smlnj-and64-(\d+(?:\.\d+)*)\.pkg}i)
  end

  resource "cm" do
    url "https://www.smlnj.org/dist/working/110.99.1/cm.tgz"
    sha256 "3702d67c5c2634d003c39480a23bf7a6bb7ae5d9b415fc24327ccc3c86db72b7"
  end

  resource "compiler" do
    url "https://www.smlnj.org/dist/working/110.99.1/compiler.tgz"
    sha256 "3311c748e1b8bb6bfb2449f96c2da7f2da9de17461c36e3667dbd3af5709166d"
  end

  resource "runtime" do
    url "https://www.smlnj.org/dist/working/110.99.1/runtime.tgz"
    sha256 "413c389afed2550c2e80965a5b38b09b3157d29f154def00a687327a86c733ff"
  end

  resource "system" do
    url "https://www.smlnj.org/dist/working/110.99.1/system.tgz"
    sha256 "c5c57d2300b25ea90393cabb5c2fb0e157d8aa59c2adb4a73883bc5898da5d82"
  end

  resource "bootstrap" do
    url "https://www.smlnj.org/dist/working/110.99.1/boot.amd64-unix.tgz"
    sha256 "80782f3931c9e1c062abb6a53e520d4fc96d80eeb322c0651a400ffa5a8a2b45"
  end

  resource "mlrisc" do
    url "https://www.smlnj.org/dist/working/110.99.1/MLRISC.tgz"
    sha256 "883d70824c8bedf3a854d83e80730963ba572b796f06a5c1dfe9b1022ce0643f"
  end

  resource "lib" do
    url "https://www.smlnj.org/dist/working/110.99.1/smlnj-lib.tgz"
    sha256 "2b45d27353ed88cb9bd97b2589d705ddfac98fab0181a4a06e2e9c463fa11cfd"
  end

  resource "ckit" do
    url "https://www.smlnj.org/dist/working/110.99.1/ckit.tgz"
    sha256 "89b529614bf1a25ad8789a432f7d0305a98b0aee40427b740bfaa9a599b5f61a"
  end

  resource "nlffi" do
    url "https://www.smlnj.org/dist/working/110.99.1/nlffi.tgz"
    sha256 "f95fc81e82748fcceb3b60038091a6d48db8997d51e9c91eb623128a25fd8b39"
  end

  resource "cml" do
    url "https://www.smlnj.org/dist/working/110.99.1/cml.tgz"
    sha256 "690b8514ffb6dc70485967e6f06f1018e6f8791bf6222aaf5322235e4d177479"
  end

  resource "exene" do
    url "https://www.smlnj.org/dist/working/110.99.1/eXene.tgz"
    sha256 "3036323cec44d6e09206d8c1bc0c4d47d3448c0432164765923e5fe933b80b35"
  end

  resource "ml-lpt" do
    url "https://www.smlnj.org/dist/working/110.99.1/ml-lpt.tgz"
    sha256 "61ddf3574dfd01978c4723d1e0a5b0b2591bcaba0f01a8b063ce08099328b41b"
  end

  resource "ml-lex" do
    url "https://www.smlnj.org/dist/working/110.99.1/ml-lex.tgz"
    sha256 "747206662c80ee817e7a449bd195088921f3cfa3b428ba088bed7c4a5be78448"
  end

  resource "ml-yacc" do
    url "https://www.smlnj.org/dist/working/110.99.1/ml-yacc.tgz"
    sha256 "e81cdbfb95ab245bcb66d7c8a5868b84d936735c999b5d32cf6d4c219c37626a"
  end

  resource "ml-burg" do
    url "https://www.smlnj.org/dist/working/110.99.1/ml-burg.tgz"
    sha256 "6ab342a70f4ee7a4455ee55fe515387932c7b9881f6eda28c4aca591f75e26d8"
  end

  resource "pgraph" do
    url "https://www.smlnj.org/dist/working/110.99.1/pgraph.tgz"
    sha256 "381fa5346529d45b874126230edd96a2ad8a424767b1e5cfc4496aa093950526"
  end

  resource "trace-debug-profile" do
    url "https://www.smlnj.org/dist/working/110.99.1/trace-debug-profile.tgz"
    sha256 "7e49fd7b90d5b2640aa8f204d27434953fd0c0b1ac9ec10b6787f2bc80c488ba"
  end

  resource "heap2asm" do
    url "https://www.smlnj.org/dist/working/110.99.1/heap2asm.tgz"
    sha256 "8c328369d73f63834706e4fd3eba9fc4daa4a6262772984a837c83ff4e140735"
  end

  resource "c" do
    url "https://www.smlnj.org/dist/working/110.99.1/smlnj-c.tgz"
    sha256 "501c52dc8e9c85521dc51de91a485e6d52b270964124616d5594b37382a21dd8"
  end

  def install
    ENV.deparallelize

    # Build in place
    root = prefix/"SMLNJ_HOME"
    root.mkpath
    cp_r buildpath, root/"config"

    # Rewrite targets list (default would be too minimalistic)
    rm root/"config/targets"
    (root/"config/targets").write targets

    # Download and extract all the sources for the base system
    %w[cm compiler runtime system].each do |name|
      resource(name).stage { cp_r pwd, root/"base" }
    end

    # Download the remaining packages that go directly into the root
    %w[
      bootstrap mlrisc lib ckit nlffi
      cml exene ml-lpt ml-lex ml-yacc ml-burg pgraph
      trace-debug-profile heap2asm c
    ].each do |name|
      resource(name).stage { cp_r pwd, root }
    end

    inreplace(root/"base/runtime/objs/mk.x86-darwin", "/usr/bin/as", "as") unless OS.linux?

    # Orrrr, don't mess with our PATH. Superenv carefully sets that up.
    inreplace root/"base/runtime/config/gen-posix-names.sh" do |s|
      s.gsub! "PATH=/bin:/usr/bin", "# do not hardcode the path"
      s.gsub! "/usr/include", "#{MacOS.sdk_path}/usr/include" if OS.mac? && !MacOS::CLT.installed?
    end

    # Make the configure program recognize macOS 10.13. Reported upstream:
    # https://smlnj-gforge.cs.uchicago.edu/tracker/index.php?func=detail&aid=187&group_id=33&atid=215
    inreplace(root/"config/_arch-n-opsys", "16*) OPSYS=darwin", "1*) OPSYS=darwin") unless OS.linux?

    cd root do
      system "config/install.sh", "-default", "64"
    end

    %w[
      sml heap2asm heap2exec ml-antlr
      ml-build ml-burg ml-lex ml-makedepend
      ml-nlffigen ml-ulex ml-yacc
    ].each { |e| bin.install_symlink root/"bin/#{e}" }
  end

  def targets
    <<~EO_LIST
      request ml-ulex
      request ml-ulex-mllex-tool
      request ml-lex
      request ml-lex-lex-ext
      request ml-yacc
      request ml-yacc-grm-ext
      request ml-antlr
      request ml-lpt-lib
      request ml-burg
      request smlnj-lib
      request tdp-util
      request cml
      request cml-lib
      request mlrisc
      request ml-nlffigen
      request ml-nlffi-lib
      request mlrisc-tools
      request eXene
      request pgraph-util
      request ckit
      request heap2asm
    EO_LIST
  end

  def post_install
    path_environment_variable "#{`brew --prefix smlnj`}/bin"
  end

  test do
    system bin/"ml-nlffigen"
    assert_predicate testpath/"NLFFI-Generated/nlffi-generated.cm", :exist?
  end
end
