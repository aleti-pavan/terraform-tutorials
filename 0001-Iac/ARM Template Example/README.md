# Commands

1. Have `az cli` installed.
2. `az login`
3. `az account list`
4. `az account set -s <subscritpion>`
5. `az account show - to confirm subscription`

## Validate & Deploy Template

```
az deployment validate --template-file rg.json --parameters @params-rg.json --location westus

(above command throws you a json if the template is valid)

az deployment create --template-file rg.json --parameters @params-rg.json --location westus --name rg
```