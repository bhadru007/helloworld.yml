#!/bin/bash

MY_PATH="`dirname \"$0\"`"



mkdir $MY_PATH/buildDir -p

cd $MY_PATH/buildDir

git clone https://github.com/warpedcodemonkey/helloworld.git

cd helloworld
zip -r helloworld.zip **.*

aws deploy push --application-name $2 --description "A deployment" --ignore-hidden-files --s3-location s3://$1/deploy-bundle.zip --source $MY_PATH/buildDir/helloworld

aws deploy create-deployment --application-name $2 --s3-location bucket=$1,key=deploy-bundle.zip,bundleType=zip --deployment-group-name $3 --deployment-config-name CodeDeployDefault.OneAtATime --description "My Deployment"


rm -fr $MY_PATH/buildDir