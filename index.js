/*
#  *****************************************************************************************************************************************************
#  *                                                                                                                                                   *
#  * @License Starts                                                                                                                                   *
#  *                                                                                                                                                   *
#  * Copyright © 2015 - present. MongoExpUser.  All Rights Reserved.                                                                                   *
#  *                                                                                                                                                   *
#  * License: MIT - https://github.com/MongoExpUser/AWS-Redshift-Serverless-with-AWS-SDK-JS-V3/blob/main/LICENSE                                       *
#  *                                                                                                                                                   *
#  * @License Ends                                                                                                                                     *
#  *****************************************************************************************************************************************************
#  *                                                                                                                                                   *
#  *  index.js implements a module/script for creating and deleting Redshift Serverless with with AWS SDK for JavaScript/NodeJS V3.                    *
#  *                                                                                                                                                   *
#  *  A) The following resources are created/deployed with @aws-sdk/client-redshift-serverless (AWS-SDK-JS-V3):                                        *
#  *    1) Redshift Serverless Namespace                                                                                                               *
#  *    2) Redshift Serverless Workgroup                                                                                                               *
#  *    3) Redshift Serverless Usage Limit                                                                                                             *
#  *                                                                                                                                                   *
#  *  B) Additional scripts for modeling:                                                                                                              *
#  *    1) DDL script for data objects (Tables) creation: Run via Redshift Query Editor 2                                                              *
#  *    2) DML scripts for inserting data: Run via Redshift Query Editor 2 or NodeJS module - @aws-sdk/client-redshift-data (AWS-SDK-JS-V3)            *
#  *    3) DQL script for running queries: : Run via Redshift Query Editor 2                                                                           *
#  *****************************************************************************************************************************************************
*/


class RedshiftStack
{
    constructor()
    {
      return null;
    }

    async prettyPrint(value)
    {
        const util = require('util');
        console.log(util.inspect(value, { showHidden: true, colors: true, depth: 4 }));
    }

    async uuid4()
    {
        let timeNow = new Date().getTime();
        let uuidValue =  'xxxxxxxx-xxxx-7xxx-kxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(constant)
        {
            let random = (timeNow  + Math.random() *16 ) % 16 | 0;
            timeNow  = Math.floor(timeNow / 16);
            return (constant === 'x' ? random : (random & 0x3| 0x8)).toString(16);
        });
        
        return uuidValue;
    }

    async sendCommand(client, command, commandName)
    {
        const rst = new RedshiftStack();
        let data;
        
        try
        {
            data = await client.send(command);
            rst.prettyPrint({ "data" : data } );
        }
        catch(error)
        {
            return console.log(error);
        }
        
        await rst.separator();
        console.log(`Successful ${commandName} Command`);
        await rst.separator();
        console.log(`Time is:`, new Date(), `.....`);
        await rst.separator();

        return data;
    }
    
    async createDelete(paramsObject=null)
    {
        const rst = new RedshiftStack();
        let options =  paramsObject.options;
        const createNamespaceParams = paramsObject.createParameters;
        const createWorkgroupParams = paramsObject.createWorkgroupParameters;
        const createUsageLimitParams = paramsObject.createUsageLimitParameters;
        const deleteNamespaceParams = paramsObject.deleteParameters;
        const deleteWorkgroupParams = paramsObject.deleteWorkgroupParameters;
        const { RedshiftServerlessClient, CreateWorkgroupCommand, 
                CreateNamespaceCommand, CreateUsageLimitCommand, 
                DeleteWorkgroupCommand } = require("@aws-sdk/client-redshift-serverless");
        const  redshiftServerlessClient = new RedshiftServerlessClient(options);

        let commandName;
        let command;
        let createdWorkgroup;

        if(paramsObject.createResources === true)
        {
            //namespace
            commandName = "CreateNamespace";
            command = new CreateNamespaceCommand(createNamespaceParams);
            await rst.sendCommand(redshiftServerlessClient, command, commandName);

            // work group
            commandName = "CreateWorkgroupCommand";
            command = new CreateWorkgroupCommand(createWorkgroupParams);
            createdWorkgroup = await rst.sendCommand(redshiftServerlessClient, command, commandName);
            
            // usage limit
            let createdNameSpaceArn = createdWorkgroup.workgroup.workgroupArn;
            commandName = "CreateUsageLimit";
            createUsageLimitParams.resourceArn = createdNameSpaceArn; // update resourceArn variable
            command = new CreateUsageLimitCommand(createUsageLimitParams);
            await rst.sendCommand(redshiftServerlessClient, command, commandName);

        }
        else if(paramsObject.deleteResources === true)
        {
            commandName = "DeleteWorkgroup";
            command =  new DeleteWorkgroupCommand(deleteWorkgroupParams); 
            await rst.sendCommand(redshiftServerlessClient, command, commandName);
        }
    }
    
    async separator()
    {
      console.log(`---------------------------------------------------------------------------------`);
    }
}


