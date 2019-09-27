# terraform-eks-wordpress
## What does it do? 

It builds an autoscaling EKS based kubernetes cluster serving wordpress.

Maintained by Paul Lupu

# How to create
## 1) Getting wordpress set up
1) Download heptio-authenticator-aws and aws-iam-authenticator and move them to $PATH

2) Create kubernetes cluster
$ eksctl create cluster -f cluster.yaml 

3) Create an RDS instance IN THE SAME VPC as the EKS cluster; set public=no, and leave the
  security group open to everyone

4) Update deploy/mysql.yaml with the endpoint of the RDS instance / user / pass 
   and apply to create the configmap necessary for the wordpress instalation

5) Apply the wordpress-deploy.yaml file to create the deployment

6) Apply wordpress-service.yaml file to create the service

7) Go to the public endpoint and finish up the installation with Site Name, Admin Name, Password etc

## 2) Setting up autoscaling
### Based on the following tutorial: https://eksworkshop.com/scaling/
1) Add metrics server to your cluster https://github.com/kubernetes-incubator/metrics-server

2) Configure aws role to have the cluster-autoscaler-iam-policy.json policy

4) Configure cluster_autoscaler.yaml as detailed in tutorial

3) Run $kubectl autoscale deployment  wordpress-dev --min=1 --max=10 --cpu-percent=50 to create 
   the hpa

4) After inserting the name of the autoscaling group into cluster_autoscaler.yaml, apply it to 
   create the autoscaler service; then run $ kubectl get hpa -w 

5) In another terminal, open a shell to one of the wordpress containers
   $   exec -it _pod_name_here    -- /bin/bash
   and run a bunch of $ dd if=/dev/zero of=/dev/null & commands

6) Watch the hpa terminal start to increase in CPU

7) Go to the autoscaling group. You will see it has started to scale up. 



