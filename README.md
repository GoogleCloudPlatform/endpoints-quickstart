## Cloud Endpoints Quickstart Scripts

These scripts help you get started with [Google Cloud Endpoints](https://cloud.google.com/endpoints/)
quickly and easily. They are designed for use with the
[Endpoints
Quickstart Guide](https://cloud.google.com/endpoints/docs/quickstart-endpoints).

The included API lets you query the name of an airport from its
three-letter IATA code.

*This is an example application, not an official Google product.*

## Before you begin

1. Create a new
[Cloud Platform project](https://console.cloud.google.com/projectcreate).

1. [Enable billing](https://support.google.com/cloud/answer/6293499#enable-billing)
   for your project.

## Running the scripts

### Option 1: Use Google Cloud Shell

1. Open the [Google Cloud Platform
   Console](https://console.cloud.google.com/?_ga=1.38191587.1500870598.1489443487).

1. Click the Cloud Shell icon at the top of the screen.
![Cloud Shell](https://cloud.google.com/shell/docs/images/shell_icon.png)

### Option 2: Test Locally in Linux or Mac OS X

*These scripts will not work in Windows. If you have a Windows machine, we
recommend you use Google Cloud Shell.*

1.  Download and install the [Google Cloud
    SDK](https://cloud.google.com/sdk/docs/), which includes the
    [gcloud](https://cloud.google.com/sdk/gcloud/) command-line tool.

1.  Initialize the Cloud SDK.

        gcloud init

1.  Set your default project (replace YOUR-PROJECT-ID with the name of your
    project).

        gcloud config set project YOUR-PROJECT-ID

## Usage

    cd scripts
    ./deploy_api.sh; : Deploy the API.
    ./deploy_app.sh; : Deploy the backend app.
    ./query_api.sh; : Query the API.
    ./generate_traffic.sh; : Send traffic to the API.
    ./generate_traffic.sh ASDF; : Send error traffic to the API.
    # And after you're done...
    ./delete_project.sh; : Delete your project.

*Note: these scripts will create an App Engine project and deploy an app!*

## Licensing

See [LICENSE](LICENSE).

## Special Thanks

Thanks to [David Megginson](http://ourairports.com/about.html#credits) for
providing the airport data!
