# Setup AWS for Deep Learning

The steps were last run in July 2017.

## Create an AWS User

This step is only required if you do not already have an IAM user with programmatic access to AWS.

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

## Request Limit Increase

The default limit for creating `p2.xlarge` instance types is 0. To increase this limit:

**Pre-Requisite**:
* You have an AWS account.

**Steps**:
1. In the AWS console, go to the EC2 dashboard.
2. On the left hand menu, click on `Limits`.
3. Click on `Request limit increase` on any instance type; they all take you to the same place.
    * You will be taken to the `Create Case` section of the `Support Center`.
4. Complete the form as follows:
    * Regarding: `Service Limit Increase`
    * Limit type: `EC2 Instances`
    * Region: (your preferred region)
    * Primary Instance Type: `p2.xlarge`
    * Use Case Description: `fast.ai MOOC`
    * Contact method: `Web`
5. Click `Submit`. If you set your use case description as above, the authorisation reply should be immediate. The email you will receive may state that: "It can sometimes take up to 30 minutes for this to propagate and become available for use."
    
## Configure the AWS Command Line Interface

**Pre-Requisite**:
* You have a bash terminal.
* You have `awscli` installed.
* You have the credentials that were generated in the previous step.

Note: `awscli` is installed as part of the virtual environment created by [install.sh](../install.sh). If you have used that, just activate the virtual environment by:

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

## Create the Instance

**Pre-Requisites:**
* You have completed all the steps above.

**Steps**:
If you have used the `default` profile, you can simply follow the original instructions.
    * The latest scripts are stored in the [fast.ai Github repository](https://github.com/fastai/courses/tree/master/setup).
    
If you have used a non-`default` profile, then you'll need the scripts in this directory. Run:

```bash
$ ./setup_p2.sh <profile-name>
```

Where `<profile-name>` is the profile you created when configuring your AWS CLI. 

This will produce files like this:
* `<name>-connect.sh` to connect to your instance.
* `<name>-reboot.sh` to reboot your instance (untested).
* `<name>-start.sh` to start your instance and create/restore an EBS volume from a snapshot.
* `<name>-stop.sh` to stop your instance and detach/store your EBS volume as a snapshopt.
* `<name>-variables.sh` to export all of the variables created throughout the installation.
* `uninstall-<instance-type>.sh` to uninstall/remove everything.

By default:
* `<name>` is set to `fast-ai` for `p2.xlarge` instances, `test-machine` otherwise.
* `<istance-type>` is set to `p2.xlarge`
