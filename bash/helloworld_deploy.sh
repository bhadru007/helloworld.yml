#!/bin/bash

mkdir /tmp/buildDir

cd /tmp/buildDir

git clone https://github.com/warpedcodemonkey/helloworld.git

aws deploy push --application-name $2 --description "A deployment" --ignore-hidden-files --s3-location s3://$1/deploy-bundle.zip --source /tmp/buildDir/helloworld/

aws deploy create-deployment --application-name $2 --s3-location bucket=$1,key=deploy-bundle.zip,bundleType=zip --deployment-group-name $3 --deployment-config-name CodeDeployDefault.OneAtATime --description "My Deployment"

cd ~

rm -fr /tmp/buildDir