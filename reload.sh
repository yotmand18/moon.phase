#!/bin/bash

WIDGET_ID="moon.phase"
WIDGET_PATH="$HOME/desk/proj/moon.phase"

echo "Removing old installation..."
kpackagetool6 --type Plasma/Applet --remove $WIDGET_ID 2>/dev/null
rm -rf "$HOME/.local/share/plasma/plasmoids/$WIDGET_ID"
rm -rf "$HOME/.local/share/kpackage/generic/$WIDGET_ID"

echo "Installing fresh..."
kpackagetool6 --type Plasma/Applet --install $WIDGET_PATH

echo "Restarting plasmashell..."
plasmashell --replace &

echo "Done! Re-add the widget to your panel."
