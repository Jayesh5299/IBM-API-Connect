# IBM API Connect — API Inventory & Download Toolkit

Shell scripts to automate API inventory collection and API definition downloads from IBM API Connect.

This repository provides two utilities:
1. Download APIs from multiple Catalogs (names should be specified) in an IBM API Connect Organization.
2. Generate a Catalog/Space Product Inventory containing published Products and configured Gateway Service names in a CSV file that can be opened with Microsoft Excel.

## Repository Structure

ibm-apic-inventory/
│
├── README.md
│
├── scripts/
│   ├── download-apis.sh
│   └── generate-product-inventory.sh
│
├── output/
│   ├── ibm-apic-inventory/
│   │   ├── catlog1/
│   │   ├── catlog2/
│   │   ├── catlog3/
│   │   └── ...
│   │
│   └── APIC_prod_Inventory_YYYYMMDD_HHMMSS.csv
│
└── .gitignore

# 1. Download APIs from Catalogs / Spaces

Description
`download-apis.sh` downloads API definitions from multiple IBM API Connect Catalogs belonging to an Organization.

The script:
1. Connects to the configured API Connect Management Server.
2. Iterates through the configured Catalogs.
3. Retrieves the list of APIs from each Catalog.
4. Extracts the API name and version.
5. Downloads each API definition.
6. Stores the APIs under a Catalog-specific directory.

### Flow
                    IBM API Connect
                          |
                          |
                    Organization
                      test-org
                          |
        +-----------------+-----------------+
        |                 |                 |
      catalog1          catalog2          catalog3
        |                 |                 |
       APIs              APIs              APIs
        |                 |                 |
        +-----------------+-----------------+
                          |
                          v
                    api_inventory/
## File

Scripts/download-apis.sh

**2. Generate Product Inventory**

**Description**
`generate-product-inventory.sh` generates an inventory of Products published under every Space in a selected Catalog.

The generated CSV contains:

| Column          | Description                        |
| --------------- | ---------------------------------- |
| Catalog         | API Connect Catalog                |
| Space           | Catalog Space                      |
| Product         | Product name                       |
| Version         | Product version                    |
| State           | Product lifecycle/publishing state |
| Gateway Service | Configured Gateway Service name(s) |

The CSV file can be opened directly using **Microsoft Excel**.

# Prerequisites

The following tools are required:

* IBM API Connect Toolkit / `apic` CLI
* `bash`
* `jq`
* Access to the IBM API Connect Management Server
* Appropriate API Connect permissions

Verify the installations:
$apic --version
$jq --version
$bash --version

# API Connect Authentication
Before running the scripts, authenticate the `apic` CLI against your API Connect environment.

The exact authentication command depends on your IBM API Connect Toolkit version and configured authentication mechanism.

Verify that the CLI can access the configured server:
$apic --help

Then authenticate using the procedure applicable to your API Connect environment.

> **Important:** Do not store passwords, access tokens, client secrets, or certificates in this repository.

# Configuration
Download API Configuration
scripts/download-apis.sh

**Update:**
SERVER="xxxxxx"
ORG="xxxxxx"

**Configure the Catalogs:**
CATALOGS=(
    "catalog1"
    "catalog2"
)
Add or remove Catalogs as required.

# Running the API Download
Make the script executable:
chmod +x scripts/download-apis.sh

**Run:**
apic login --server xxxx --realm provider/default-idp-2 --username xxxx--password xxxx
./scripts/download-apis.sh


Example console output:

============================================================
 IBM API Connect - API Download
 Server : apimanager.demo.com
 Org    : demo-org
============================================================

------------------------------------------------------------
Processing Catalog: catalog1
------------------------------------------------------------

Downloading: api1:1.0.0
SUCCESS: api2:1.0.0
------------------------------------------------------------
Processing Catalog: catalog2
------------------------------------------------------------

Downloading: api1:1.0.0
SUCCESS: api2:1.0.0

============================================================
Download completed.
Output directory: API_Inventory
============================================================


# API Download Output

The downloaded APIs will be organized by Catalog:

API_Inventory/
│
├── catalog1/
│   ├── api1_1.0.0.yaml
│   ├── api2.1.0.yaml
│   └── ...
│
├── catalog2/
    ├── api2_1.0.0.yaml
    └── ...

The exact downloaded filenames and file format depend on the API Connect Toolkit response and configuration.

# Generate Product Inventory
The inventory script currently targets:
CATALOG="catalog1"

To generate an inventory for another Catalog, change the value:
CATALOG="catalog2"

Make the script executable:
chmod +x scripts/generate-product-inventory.sh


Run:
./scripts/generate-product-inventory.sh


# Inventory Output

The script generates a timestamped CSV:
APIC_prod_Inventory_20260907_220500.csv


**Example:**
Catalog,Space,Product,Version,State,Gateway Service
"catalog1","space1","Product1","1.0.0","published","gateway1"
"catalog2","space2","Product2","1.0.0","published","gateway2"

The CSV can be opened directly in Microsoft Excel.
# Inventory Flow
                   IBM API Connect
                          |
                          v
                       Catalog
                          |
              +-----------+-----------+
              |                       |
            Space 1                 Space 2
              |                       |
        +-----+-----+           +-----+-----+
        |           |           |           |
     Products   Gateway      Products    Gateway
        |           |           |           |
        +-----+-----+-----------+-----+-----+
                          |
                          v
                    CSV Inventory
                          |
                          v
                    Microsoft Excel

# Recommended Repository Layout

ibm-apic-inventory/
│
├── README.md
│
├── scripts/
│   ├── download-apis.sh
│   └── generate-product-inventory.sh
│
├── output/
│   └── .gitkeep
│
└── .gitignore
```

---

# Quick Start

Clone the repository:

git clone <repository-url>
cd ibm-apic-inventory

Make the scripts executable:
chmod +x scripts/*.sh

Authenticate to IBM API Connect.
Then download APIs:
./scripts/download-apis.sh

Generate the Product inventory:
./scripts/generate-product-inventory.sh

# Use Cases
This toolkit can be used for:
* API inventory management
* API migration activities
* Disaster Recovery validation
* Catalog comparison
* API backup
* Product inventory reporting
* Gateway service mapping
* API governance
* Release validation
* Audit reporting
* Operational documentation

# Notes

* The scripts use the IBM API Connect `apic` CLI.
* Catalog and Organization names are configurable.
* The API download script supports multiple Catalogs.
* The Product inventory script processes all Spaces within the selected Catalog.
* Multiple Gateway Services are combined into a semicolon-separated value.
* The inventory is generated as CSV for easy use with Microsoft Excel.
* The exact CLI options can vary between IBM API Connect Toolkit versions. Verify commands against the Toolkit version installed in your environment.

# License

This project is intended for internal automation and operational use.

Add the appropriate organizational license or usage terms here.

Disclaimer: Validate before running it.
