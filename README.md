# nextcloud_aws
Learning by doing.
In my journey to learn AWS and automation 
 How to deploy nextcloud in AWS using terraform.
 

Deployment of Nextcloud with terraform in AWS 
In this project I am going to deploy a nextcloud application in AWS using Terraform to provision our infrastructure.

1. Creating our terraform architecture and code

Our Vpc.tf: has two public and two private subnets and is name nextcloud
securitygroup.tf : allows port 443 and 22 for htpps and ssh
s3.tf : we are going to create a a bucket that will store nextcloud files

ec2-profile allows read and write permissions on our s3 bucket
iam-ec2.tf: creates ec2-instance read and write role and permission 
instance.tf : name of our instance is nextcloud 
                 - deploy instance in nextcloud-public subnet 1
                 - using our instance key nextkey
                 - allocating 20 gb
                - allocating read and write permission to instance to write on s3 bucket
key.tf : key file that we will use to access  our instance
variable.tf 
eip.tf : option to use and allocate a reserved IP address (feel free to uncomment)
           You will need to uncomment the output.tf file if you want to use the public ip allocated by AWS.
alarms.tf we are going to create a cloudwatch monitoring and send notification to an email.


Creating our ssh-key
  ssh-keygen -f keygen
  terraform init
  terraform apply → yes

you should see return ip address, bucket name and security role

2. Accessing and installing nextcloud
   
   ssh -i  nextkey ubuntu@3.14.75.60 to login into our instance

  - sudo apt update
  - sudo apt install awscli -y
  - verify read and write connection to our bucket instance
    → aws s3 ls 
    
Installing nextcloud manually using snap
      sudo snap install nextcloud
      snap changes nextcloud
      sudo nextcloud.manual-install test password
      sudo nextcloud.occ config:system:set trusted_domains 1 –value=awsDNS.com
      sudo nextcloud.enable-https self-signed


Login to nextcloud using the credentials that was set earlier, test password

Nextcloud allows us to choose an external storage 
   → apps → enable external storage support
   
 Under settings → external storage → add storage and select s3 
 type in the s3 bucket that we created earlier and provide your access and secret key .
 This is the nextcloud-user role that we created 
 You should see a Amazons3folder.
 Go into the folder and upload a file or create one.
 In your bucket verify that the file is created in the bucket.
 Also check that bucket versioning and object level-logging are configured .
  
Now lets make sure that our cloudwatch alarm and notification are set correctly
 console → cloudwatch → ok you can see the alarm status is waiting for your confirmation
 logging to you email and confirm 
Lets check if the notification work.
Cloudwatch will send you an alert if the cpu uses more than 80 percent 
 simulate this in our instance 
    – apt-install stress
    - stress –cpu 1
       
 Our instance is configured correctly, logout from our instance and do a terraform destroy to completely delete our infrastructure. You will need to remove the termination protection of the instance and removing the s3 file if you wish to do so.

In part 2 I will deploy nextcloud using docker

 
