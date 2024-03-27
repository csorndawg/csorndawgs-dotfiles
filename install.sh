#!/usr/bin/env bash

BASEDIR=$(dirname $(pwd))
BASEDIR=$(pwd)
cd $BASEDIR

# resolve dependencies (e.g. vim-plug requires .vim/)
SUBDIRS=(vim tmux)
VIM_DIRS_REQ=(".vim/undodir" ".vim")
TMUX_DIRS_REQ=(".tmux")

# make symlinks
SYMLINK_BASEDIR="/home/""$(whoami)"
SYMLINK_TARGETS=("vimrc" "bashrc" "tmux.conf")
for st in ${SYMLINK_TARGETS[@]};
do
    echo ""
    echo ""
    echo "Generating symlinks  $st"

    # set symlink src and target path (assumes target is user's home)
    SYMLINK_SRC="$(pwd)/$st" 
    SYMLINK_TARG="$SYMLINK_BASEDIR/.$st" 

    # vim plugin requirement
    if [[ $st = "vimrc" ]];
    then
	    for dir in ${VIM_DIRS_REQ[@]};
	    do
		    NEW_DIR="$BASEDIR/$dir"
		    echo "Creating dir $NEW_DIR"
		    mkdir $NEW_DIR -p 
	    done

	    #  create symlink now dependencies resolved
	    echo ln -sf "$SYMLINK_SRC" "S$YMLINK_SRC"
	    ln -sf "$SYMLINK_SRC" "$SYMLINK_TARG" &&  echo "$st symlink has been created"
	    continue
    fi

    # tmux plugin requirement	  
    if [[ $st = 'tmux.conf' ]];
    then
	    for dir in ${TMUX_DIRS_REQ[@]};
	    do
		    NEW_DIR="$BASEDIR/$dir"
		    echo "Creating dir $NEW_DIR"
		    mkdir $NEW_DIR -p 
	    done
	    #  create symlink now dependencies resolved
	    echo ln -sf "$SYMLINK_SRC" "$SYMLINK_SRC"
	    ln -sf "$SYMLINK_SRC" "$SYMLINK_TARG" &&  echo "$st symlink has been created"
	    continue
    fi

    #  create symlink now dependencies resolved
    echo ln -sf "$SYMLINK_SRC" "$SYMLINK_SRC"
    echo "Generating symlinks"
    ln -sf "$SYMLINK_SRC" "$SYMLINK_TARG" && echo "$st symlink has been created"

done