async function main()
{
    // require/import and instantiate relevant modules
    const fs = require('fs');
    const rst = new RedshiftStack();
    const inputConfigJsonFilePath = "inputConfig.json";
    const inputConfig = JSON.parse(fs.readFileSync(inputConfigJsonFilePath));
    const userDataFilePath = String(inputConfig.userData);
    const credentialJsonFilePath = inputConfig.credentials;
    let credentials =  (JSON.parse(fs.readFileSync(credentialJsonFilePath))).credentials;
    let options = { credentials: { accessKeyId : credentials.accessKeyId, secretAccessKey: credentials.secretAccessKey }, region: credentials.region };

    // define common naming, tagging and environmental variables
    const addSuffix = inputConfig.addSuffix;
    const uuid4Value = await rst.uuid4();
    const suffix = String(uuid4Value).substring(0, 4);
    const orgName = inputConfig.orgName;
    const projectName = inputConfig.projectName;
    const environment  = inputConfig.environment;
    const regionName = inputConfig.regionName;
    const preOrPostFix = `${orgName}-${environment}`;
    const resoureName = inputConfig.resoureName;
    const serviceProvider = inputConfig.serviceProvider;
    const creator = inputConfig.creator;
    const creditTagOne = inputConfig.creditTagOne;
    const creditTagTwo = inputConfig.creditTagTwo;
    const tags = [
      { key: "region", value: regionName },
      { key: "environment", value: environment },
      { key: "project", value: projectName },
      { key: "creator", value: creator },
      { key: "provider", value: serviceProvider }
    ];
    let namespaceName;
    
    
    //add naming tags with uuid-generared substring suffix for uniqueness
    if(addSuffix === true)
    {
        let value = `${preOrPostFix}-${resoureName}-${suffix}`;
        tags.push( { key: "Name", value: value } );
        tags.push( { key: "name", value: value } );
        namespaceName = value;
    }
    else if(addSuffix === false)
    {
        let value = `${preOrPostFix}-${resoureName}`;
        tags.push( { key: "Name", value: value } );
        tags.push( { key: "name", value: value } );
        namespaceName = value;
    }
    
    
    //define parameters
    const paramsObject = {
        credentials : credentials,
        options : options,
        createParameters : inputConfig.createParameters,
        createWorkgroupParameters : inputConfig.createWorkgroupParameters,
        deleteWorkgroupParameters : inputConfig.deleteWorkgroupParameters,
        createUsageLimitParameters : inputConfig.createUsageLimitParameters,
        createResources : inputConfig.createResources,
        deleteResources : inputConfig.deleteResources
    }
    
    try
    {
        //add "namespaceName"  and "tags" to the "createParameters" variable on the "paramsObject" object.
        paramsObject.createParameters.namespaceName = namespaceName;
        paramsObject.createParameters.tags = tags;

        //add "namespaceName", "workgroupName"  and "tags" to the "createWorkgroupParameters" variable on the "paramsObject" object.
        paramsObject.createWorkgroupParameters.namespaceName = namespaceName;
        paramsObject.createWorkgroupParameters.workgroupName = `${namespaceName}-wgp`;
        paramsObject.createWorkgroupParameters.tags = tags; 

        //finally, create or delete resources
        await rst.createDelete(paramsObject);
    }
    catch (error)
    {
        return console.log("Error", error);
    }
    
}


main();

module.exports = { RedshiftStack };
