#!/bin/bash

# ============================================================
# IBM API Connect - Download APIs from All Catalogs
# ============================================================

SERVER="apimanager.demo.com"
ORG="demo-org"

# Output directory
BASE_DIR="API_inventory"

# List your catalogs here
CATALOGS=(
    "Catalog 1"
    "Catalog 2"
    "Catalog 3"

)

mkdir -p "$BASE_DIR"

echo "============================================================"
echo " IBM API Connect - API Download"
echo " Server : $SERVER"
echo " Org    : $ORG"
echo "============================================================"

for CATALOG in "${CATALOGS[@]}"; do

    echo ""
    echo "------------------------------------------------------------"
    echo "Processing Catalog: $CATALOG"
    echo "------------------------------------------------------------"

    CATALOG_DIR="$BASE_DIR/$CATALOG"
    mkdir -p "$CATALOG_DIR"

    # Get all APIs in the catalog
    API_LIST=$(apic apis:list-all --scope catalog --org "$ORG" --catalog "$CATALOG" --server "$SERVER" 2>/dev/null)

    if [ $? -ne 0 ]; then
        echo "ERROR: Unable to list APIs from catalog: $CATALOG"
        continue
    fi

    # Extract API names/versions from the output
    echo "$API_LIST" | while IFS= read -r LINE; do

        # Skip empty lines
        [ -z "$LINE" ] && continue

        # Skip header lines if present
        if [[ "$LINE" =~ ^API ]]; then
            continue
        fi

        # Extract API name:version
        API=$(echo "$LINE" | awk '{print $1}')

        # Validate API format
        if [[ ! "$API" =~ : ]]; then
            continue
        fi

        echo ""
        echo "Downloading: $API"

        apic apis:get --scope catalog --catalog "$CATALOG" --server "$SERVER" --org "$ORG" "$API" --output "$CATALOG_DIR"

        if [ $? -eq 0 ]; then
            echo "SUCCESS: $API"
        else
            echo "FAILED : $API"
        fi

    done

done

echo ""
echo "============================================================"
echo "Download completed."
echo "Output directory: $BASE_DIR"
echo "============================================================"