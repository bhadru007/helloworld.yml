#!/usr/bin/python

import boto3
import os
import argparse

parser = argparse.ArgumentParser(description='List all resources.', add_help=True)
parser.add_argument('--region', help='Region in which to deploy.', required=True)
parser.add_argument('--appName', help='Application to deploy.', required=True)
parser.add_argument('--groupName', help='Deployment Group Name to deploy.', required=True)

args = parser.parse_args()

client = boto3.client('codedeploy', region_name=args.region)

config = {applicationName=args.appName,deploymentGroupName=args.groupName,
    revision={revisionType: 'GitHub', gitHubLocation: {repository: 'https://github.com/warpedcodemonkey/helloworld.git'}},ignoreApplicationStopFailures=False}

deploymentResponse = client.create_deployment(config)

print(deploymentResponse)