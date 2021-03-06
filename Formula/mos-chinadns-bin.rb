class MosChinadnsBin < Formula
  desc "Cross-platform DNS routing app"
  homepage "https://github.com/IrineSistiana/mos-chinadns"
  url "https://github.com/IrineSistiana/mos-chinadns/releases/download/v#{version}/mos-chinadns-darwin-amd64.zip"
  version "1.5.6"  # latest version 1.5.7 need to be compiled from source
  sha256 "6bd6d24ef72d743ee67dcfa193c3e8875b1740f4c2e6c583a5345b9f15eb20f4"
  revision 1

  conflicts_with "mos-chinadns", because: "same package"

  # TODO: drop one cidr list?
  resource "china_ip_list" do
    url "https://raw.githubusercontent.com/17mon/china_ip_list/master/china_ip_list.txt"
  end

  resource "geoip2-cn-txt" do
    url "https://cdn.jsdelivr.net/gh/Hackl0us/GeoIP2-CN@release/CN-ip-cidr.txt"
  end

  def install
    bin.install "mos-chinadns"

    share_dst = "#{share}/mos-chinadns/".to_s
    mkdir_p share_dst
    cp_r Dir["*.list"], share_dst
    cp_r Dir["*.yaml"], share_dst
    resource("china_ip_list").stage do
      cp "china_ip_list.txt", share_dst
    end
    resource("geoip2-cn-txt").stage do
      cp "CN-ip-cidr.txt", share_dst
    end

    etc_temp = "#{buildpath}/etc_temp"
    cp_r "#{share_dst}.", etc_temp
    # Conf installation borrowed from php.rb
    Dir.chdir(etc_temp.to_s) do
      config_path = etc/"mos-chinadns"
      Dir.glob(["*.yaml", "*.list", "*.txt"]).each do |dst|
        dst_default = config_path/"#{dst}.default"
        rm(dst_default) if dst_default.exist?
        config_path.install dst
      end
    end
    rm_rf etc_temp.to_s
  end

  def caveats
    <<~OUTPUT
      Homebrew services are run as LaunchAgents by current user.
      To make mos-chinadns service work on privileged port, like port 53,
      you need to run it as a "global" daemon in /Library/LaunchAgents.

        sudo cp -f #{plist_path} /Library/LaunchAgents/

      Dont' use `sudo brew services`. This very command will ruin the file perms.
    OUTPUT
  end

  plist_options manual: "mos-chinadns -dir #{HOMEBREW_PREFIX}/etc/mos-chinadns -c #{HOMEBREW_PREFIX}/etc/mos-chinadns/config.yaml"
  def plist
    <<~RETURN_STRING
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
      <dict>
          <key>KeepAlive</key>
          <dict>
              <key>SuccessfulExit</key>
              <false/>
          </dict>
          <key>Label</key>
          <string>#{plist_name}</string>
          <key>ProgramArguments</key>
          <array>
              <string>#{opt_bin}/mos-chinadns</string>
              <string>-dir</string>
              <string>#{etc}/mos-chinadns</string>
              <string>-c</string>
              <string>#{etc}/mos-chinadns/config.yaml</string>
          </array>
          <key>RunAtLoad</key>
          <true/>
      </dict>
      </plist>
    RETURN_STRING
  end

  test do
    system "#{bin}/mos-chinadns", "-v"
  end
end
