class MosdnsBin < Formula
  desc 'Flexible forwarding DNS client'
  homepage 'https://github.com/IrineSistiana/mosdns'
  version '1.8.0'
  if OS.mac?
    url "https://github.com/IrineSistiana/mosdns/releases/download/v#{version}/mosdns-darwin-amd64.zip"
    sha256 '8e0f36416c27c02c930768686ee6f14ac26d7d28f6659b7110cb0e74496a42c2'
  elsif OS.linux?
    url "https://github.com/IrineSistiana/mosdns/releases/download/v#{version}/mosdns-linux-amd64.zip"
    sha256 '0adffff63544b87fef15689f482cd53c85848084498ef33ffc4d2da29b153975'
  end

  livecheck do
    url 'https://github.com/IrineSistiana/mosdns/releases/latest'
    regex(%r{href=.*?/tag/v?(\d+(?:\.\d+)+[a-z]?)["' >]}i)
  end

  bottle :unneeded

  conflicts_with 'mosdns', because: 'same package'

  # TODO: drop one cidr list?
  resource 'china_ip_list' do
    url 'https://raw.githubusercontent.com/17mon/china_ip_list/master/china_ip_list.txt'
  end

  resource 'geoip2-cn-txt' do
    url 'https://cdn.jsdelivr.net/gh/Hackl0us/GeoIP2-CN@release/CN-ip-cidr.txt'
  end

  def install
    bin.install 'mosdns'

    # rename config-template.yaml, seems unneeded >= 1.5.0
    mv('config-template.yaml', 'config.yaml') if File.file?('config-template.yaml')
    share_dst = "#{prefix}/share/mosdns"
    mkdir_p share_dst.to_s
    cp_r Dir['*.list'], "#{share_dst}/"
    cp_r Dir['*.yaml'], "#{share_dst}/"
    resource('china_ip_list').stage do
      cp 'china_ip_list.txt', "#{share_dst}/"
    end
    resource('geoip2-cn-txt').stage do
      cp 'CN-ip-cidr.txt', "#{share_dst}/"
    end

    etc_temp = "#{buildpath}/etc_temp"
    cp_r "#{share_dst}/.", etc_temp
    # Conf installation borrowed from php.rb
    Dir.chdir(etc_temp.to_s) do
      config_path = etc/'mosdns'
      Dir.glob(['*.yaml', '*.list', '*.txt']).each do |dst|
        dst_default = config_path/"#{dst}.default"
        rm(dst_default) if dst_default.exist?
        config_path.install dst
      end
    end
    rm_rf etc_temp.to_s
  end

  def post_install
    (var/'log/mosdns').mkpath
    chmod 0o755, var/'log/mosdns'
  end

  test do
    system "#{bin}/mosdns", '-v'
  end

  if OS.mac?
    def caveats
      <<~OUTPUT
        Homebrew services are run as LaunchAgents by current user.
        To make mosdns service work on privileged port, like port 53,
        you need to run it as a "global" daemon in /Library/LaunchAgents.

          sudo cp -f #{plist_path} /Library/LaunchAgents/

        After using `sudo` with `brew services`. Run `brew fix-perm`.
      OUTPUT
    end
  end

  plist_options manual: 'mosdns -dir /usr/local/etc/mosdns -c /usr/local/etc/mosdns/config.yaml'

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
              <string>#{opt_bin}/mosdns</string>
              <string>-dir</string>
              <string>#{etc}/mosdns</string>
              <string>-c</string>
              <string>#{etc}/mosdns/config.yaml</string>
          </array>
          <key>RunAtLoad</key>
          <true/>
          <key>StandardErrorPath</key>
          <string>#{var}/log/mosdns/mosdns.log</string>
          <key>StandardOutPath</key>
          <string>#{var}/log/mosdns/mosdns.log</string>
      </dict>
      </plist>
    RETURN_STRING
  end
end
