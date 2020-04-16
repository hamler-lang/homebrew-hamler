class Hamler < Formula
  homepage "https://emqx.io"
  url "https://repos.emqx.io/hamler/hamler-0.0.2.zip"
  sha256 "bac1248011f00dd9ddc015ee0ae2de14d7b9194447e972511cbd0ff43dbdac30"
  version "0.0.2"

  depends_on "erlang"

  def install
    prefix.install Dir["*"]
    bin.install Dir[libexec/"/bin/hamler"]
  end

  plist_options :manual => "hamler"

  def plist; <<-EOS
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN"
    "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
      <dict>
        <key>Label</key>
        <string>#{plist_name}</string>
        <key>Program</key>
        <string>#{opt_bin}/hamler</string>
        <key>RunAtLoad</key>
        <true/>
        <key>EnvironmentVariables</key>
        <dict>
          <!-- need erl in the path -->
          <key>PATH</key>
          <string>#{HOMEBREW_PREFIX}/sbin:/usr/bin:/bin:#{HOMEBREW_PREFIX}/bin</string>
        </dict>
      </dict>
    </plist>
    EOS
  end

  def post_install
    system "ln", "-s", "#{prefix}/lib/hanmler", "/usr/local/lib/erlang/lib/hamler-#{version}"
  end

  test do
    system bin/"hamler", "--version"
  end

  def pre_uninstall
    system "rm -f /usr/local/lib/erlang/lib/hamler-#{version}"
  end
end
