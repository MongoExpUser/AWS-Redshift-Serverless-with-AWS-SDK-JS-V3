# AWS-Redshift-Serverless-with-AWS-SDK-JS-V3

<strong> Deployment and Modeling of AWS Redshift Serverless.</strong>
<br><br>

  1) The NodeJS script (index.js) can execute the followings: creates, updates and deletes the following resources:                   
     * Redshift Serverless Namespace                                                                                                                 
     * Redshift Serverless Workgroup                                                                                                                 
     * Redshift Serverless Usage Limit  
     
  2) Additional SQL Scripts in the repo for modeling:                                                                                                
     * DDL script (ddl.sql) for data objects (TABLES) creation. Run via Redshift Query Editor 2                                                       
     * DMLsScript (dml.sql) for inserting data. Run via either:
       * Redshift Query Editor 2
       * Node.js module - @aws-sdk/client-redshift-data (AWS-SDK-JS-V3) <br>
     * DQL script (dql.sql). Run via Redshift Query Editor 2                                                                   
  
<br>


## DEPLOYING AWS Redshift Serverless with the NodeJS script

## Cloned to Local Computer

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
   * <strong>References for inputConfig.json </strong>: https://docs.aws.amazon.com/AWSJavaScriptSDK/v3/latest/clients/client-redshift-serverless/

4) #### Then run the code, assuming sudo access: <br>
   * sudo node index.js <br><br>


# License

Copyright © 2015 - present. MongoExpUser

Licensed under the MIT license.
