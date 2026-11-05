cask "studio@beta" do
  version "0.1.0-beta.5"
  sha256 "0270afc5148e516ccf5773a3114ca5d0b7a1cb30ee0c4d3054673dc3b140a28b"

  url "https://github.com/simplymate/studio/releases/download/desktop-v#{version}/Simplymate-Studio_#{version}_universal.dmg"
  name "Simplymate Studio"
  desc "Data protection workspace for firms (beta channel)"
  homepage "https://simplymate.com/"

  livecheck do
    url :url
    regex(/^desktop-v(\d+\.\d+\.\d+-beta\.\d+)$/i)
    strategy :github_releases do |json, regex|
      json.map do |release|
        next if release["draft"]

        match = release["tag_name"]&.match(regex)
        next if match.blank?

        match[1]
      end
    end
  end

  conflicts_with cask: "studio"
  depends_on macos: :ventura

  app "Simplymate Studio.app"

  zap trash: [
    "~/Library/Application Support/com.simplymate.desktop",
    "~/Library/Caches/com.simplymate.desktop",
    "~/Library/Preferences/com.simplymate.desktop.plist",
    "~/Library/Saved Application State/com.simplymate.desktop.savedState",
  ]
end
