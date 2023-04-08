#!/bin/sh
set -e
  
if [ -n "$PLUGIN_ACCESS_TOKEN" ]
then
  SPACE_ACCESS_TOKEN="$PLUGIN_ACCESS_TOKEN"
fi

if [ -n "$PLUGIN_ID" ]
then
  SPACE_ID="$PLUGIN_ID"
fi

if [ -n "$PLUGIN_TAG" ]
then
  SPACE_PUSH_TAG="$PLUGIN_TAG"
fi

if [ -n "$PLUGIN_DIR" ]
then
  SPACE_DIR="$PLUGIN_DIR"
fi

if [ -n "$PLUGIN_LISTED" ]
then
  SPACE_LISTED="$PLUGIN_LISTED"
fi

if [ -n "$PLUGIN_NOTES" ]
then
  SPACE_NOTES="$PLUGIN_NOTES"
fi

if [ -n "$PLUGIN_RID" ]
then
  SPACE_RID="$PLUGIN_RID"
fi

if [ -n "$PLUGIN_VERSION" ]
then
  SPACE_PUSH_TAG="$PLUGIN_VERSION"
fi


if [ -z "$SPACE_ACCESS_TOKEN" ]
then 
  if [ -z "$SPACE_ID" ]
  then 
    echo "> Error! space_token and space_id is required"
    exit 1;
  fi
fi


echo "> Space login with access token"
echo "{\"access_token\":\"$SPACE_ACCESS_TOKEN\"}" > /root/.detaspace/space_tokens

echo "> Start push your project to Deta space…"
mkdir .space && echo "{\"id\":\"${SPACE_ID}\",\"name\":\"\","alias":\"\"}" > ./.space/meta
/root/.detaspace/bin/space push --tag=$SPACE_PUSH_TAG

rc=$?;
if [[ $rc != 0 ]];
then 
    echo "> space push non-zero exit code $rc" &&
    exit $rc
else
    echo $'\n'"> Successfully pushed!"$'\n'
fi

echo "> Start release your build version"
/root/.detaspace/bin/space release --listed=$SPACE_LISTED --dir=$SPACE_DIR --notes=$SPACE_NOTES --rid=$SPACE_RID --version=$SPACE_VERSION
if [[ $rc != 0 ]];
then 
    echo "> space release non-zero exit code $rc" &&
    exit $rc
else
    echo $'\n'"> Successfully released!"$'\n'
fi