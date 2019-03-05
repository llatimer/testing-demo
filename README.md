# Testing Demo

This demo illustrates the creation of some simple code that does a rollup count of the number of Contacts to the Account. This example is contrived as an admin could accomplish the same functionality using a rollup field. There are three examples with in the Contact class and the testing class demonstrating:

    1. the way we all learned in examples provided
    2. modularizes the code isolating the methods for testing
    3. removes the binding to the database using mock and injection

## Set Up the Salesforce DX Project

Our first goal is to set up a developer project which we'll use to modify our application. It starts by cloning the repository. Use the command ...

    git clone https://github.com/llatimer/testing-demo.git

… or ...

    git clone git@github.com:llatimer/testing-demo.git

… to clone the repository. Then, open the directory.

    cd testing-demo

## Steps

Authorize to your Developer Hub (Dev Hub) org.
 
    sfdx force:auth:web:login -d -a "Hub Org"
 
If you already have an authorized Dev Hub, set it as the default:
 
    sfdx force:config:set defaultdevhubusername=<username|alias>
 
Create a scratch org and provide it with an alias (testing-demo in the command below):

    sfdx force:org:create -s -f config/project-scratch-def.json -a testing-demo

Push your source.

    sfdx force:source:push

Load sample data:

    sfdx force:data:tree:import --plan ./data/data-plan.json

Run your tests.

    sfdx force:apex:test:run
    sfdx force:apex:test:report -i <id>

Open the scratch org.

    sfdx force:org:open --path one/one.app

## Resources


## Description of Files and Directories  

* **sfdx-project.json**: Required by Salesforce DX. Configures your project.  Use this file to specify the parameters that affect your Salesforce development project.
* **config/project-scratch-def.json**: Sample file that shows how to define the shape of a scratch org.  You reference this file when you create your scratch org with the force:org:create command.   
* **force-app**: Directory that contains the source for the sample Force.com app and tests.   
* **.project**:  Required by the Eclipse IDE.  Describes the Eclipse project. 
* **.gitignore**:  Optional Git file. Specifies intentionally untracked files that you want Git (or in this case GitHub) to ignore.

## Issues

