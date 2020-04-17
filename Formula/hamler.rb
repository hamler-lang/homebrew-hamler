class Hamler < Formula
  homepage "https://emqx.io"
  url "https://repos.emqx.io/hamler/hamler-0.0.2.tgz"
  sha256 "fba0c76e2a6fb25846f8d53e7ae389e37e870b49cf2d563ed406c8e989df6494"
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
    system "ln", "-s", "#{prefix}", "/usr/local/lib/hamler"
  end

  test do
    system bin/"hamler", "--version"
  end
end
