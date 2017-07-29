# Setup AWS for Deep Learning

## Create an AWS User

Last run: July 2017.

**Pre-Requisite**:
* You have an AWS account.

**Steps**:
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
    
## Configure the AWS Command Line Interface

**Pre-Requisite**:
* You have a bash terminal.
* You have `awscli` installed.
* You have the credentials that were generated in the previous step.

Note: `awscli` is installed as part of the virtual environment created by [install.sh](install.sh). If you have used that, just activate the virtual environment by:

```bash
$ cd /path/to/this/project/
$ source .venv/bin/activate
```

**Steps**:
1. Type `$ aws configure --profile fastai`.
    * It's useful to use a `--profile` if you need to have more than one set of AWS credentials on the same machine.
    * The [original instructions](http://wiki.fast.ai/index.php/AWS_install) configure aws to use a `default` profile.
    * Leaving out the `--profile fastai` will set you up to use the `default` profile.
2. Input the requested information:

```bash
AWS Access Key ID [None]: <Access key ID>        
AWS Secret Access Key [None]: <Secret access key>
Default region name [None]: <Your region, e.g. eu-west-1>
Default output format [None]: text
``` 

This will store the credentials in `~/.aws/credentials`.

## Create Instances

**Pre-Requisites:**
* You have the fast.ai scripts. The latest ones are stored in the [fast.ai Github repository](https://github.com/fastai/courses/tree/master/setup).

**Steps**:
