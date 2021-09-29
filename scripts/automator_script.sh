# Define Constants
GOOGLE_CHROME="Google Chrome"
GOOGLE_CHROME_APP_PATH="$(dirname "$(dirname "$0" | sed -e "s%/Contents/Resources$%%")")"
GOOGLE_CHROME_APP_NAME="$(basename "$(dirname "$0" | sed -e "s%/Contents/Resources$%%")" | sed -e "s/\.app$//")"
GOOGLE_CHROME_PATH="$(mdfind 'kMDItemContentType == "com.apple.application-bundle" && kMDItemFSName = "'"$GOOGLE_CHROME.app"'"' | head -1)"

if [ -z "$GOOGLE_CHROME_PATH" ]; then
    GOOGLE_CHROME_PATH="$GOOGLE_CHROME_APP_PATH/$GOOGLE_CHROME.app"
fi


if [ -e "$GOOGLE_CHROME_PATH" ]; then
    if [ $(ps -u $(id -u) | grep -c "$GOOGLE_CHROME_PATH/Contents/MacOS/Google Chrome") -gt 1 ]; then
        osascript -e 'tell application "'"$GOOGLE_CHROME"'"' \
                  -e '  set IncogWin to make new window with properties {mode:"incognito"}' \
                  -e '  set URL of active tab of IncogWin to "chrome://newtab"' \
                  -e 'end tell'
    else
        open -n "$GOOGLE_CHROME_PATH" --args --incognito --new-window "chome//:newtab"
    fi

    osascript -e 'tell application "'"$GOOGLE_CHROME"'" to activate'
fi

exit 0