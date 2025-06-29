# dbtsnowflake
Example project to show case dbt on snowflake


Create a virtual environment  
`uv venv`  

Activate the virtual environment
`source .venv/bin/activate`  

Install the dependencies for dbt and snowflake adapter
List of other adapters are found [here](https://github.com/dbt-labs/dbt-adapters)   
`uv pip install dbt-core dbt-snowflake`


Initialize the DBT within the virtual environment by passing the dbt_project.yml file
If you don't then dbt will create another project with the same folder name


dbt init

give the same folder name as the route

for the account give snowflake account
for the user create a dev user and provide this user name

Desired Authentication Option
[1] password
[2] keypair
[3] sso

role (dev role): accountadmin
warehouse: compute_wh

database that dbt will build objects in:
default schema that dbt will build object in: staging
threads : 1

The tool is dumb and would not understand that the folder name is the same as the parent folder name.
It would create another folder with the same name
Move all the contents to the parent folder and delete the folder name.  

The tool was designed to be run first before the virtual environment concept came in.
Since we install dbt in the virtual environment without the project folder.
This issue exists

Test the snowflake connection  
`dbt debug`

This should print out the following  
<code>
02:01:46  Registered adapter: snowflake=1.9.4
02:01:48    Connection test: [OK connection ok]

02:01:48  All checks passed!  
</code>


Setup the raw tables and data using the 
`setup/create_raw_data.sql`  

Setup the raw tables and data using 
`setup/create_prod_raw_data.sql`  

Go to the models
There would be staging, intermediate and data marts  

raw - staging  
staging - intermediate  
intermediate to data marts  

For this demo only     
raw - staging  
staging - data mart  
 
would be used

The staging folder has __sources
this should have the source raw tables  
along with the schema  

creating transformations  
each file should be names
source_table__target_table
with the __ separating source and target


Building the dbt project  
`dbt compile`

This creates a target folder  
which should have the compile sql that substitutes the jinja syntax
to actual sql files


executing the dbt project
`dbt run --select staging `  

