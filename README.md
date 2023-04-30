# AWS-Redshift-Serverless-with-AWS-SDK-JS-V3

<strong> Deployment and Modeling of AWS Redshift Serverless (A cloud data warehouse).</strong>
<br><br>

  1) The NodeJS script (index.js) can execute the followings: creates and deletes the following resources:                   
     * Redshift Serverless Namespace                                                                                                                 
     * Redshift Serverless Workgroup                                                                                                                 
     * Redshift Serverless Usage Limit  
     
  2) Additional SQL scripts in the repo for modeling include:                                                                                             
     * DDL script (ddl.sql) for data objects (TABLES) creation. Run via Redshift Query Editor 2                                                       
     * DML script (dml.sql) for inserting data. Run via either:
       * Redshift Query Editor 2
       * Node.js module - @aws-sdk/client-redshift-data (AWS-SDK-JS-V3) <br>
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
   

3) #### Fill in relevant values in inputConfig.json file.<br>
   * <strong>References for inputConfig.json </strong>: 
     * https://docs.aws.amazon.com/AWSJavaScriptSDK/v3/latest/clients/client-redshift-serverless/classes/createnamespacecommand.html
     * https://docs.aws.amazon.com/AWSJavaScriptSDK/v3/latest/clients/client-redshift-serverless/classes/createworkgroupcommand.html
     * https://docs.aws.amazon.com/AWSJavaScriptSDK/v3/latest/clients/client-redshift-serverless/classes/createusagelimitcommand.html
     * https://docs.aws.amazon.com/AWSJavaScriptSDK/v3/latest/clients/client-redshift-serverless/classes/deleteworkgroupcommand.html

4) #### Then run the code, assuming sudo access: <br>
   * sudo node index.js <br><br>
   
 
## OPTION 2: Through GitHub Actions

### To deploy the stack  on ```AWS```, customize the example in the following repository:

1) #### Sample GitHub Deployment
   * Repo Link: https://github.com/MongoExpUser/AWS-CloudFormation-Stack-with-AWS-SDK-JS-V3
   * Repo CI Link: [![CI - AWS-SDK-JS-V3 Deploy CFN](https://github.com/MongoExpUser/AWS-CloudFormation-Stack-with-AWS-SDK-JS-V3/actions/workflows/deploy-cfn.yml/badge.svg)](https://github.com/MongoExpUser/AWS-CloudFormation-Stack-with-AWS-SDK-JS-V3/actions/workflows/deploy-cfn.yml)
  


# License

Copyright © 2015 - present. MongoExpUser

Licensed under the MIT license.
