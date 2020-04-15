class Hamler < Formula
  homepage "https://emqx.io"
  url "https://repos.emqx.io/hamler/hamler-0.0.1.zip"
  sha256 "7d09b51ec5db515adb4c72edbb1cd28dd14c11ac78d1121d71f4dd99d6e9d56e"
  version "0.0.1"

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

end
