#!/bin/sh
#git_diff_macvim

mvim --servername GITDIFF --remote-tab-silent +"vertical diffsplit $2|wincmd w" "$5"
sleep 0.1

SN=`mvim --serverlist | grep "GITDIFF"`
until [ "$SN" == "GITDIFF" ]; do
  sleep 0.1
  SN=`mvim --serverlist | grep "GITDIFF"`
done

