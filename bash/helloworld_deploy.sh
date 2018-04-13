#!/bin/bash

MY_PATH="`dirname \"$0\"`"



mkdir $MY_PATH/buildDir/package -p

cd $MY_PATH/buildDir

git clone https://github.com/warpedcodemonkey/helloworld.git

zip -r helloworld.zip helloworld

aws deploy push --application-name $2 --description "A deployment" --ignore-hidden-files --s3-location s3://$1/deploy-bundle.zip --source $MY_PATH/buildDir/

aws deploy create-deployment --application-name $2 --s3-location bucket=$1,key=deploy-bundle.zip,bundleType=zip --deployment-group-name $3 --deployment-config-name CodeDeployDefault.OneAtATime --description "My Deployment"

cd ~

rm -fr $MY_PATH/buildDir