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
mkdir .space && echo "{\"id\":\"${SPACE_ID}\",\"name\":\"\",\"alias\":\"\"}" > ./.space/meta

echo "> Start push your project to Deta space…"
pushArgs=""
if [ -n "$SPACE_PUSH_TAG" ]; then
  pushArgs="$pushArgs --tag=$SPACE_PUSH_TAG"
fi

echo "> push command: space push $pushArgs"

/root/.detaspace/bin/space push $pushArgs # | tee ./push.log
rc=$?;
if [[ $rc != 0 ]];
then 
    echo "> space push non-zero exit code $rc" &&
    exit $rc
else
    echo $'\n'"> Successfully pushed!"$'\n'
fi

echo "> Start release your build version"

# revision=$(grep -oE 'created revision: .*$' ./push.log | awk '{print $3}')
# releaseArgs="--rid=$revision"
releaseArgs="--latest"
if [ -n "$SPACE_LISTED" ]; then
  releaseArgs="$releaseArgs --listed=$SPACE_LISTED"
fi
if [ -n "$SPACE_DIR" ]; then
  releaseArgs="$releaseArgs --dir=$SPACE_DIR"
fi
if [ -n "$SPACE_NOTES" ]; then
  releaseArgs="$releaseArgs --notes=$SPACE_NOTES"
fi
if [ -n "$SPACE_RID" ]; then
  releaseArgs="$releaseArgs --rid=$SPACE_RID"
fi
if [ -n "$SPACE_VERSION" ]; then
  releaseArgs="$releaseArgs --version=$SPACE_VERSION"
fi

echo "> release command: space release $releaseArgs"

/root/.detaspace/bin/space release $releaseArgs
if [[ $rc != 0 ]];
then 
    echo "> space release non-zero exit code $rc" &&
    exit $rc
else
    echo $'\n'"> Successfully released!"$'\n'
fi