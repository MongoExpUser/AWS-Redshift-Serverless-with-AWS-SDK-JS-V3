[![CI - AWS-SDK-JS-V3 Deploy RSSL](https://github.com/MongoExpUser/AWS-Redshift-Serverless-with-AWS-SDK-JS-V3/actions/workflows/deploy-redshift-sless.yml/badge.svg)](https://github.com/MongoExpUser/AWS-Redshift-Serverless-with-AWS-SDK-JS-V3/actions/workflows/deploy-redshift-sless.yml)

# AWS-Redshift-Serverless-with-AWS-SDK-JS-V3

<strong> Deployment and Modeling of AWS Redshift Serverless (A cloud data warehouse).</strong>
<br><br>

  1) The NodeJS script (index.js) creates and deletes the following resources:                   
     * Redshift Serverless Namespace                                                                                                                 
     * Redshift Serverless Workgroup                                                                                                                 
     * Redshift Serverless Usage Limit  
     
  2) Additional SQL scripts in the repo for modeling include:                                                                                             
     * DDL script (ddl.sql) for data objects (TABLES) creation. Run via Redshift Query Editor 2                                                       
     * DML scripts (dml-v1.sql and dml-v2.sq ) for inserting data. Run via either:
       * Redshift Query Editor 2
       * NodeJS module - @aws-sdk/client-redshift-data (AWS-SDK-JS-V3) <br>
     * DQL script (dql.sql). Run via Redshift Query Editor 2                                                                   
  
<br>


## DEPLOYING AWS Redshift Serverless with the NodeJS script

## Option 1: Cloned to Local Computer

### To deploy the stack  on ```AWS```, follow these steps:

1) #### Install NodeJS and relevant NodeJS AWS-SDK V3 modules, assuming Ubuntu or Debian Linux OS
   * curl -fsSL https://deb.nodesource.com/setup_19.x | sudo -E bash - <br>
   * sudo apt-get install -y nodejs <br>
   * sudo npm install @aws-sdk/client-redshift-serverless
   * sudo npm install @aws-sdk/client-redshift-data
    
2) #### Download or clone the following files, from this repo, into the current working directory (CWD): <br>
   * NodeJS script:  index.js <br>
   * JSON files: credentials.json and inputConfig.json <br>
   

3) #### Fill in relevant values in the inputConfig.json file.<br>
   * <strong>References for inputConfig.json </strong>: 
     * https://docs.aws.amazon.com/AWSJavaScriptSDK/v3/latest/clients/client-redshift-serverless/classes/createnamespacecommand.html
     * https://docs.aws.amazon.com/AWSJavaScriptSDK/v3/latest/clients/client-redshift-serverless/classes/createworkgroupcommand.html
     * https://docs.aws.amazon.com/AWSJavaScriptSDK/v3/latest/clients/client-redshift-serverless/classes/createusagelimitcommand.html
     * https://docs.aws.amazon.com/AWSJavaScriptSDK/v3/latest/clients/client-redshift-serverless/classes/deleteworkgroupcommand.html

4) #### Then run the code, assuming sudo access: <br>
   * sudo node index.js <br><br>
   
 
## OPTION 2: Through GitHub Actions

### To deploy the stack  on ```AWS```, follow these steps:

1)  #### Check and fill relevant values in the GitHub Actions YML deployment file.
    * Link: https://github.com/MongoExpUser/AWS-Redshift-Serverless-with-AWS-SDK-JS-V3/blob/main/.github/workflows/deploy-redshift-sless.yml
  
2)  #### Also fill relevant values in the inputConfig.json file.
    * Ensure that the environment (dev, stag or prod) and region in the file (inputConfig.json) correspond to the values in the GitHub Actions YML file. <br>
    * Add the actual values the AWS IAM Role, AWS VPC Security Group id(s) and AWS VPC subnet ids to the GitHub Secrets instead of specifying them  in the config file (inputConfig.json) to avoid exposing their values.
    * See the <strong>env</strong> sections of the YML Deployment File: https://github.com/MongoExpUser/AWS-Redshift-Serverless-with-AWS-SDK-JS-V3/blob/main/.github/workflows/deploy-redshift-sless.yml
3)  #### Add the actual values for credentials to the GitHub Secrets.
    * These include: <strong> accessKeyId, secretAccessKey and region.</strong>
    * This prevents exposure of the credentials.

5)  #### Then enable GitHub Actions Workflow and run the YML file.
    * Link: https://github.com/MongoExpUser/AWS-Redshift-Serverless-with-AWS-SDK-JS-V3/actions <br><b>
  



# License

Copyright © 2023. MongoExpUser

Licensed under the MIT license.
