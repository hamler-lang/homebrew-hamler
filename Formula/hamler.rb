class Hamler < Formula
  homepage "https://hamler-lang.org/"
  url "https://s3-us-west-2.amazonaws.com/packages.emqx/hamler/homebrew/hamler-0.3.tgz"
  sha256 "e2d4fa9bc71d79e75a176fa22d70bc09c41ba6b55332e61bbad2d3a43cc626af"
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
