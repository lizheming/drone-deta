#!/bin/sh
set -e
  
if [ -n "$PLUGIN_ACCESS_TOKEN" ]
then
  DETA_ACCESS_TOKEN="$PLUGIN_ACCESS_TOKEN"
fi

if [ -n "$PLUGIN_NAME" ]
then 
  DETA_NAME="$PLUGIN_NAME"
fi

if [ -n "$PLUGIN_PROJECT" ]
then 
  DETA_PROJECT="$PLUGIN_PROJECT"
fi

if [ -z "$DETA_PROJECT" ]
then
  DETA_PROJECT="default"
fi

if [ -n "$PLUGIN_PROJECT_DIR" ]
then
  DETA_PROJECT_DIR="$PLUGIN_PROJECT_DIR"
fi

if [ -z "$DETA_PROJECT_DIR" ]
then
  DETA_PROJECT_DIR="."
fi

if [ -z "$DETA_ACCESS_TOKEN" ]
then 
  if [ -z "$DETA_NAME" ]
  then
    echo "> Error! deta_token and deta_name is required"
    exit 1;
  fi
fi


cd "$DETA_PROJECT_DIR"
~/.deta/bin/deta clone --name "$DETA_NAME" --project "$DETA_PROJECT" tmp/
cp -r tmp/.deta .

echo "> Updating your Deta site…"
~/.deta/bin/deta deploy
rc=$?;
if [[ $rc != 0 ]];
then 
    echo "> non-zero exit code $rc" &&
    exit $rc
else
    echo $'\n'"> Successfully deployed!"$'\n'
fi