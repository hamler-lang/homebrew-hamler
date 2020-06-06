class Hamler < Formula
  homepage "https://hamler-lang.org/"
  url "https://repos.emqx.io/hamler/hamler-0.1.tgz"
  sha256 "ad0c791ffea995be61dca902372ffd1f1168d99dba21b4a420ff1cd72093a509"
  version "0.1"

  depends_on "erlang" => "22.1"

  def install
    prefix.install Dir["*"]
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
    system "rm", "-rf", "/usr/local/lib/hamler"
    system "ln", "-s", "#{prefix}", "/usr/local/lib/hamler"
  end

  def post_uninstall
    system "rm", "-rf", "/usr/local/lib/hamler"
  end

  test do
    system bin/"hamler", "--version"
  end
end
