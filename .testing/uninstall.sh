#!/bin/sh

getuserandpass() {
	# Prompts user for new username an password.
	name=$(whiptail --inputbox "First, please enter a name for the user account." 10 60 3>&1 1>&2 2>&3 3>&1) || exit 1
	while ! echo "$name" | grep -q "^[a-z_][a-z0-9_-]*$"; do
		name=$(whiptail --nocancel --inputbox "Username not valid. Give a username beginning with a letter, with only lowercase letters, - or _." 10 60 3>&1 1>&2 2>&3 3>&1)
	done
}

uninstallbins() {
	rm -rf /home/"$name"/.local/bin
}

uninstalllarbs() {
	rm -rf /home/"$name"/.local/share/larbs
}

uninstalllibrewolf() {
	rm -rf /home/"$name"/.librewolf
	rm -rf /home/"$name"/.config/firefox
	rm -rf /home/"$name"/.cache/librewolf
}

uninstallfirefox() {
	rm -rf /home/"$name"/.mozilla/firefox
}

uninstalldoomemacs() {
	# core
	rm -rf /home/"$name"/.config/emacs

	# personal
	rm -rf /home/"$name"/.config/doom
}

uninstallroswell() {
	rm -rf /home/"$name"/.local/share/roswell
}

finalize() {
	whiptail --title "All done!" \
		--msgbox "Congrats! Provided there were no hidden errors, things have been uninstalled successfully." 13 80
}

# Get and verify username and password.
getuserandpass || error "User exited."

uninstalllibrewolf
uninstallfirefox

uninstalldoomemacs

uninstalllarbs
uninstallroswell

uninstallbins

finalize
