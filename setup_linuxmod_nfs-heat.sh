#!/bin/sh

FROSTY_PROFILE_PATH="ModData/Editor"
MODFOLDER="LinuxMod" #if you change this, make sure to also alter runMod.cmd

BCRYPT="bcrypt.dll"

#cd to script folder
cd -P -- "$(dirname -- "$0")"

if [ ! -d "$FROSTY_PROFILE_PATH" ]; then
	>&2 echo "Could not find Frosty profile ($FROSTY_PROFILE_PATH), modify this script to change the FROSTY_PROFILE_PATH"
	exit 1
fi

#Frosty likes to delete any file with the same bytes as "bcrypt.dll" when launching
if [ -e "$BCRYPT" ]; then
	chmod 555 "$BCRYPT" #read+execute
else
	>&2 echo "!! Failed to find $BCRYPT - Frosty has likely deleted it !!"
	>&2 echo "Copy $BCRYPT back into this folder and rerun this script"
	exit 1
fi

rm -rf "$MODFOLDER"
mkdir "$MODFOLDER"

#all folders/files in the $MODFOLDER will be lowercase for ease and for parity with Frosty - Proton/Wine has no issue reading case-insensitive paths
ln -sr ./Data "$MODFOLDER/data"
cp -r "$FROSTY_PROFILE_PATH/patch" "$MODFOLDER"

ln -sr ./Patch/Win32/configurations/superbundleinstallpackage/* "$MODFOLDER/patch/win32/configurations/superbundleinstallpackage/"
ln -sr ./Patch/Win32/configurations/superbundleinstallpackage2/* "$MODFOLDER/patch/win32/configurations/superbundleinstallpackage2/"

ln -sr ./Patch/Win32/levels/frontend/* "$MODFOLDER/patch/win32/levels/frontend/"
ln -sr ./Patch/Win32/levels/mainlevel/* "$MODFOLDER/patch/win32/levels/mainlevel/"

ln -sr ./Patch/Win32/loc/* "$MODFOLDER/patch/win32/loc/"

ln -sr ./Patch/Win32/* "$MODFOLDER/patch/win32/"
