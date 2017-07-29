# Setup AWS for Deep Learning

## Pre-Requisites

* You have an AWS account.
* You have `awscli` installed (this is installed as part of the [install.sh](install.sh) virtual environment).
* You have the `fast.ai` scripts. The latest ones are stored in the [fast.ai Github repository](https://github.com/fastai/courses/tree/master/setup).

## Steps

### Create an AWS User

1. In the AWS console, go to the IAM section (Identity and Access Management).
2. On the left hand menu, click on `Users`.
3. Click the `Add User` button.
4. Add a user name (e.g., `fastai`), and enable `Programmatic access`.
5. Set the permissions for this user, and click next.
    * If you don't have any permission groups, create one.
    * The simplest thing you can do is create a group that has full administrator access.
    * If you are using an account with multiple users, it is not advisable to create a group with full admin access.
6. Review the settings, and click `Create user`.
7. After the user has been created, you can see the access key and secret. Keep a note of both of these.
    * There is also an option to download these values as a `credentials.csv` file.
    
