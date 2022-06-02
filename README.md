# Deploy a high-availability web app using CloudFormation
Your company is creating an Instagram clone called Udagram. Developers pushed the latest version of their code in a zip file located in a public S3 Bucket.
You have been tasked with deploying the application, along with the necessary supporting software into its matching infrastructure.
This needs to be done in an automated fashion so that the infrastructure can be discarded as soon as the testing team finishes their tests and gathers their results.
### Diagram
![Diagram](/UdagramInfraDiagrams.png)
### Content
1. The `app` folder has the website file (`udagram.zip`) to deploy.
2. The `bash` folder has the code files using to help such as utilities:
    * `create-ssh-key.sh` can be used to create a key pair (using `ssh-keygen`) and save to AWS Parameter Store.
	* `create.sh` can be used to create an AWS CloudFormation stack in region `us-east-1`
	* `update.sh` can be used to update an existing AWS Cloudformation stack in region `us-east-1`
	* `delete.sh` can be used to delete an AWS CloudFormation stack
	* Note: These scripts are specific to a region. You can change them in the script directly or adapt the script to accept a custom region.
3. The `screenshots` folder has screenshots for every steps are taken.
4. The `scripts` folder has CloudFormation scripts:
    * `iam.yml` uses `iam-parameters.json` to deploy a stack with the role that will use to upload/download files from the bucket and get parameters from AWS Parameter Store.
    * `s3.yml` uses `s3-parameters.json` to deploy a stack with the `AWS::S3` bucket that stores the website files, that is, `udagram.zip`
    * `network.yml` uses `network-parameters.json` to deploy a stack with the whole network to the will using in the project (`VPC`, `NAT Gateway`, ...).
    * `bastion.yml` uses `bastion-parameters.json` to deploy a stack with a bastion host to connect the hosts with the website of a secure way.
    * `server.yml` uses `server-parameters.json` to deploy a stack with the website hosts. Also deploy these hosts using `LoadBalancer`, `AutoScaling`, and `ClouWatch` alarms.
### Instructions
To deploy this project follow the instructions are below:
1. You need to create key pair that will use to connect to Bastion Host, in a terminal using the file `bash/create-ssh-key.sh`
    > `bash/create-ssh-key.sh`
2. You need to create the s3 and iam stacks, in a terminal using the file `bash/create.sh` 
    > `bash/create.sh iam-stack scripts/iam.yml scripts/iam-parameters.json`
    > `bash/create.sh s3-stack scripts/s3.yml scripts/s3-parameters.json`
4. You need to upload the website file `app/udagram.zip` to s3 bucket (created previously eg. `s3-658942388635-bucket`), in a terminal using aws cli
    > `aws s3 cp app/udagram.zip s3://s3-658942388635-bucket`
5. You need to create the other stacks described above, in a terminal
    > `bash/create.sh network-stack scripts/network.yml scripts/network-parameters.json`
    > `bash/create.sh bastion-stack scripts/bastion.yml scripts/bastion-parameters.json`
    > `bash/create.sh server-stack scripts/server.yml scripts/server-parameters.json`

You can access to the final website using this LoadBalancer [link](#)