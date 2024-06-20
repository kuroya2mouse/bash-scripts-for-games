#!/bin/bash
#First working version, now support only single user.

help()
{
   # Display Help
   echo "Usage: ppt2.sh [OPTION]"
   echo "Running first time without arguments or after reset will be use ~/.local/share/puyopuyotetris2"
   echo "Options:"
   echo "  -e   set steamapi emulator"
   echo "  -c   set config file"
   echo "  -s   set save path."
   echo "  -C   set codex ini path"
  # echo "  -r   report dir"
   echo "  -R   remove links"
   echo
}
noclear=1
 config_path='/home/'$USER'/.local/share/puyopuyotetris2/config.ini'
 save_path='/home/'$USER'/.local/share/puyopuyotetris2/data.bin'
 codex_config_path='/home/'$USER'/.local/share/puyopuyotetris2/steam_emu.ini'
 codex_path='/home/'$USER'/.local/share/puyopuyotetris2/steam_api64.dll'
  param=''

  while :; do
    case "${1-}" in
    -h | --help) help
	exit 0;;
#    -v | --verbose) set -x ;;
#    --no-color) NO_COLOR=1 ;;
    -R | --remove) noclear=0 ;; # example flag
    -p | --param) # example named parameter
      r_path="${2-}"
      shift
      ;;
    -c | --config) # example named parameter
      config_path="${2-}"
      shift
      ;;
    -s | --save) # example named parameter
      save_path="${2-}"
      shift
      ;;
    -C | --codex-config) # example named parameter
      codex_config_path="${2-}"
      shift
      ;;
    -e | --codex) # example named parameter
      codex_path="${2-}"
      shift
      ;;
    -r | --report) # example named parameter
      report_path="${2-}"
      shift
      ;;
    -?*) die "Unknown option: $1" ;;
    *) break ;;
    esac
    shift
  done


if [ $noclear  -eq  0 ]
then
  rm -Rf /tmp/.ppt2
else
mkdir -p /tmp/.ppt2
ln -fs $config_path /tmp/.ppt2/config.ini
ln -fs $save_path /tmp/.ppt2/data.bin
ln -fs $codex_path /tmp/.ppt2/steam_api64.dll
ln -fs $codex_config_path /tmp/.ppt2/steam_emu.ini
wine PuyoPuyoTetris2.exe
fi
