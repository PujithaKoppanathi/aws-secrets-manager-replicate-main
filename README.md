# aws-secrets-manager-replicate
Replicate AWS Secrets on a host containing an AWS credentials file with all the required target profiles

#### Intended Audience
* Devops

#### Pre-requisites
* Jenkins host which contains an attached EC2 profile, with permissions across all target accounts via a trusted role
* An ./aws/credentials file containing all account profiles to allow script 'profile' call via AWS CLI to each target account, respectively
* A callable JSON file containing a list of all target accounts
* Secrets pre-populated in each target account's us-east-1 region

#### ./aws/credentials sample file
The sample below assumes each 'role_arn' is a role with trusted permissions to the Jenkins EC2 profile. Notice the 'credential_source' value, 'Ec2InstanceMetadata', indicating the EC2s attached profile will be used for authenticating to the target accounts.

**Example**
```
[profile accountA]
role_arn = arn:aws:iam::012345678910:role/target-role
credential_source = Ec2InstanceMetadata

[profile accountB]
role_arn = arn:aws:iam::012345678911:role/target-role
credential_source = Ec2InstanceMetadata

[profile accountC]
role_arn = arn:aws:iam::012345678912:role/target-role
credential_source = Ec2InstanceMetadata
```

### Callable JSON Account List
The sample below contains a list of target accounts in which the secrets should be replicated.

**Example**
```
   {
   "team.accountA": "012345678910",
   "team.accountB": "012345678911",
   "team.accountC": "012345678912",
  }
```

#### Usage
* Update the script's 'testarray' var to curl the location of the callable JSON.
* Execute the script on the Jenkins host containing the ./aws/credentials file with containing the target accounts

#### Example
* ./aws-replicate-secrets.sh
