# Apex_Basic_Dev_Session

Hi!
This repository contains project which we will use in two Apex Basic Dev sessions. Please complete the setup steps before our first session. If you have any question, please contact me on tomas.chour@bearingpoint.com or t.chourj@gmail.com.
And don't forget to bring good mood :) .

# Project overview

World Wildlife organization (WWF) offers it’s customers to virtually adopt different animals from across the planet. Adoption is in form of monthly subscription payments from customers that wants to donate. WWF uses these funds to help these “adopted” animals to strive and survive in modern world.

WWF uses Salesforce to manage information about their donors and their adoption subscriptions.

They want to provide some motivation to attract new donors and keep existing ones. This project will go through implementing several User Stories to help WWF achieve their goal.


# Steps to complete before session

- Create new **empty** developer org (or scratch org if you want).
- Create new **sfdx** project in VS code and add this repo as remote (https://github.com/Calgren/Apex_Basic_Dev_Session.git)
- Pull the source from remote **main** branch
- Connect your dev org to the project
- Deploy metadata into your org (all metadata for deploy are contained in **manifest/package.xml**)
- Import Animals and Account records from **data/Account.csv** and **data/Animals.csv** (you can use data import wizard from SF setup)
- Run Anonymous Apex from **scripts/apex/anonApex** to create randomized AdoptionRecords (run apex from developer console)