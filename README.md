# aws-org

IAC and automation to manage my AWS ORG

## NUKE

Some of the accounts are subject to periodic Nuking via [aws-nuke](https://github.com/ekristen/aws-nuke).
This is handled via a GitHub Action that runs on a schedule.

### Access Configuration
For this to work, the GitHub aciton uses OIDC to get access to an ops role.  The Ops role is granted access to the various accounts subject to nuke via another assume-role done by the reusable workflow.  

## Terraform
more to come...