dirname=`dirname "$0"`
cd $dirname
buildNumber=`/usr/libexec/PlistBuddy -c "Print CFBundleVersion" ./iOS/info.plist`
buildNumber=$(($buildNumber + 1))
/usr/libexec/PlistBuddy -c "Set :CFBundleVersion $buildNumber" "./iOS/info.plist"
/usr/libexec/PlistBuddy -c "Set :CFBundleVersion $buildNumber" "./macOS/info.plist"
/usr/libexec/PlistBuddy -c "Set :CFBundleVersion $buildNumber" "./Astro Launches WatchKit App/info.plist"
/usr/libexec/PlistBuddy -c "Set :CFBundleVersion $buildNumber" "./Astro Launches WatchKit Extension/info.plist"
/usr/libexec/PlistBuddy -c "Set :CFBundleVersion $buildNumber" "./Astro Launches TV/info.plist"


