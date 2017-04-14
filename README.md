## Cloud Endpoints Quickstart Scripts

These scripts help get you up and running with [Google Cloud Endpoints](https://cloud.google.com/endpoints/)
quickly and easily. They are designed to be used in conjunction with the
Cloud Endpoints [Quickstart Guide](#TBD).

The included API lets you query the name of an airport from its
three-letter IATA code.

*This is an example application, not an official Google product.*

## Before you begin

### Option 1: Use [Google Cloud Shell](https://cloud.google.com/shell/)

### Option 2: Test Locally in Linux or Mac OS X

*These scripts will not work in Windows. If you have a Windows machine, we
recommend you use Google Cloud Shell.*

1.  Download and install the [Google Cloud
    SDK](https://cloud.google.com/sdk/docs/), which includes the
    [gcloud](https://cloud.google.com/sdk/gcloud/) command-line tool.

1.  Create a [new Google Cloud Platform project from the Cloud
    Console](https://console.cloud.google.com/project) or use an existing one.

1.  Initialize the Cloud SDK.

        gcloud init

1.  Set your default project (replace YOUR-PROJECT-ID) with the name of your
    project).

        gcloud config set project YOUR-PROJECT-ID

## Basic Usage


    ./deploy_api.sh; : Deploy the API.
    ./deploy_app.sh; : Deploy the backend app.
    ./query_api.sh;  : Query the API.

*Note: these scripts will create an App Engine project and deploy an app!*

## Licensing

See [LICENSE](LICENSE).

## Special Thanks

Thanks to [David Megginson](http://ourairports.com/about.html#credits) for
providing the airport data!
