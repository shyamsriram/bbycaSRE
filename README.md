READ ME:

This documentation Covers the Solution Details for the Code Assignment found on https://github.com/omartinezpou/bbycaSRE:

The Application is hosted on Amazon EC2 instance with the hostname: ec2-35-164-59-206.us-west-2.compute.amazonaws.com.
The Deployment Pipeline is Implemented Using Amazon Code Pipe Line Cloud Service Component and Amazon Code Deploy Cloud Service Component.

LOGIN:

To Login to the remote the Server where the Code is Deployed (Amazon EC2 Server) use the included pem file (sent seperately) and type the command on your console:

ssh -i <Path to pem key file> ec2-user@ec2-35-164-59-206.us-west-2.compute.amazonaws.com

For Eg: ssh -i 'C:\Local Folder\MyAmazonKey.pem' ec2-user@ec2-35-164-59-206.us-west-2.compute.amazonaws.com

Note: The key pem file is sent to you seperately and will be needed to authenticate login and allow access to the EC2 Linux Server.

WEBSITE DETAILS:

To Test if the Node Js Application is running on your browser type the following Url addresses on your browser:

1) Development URL: http://ec2-35-164-59-206.us-west-2.compute.amazonaws.com:8001/
2) Test URL: http://ec2-35-164-59-206.us-west-2.compute.amazonaws.com:8002/
3) Disaster Recovery URL: http://ec2-35-164-59-206.us-west-2.compute.amazonaws.com:8003/
4) Production URL: http://ec2-35-164-59-206.us-west-2.compute.amazonaws.com:8004/

AUTOMATIC DEPLOYMENT:

To Trigger an Automatic Deployment:

Check in your code updates to the Code Repository on Git Hub at the following URL:

https://github.com/shyamsriram/bbycaSRE

Checking in any code changes to the above Git Hub repo will Trigger an automatic code build on the pipeline.

Code will be downloded from the Git Hub Repo and Deployed by Amazon Code Pipeline to the EC2 Server in the following workflow order:

Source Trigger -> Deploy to Development -> Deploy to Test -> Deploy to Disaster Recovery -> Deploy to Production -> Deploy to All Environments (If Enabled)

DEPLOYMENT PIPELINE:

To observe the pipeline progress in real time as it deploys the code, login to the AWS Console using Credentials for AWS (Provided Seperately in email) and navigate to DeveloperTools -> CodePipeline -> Pipeline-> GitHub2AWSPipeLine or use the following URL:

https://us-west-2.console.aws.amazon.com/codesuite/codepipeline/pipelines/GitHub2AWSPipeLine/view?region=us-west-2

The code deployment is first staged by AWS Code Deploy at /var/bbycasre/staging/ and then deployed to the following File Locations on the EC2 Server:

1) Development: /opt/bbycaSRE/DEV/bbycaSREApp/ (ENV: DEV, PORT: 8001)
2) Test: /opt/bbycaSRE/TEST/bbycaSREApp/ (ENV: TEST, PORT: 8002)
3) Disaster: /opt/bbycaSRE/TEST/bbycaSREApp/ (ENV: DR, PORT: 8003)
4) Production: /opt/bbycaSRE/TEST/bbycaSREApp/ (ENV: PROD, PORT: 8004)

CHALLENGES:

Challenges faced while Designing the Deployment Pipeline:

1) Amazon Documentation is Vague about how Environment Variables Map to the Code Deployment Group. I was able to infer this by Setting the Deployment Group Value on AWS Code Deploy and then Log the variable value details in the shell scripts during Deployment Execution.
2) The code deploy agent needed to Deploy code automatically works well with only Amazon Linux Instances. I figured this out through trial and error and reading up online forums.
3) The Code Deployment Group needs correct Security Policy to allow creation of new Deployment groups like Test, Prod, Disaster recovery, etc. I fixed this by applying correct policy on Trust Relationships under the IAM Roles defined on AWS Console.
4) The deploy agent doesnt execute under the same environment as command line. This can cause the server to fail to start up automatically after successful deployment. I resolved this by sourcing bashrc in the StartServer.sh script.
