# Azure AI Studio demo of a RAG in python using Terraform for ressource creation

## disclaimer

- I try to set all the config to minimal values or even to free tiers when possible, but cost may occurs (that's how cloud works). destroy all the ressources as soon as you are done with them.
- This is a WIP (see todo section)

## running
you need a n azure account
in Powershell or in bash set your environement with:
- Azure Cli
- Terraform

Connect to your subscription with `az login`.  
get tenant and subscription info with `az account show`.

Add two env vars, for your subscription and tenant:
- ARM_TENANT_ID
- ARM_SUBSCRIPTION_ID

(reminder: $env:VAR=value in PS)

You should be able to run:
```
terraform init -upgrade
terraform plan -out main.tfplan
```

And be able to use this ressources in a python chat with RAG like described in this tutorial skipping step 1: https://learn.microsoft.com/en-us/azure/ai-studio/tutorials/copilot-sdk-create-resources.  
I plan to add my own simplified code later on.

# TODO
- [ ] create simple python rag code
- [ ] add TFstate management 

# ref
Note: documentation is kind of outdated on official azure this repo try to be as up-to-date as possible as for September 2024. Anyway here are some starting point that I have adapted:
- [Azure RM 4.2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [AZ AI Studio - create a hub with TF](https://learn.microsoft.com/en-us/azure/ai-studio/how-to/create-hub-terraform?tabs=azure-cli)
- [AZ AI Services](https://learn.microsoft.com/en-us/azure/ai-services/create-account-terraform?tabs=azure-cli)
- [AZ AI Search](https://learn.microsoft.com/en-us/azure/search/search-get-started-terraform)
