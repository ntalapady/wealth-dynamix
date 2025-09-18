\# Terraform Azure Storage Solution



\## Overview

This Terraform project provisions \*\*Azure Storage Accounts\*\* for \*\*multiple clients\*\* across \*\*multiple environments\*\* (Dev, Test, Staging, and Prod).



The solution is:

\- \*\*Reusable\*\* – Single codebase for all clients and environments.

\- \*\*Scalable\*\* – Easily onboard new clients or environments by simply updating variables.

\- \*\*Consistent\*\* – Enforces a standardized naming convention and tagging structure.

\- \*\*Compliant\*\* – Follows Azure naming rules and Terraform best practices.



---



\## Features

\- Automatic creation of one \*\*Storage Account per client per environment\*\*.

\- Optional \*\*Resource Group creation\*\* for each client-environment pair.

\- \*\*Environment-specific SKUs\*\* (e.g., Prod can use GRS, Dev uses LRS).

\- Clean separation of files:

&nbsp; - Root-level orchestration

&nbsp; - Reusable storage module

\- Globally unique storage account names (using a random 4-character suffix).



---



\## Prerequisites



Before you start, ensure you have the following installed and configured:



| Tool        | Minimum Version |

|-------------|----------------|

| Terraform   | 1.3.0+         |

| Azure CLI   | 2.30.0+        |

| Azure Subscription | Required |



You must also authenticate Terraform with Azure.  

Recommended methods:

\- Azure CLI: `az login`

\- Service Principal (set environment variables):

&nbsp; ```bash

&nbsp; export ARM\_CLIENT\_ID="xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"

&nbsp; export ARM\_CLIENT\_SECRET="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"

&nbsp; export ARM\_SUBSCRIPTION\_ID="xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"

&nbsp; export ARM\_TENANT\_ID="xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"





\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_

terraform-azure-storage/

├─ providers.tf             # Provider configuration

├─ variables.tf             # Root-level variables

├─ locals.tf                # Derived and computed values

├─ main.tf                   # Root orchestration (calls module)

├─ outputs.tf               # Root outputs

├─ terraform.tfvars         # Example variable values

└─ modules/

&nbsp;  └─ storage\_account/

&nbsp;     ├─ main.tf            # Module logic for storage accounts

&nbsp;     ├─ variables.tf       # Module variables

&nbsp;     └─ outputs.tf         # Module outputs



\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_

