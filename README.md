# PLUTO Demonstration Code
Project Logistics, UTilization and Operations (PLUTO)
 
## Clone in the Repo
Open Cloud Shell\
Clone in the `https://github.com/ROIGCP/PLUTO` repo\
    Command: `git clone https://github.com/ROIGCP/PLUTO`\
    Command: `cd PLUTO`

## PLUTO dependancies
Make sure you have a project set\
    Command: `gcloud config set project YOURPROJECTNAME`

Bucket named projectid-bucket\
    Command: `gsutil mb gs://$GOOGLE_CLOUD_PROJECT"-bucket"`
    
BigQuery Dataset called "activities"\
    Command: `bq mk activities`

BigQuery Table called "resources" - starting schema\
    Command: `bq mk --schema messages:STRING -t activities.resources`

PubSub Topic called "activities"\
    Command: `gcloud pubsub topics create activities`

PubSub Subscription called "activites-catchall"\
    Command : `gcloud pubsub subscriptions create activites-catchall --topic projects/PROJECTID/topics/activities`

Create a Cloud Function\
    Python \
    Trigger by topic activities \
    Use the sample in CloudFunction folder

## Google Asset Managment examples

Enabling the APIs\
    Command: `gcloud services enable cloudasset.googleapis.com`\
    Command: `gcloud services enable cloudresourcemanager.googleapis.com`\
    Command: `gcloud sercies list`

Asset Export to BigQuery Example\
    Command: `gcloud asset export --project PROJECTID --bigquery-table export --bigquery-dataset activities`

Asset Feed Creation\
    Command: `gcloud asset feeds create activities --project=PROJECTID 
	--content-type=resource --asset-types="compute.googleapis.com.*" 
	--pubsub-topic=projects/PROJECTID/topics/activities`





