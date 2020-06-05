class Hamler < Formula
  homepage "https://hamler-lang.org"
  url "https://repos.emqx.io/hamler/hamler-0.0.3.tgz"
  sha256 "43d1a2eefb1fa9ebd4d3e179f1cd428524fd58a4da33f567b67246377b463d55"
  version "0.0.3"

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
    system "ln", "-s", "#{prefix}", "/usr/local/lib/hamler"
  end

  test do
    system bin/"hamler", "--version"
  end
end
