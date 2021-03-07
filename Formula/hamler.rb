class Hamler < Formula
  homepage "https://hamler-lang.org/"
  url "https://s3-us-west-2.amazonaws.com/packages.emqx/hamler/homebrew/hamler-0.3.tgz"
  sha256 "e37644e93096e47a90a2b724e7e8cd40680e493ea9299416077022f9defb8601"
  version "0.3"

  depends_on "erlang" => "23"

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
