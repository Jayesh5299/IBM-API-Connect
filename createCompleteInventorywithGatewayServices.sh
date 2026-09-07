#!/bin/bash

SERVER="apimanager.demo.com"
ORG="demo-org"
CATALOG="demo-catalog"

OUTPUT="APIC_${CATALOG}_Inventory_$(date +%Y%m%d_%H%M%S).csv"

echo "Catalog,Space,Product,Version,State,Gateway Service" > "$OUTPUT"

echo "Fetching spaces for catalog: $CATALOG"

# Get all spaces for the selected catalog
apic spaces:list \
    --catalog "$CATALOG" \
    --org "$ORG" \
    --server "$SERVER" \
    --format json > /tmp/spaces.json

if [ $? -ne 0 ]; then
    echo "ERROR: Unable to fetch spaces."
    exit 1
fi

# Loop through every space
jq -r '.results[]?.name' /tmp/spaces.json | while read -r SPACE
do

    echo ""
    echo "================================================"
    echo "Catalog : $CATALOG"
    echo "Space   : $SPACE"
    echo "================================================"

    # --------------------------------------------------------
    # Get Products
    # --------------------------------------------------------

    PRODUCTS=$(apic products:list-all \
        --server "$SERVER" \
        --org "$ORG" \
        --catalog "$CATALOG" \
        --scope space \
        --space "$SPACE" \
        --format json 2>/dev/null)

    # --------------------------------------------------------
    # Get Gateway Services
    # --------------------------------------------------------

    GATEWAYS=$(apic configured-gateway-services:list \
        --scope space \
        --catalog "$CATALOG" \
        --space "$SPACE" \
        --org "$ORG" \
        --server "$SERVER" \
        --format json 2>/dev/null)

    GATEWAY=$(echo "$GATEWAYS" | jq -r '
        .results[]?.name // empty
    ' | paste -sd ";" -)

    [ -z "$GATEWAY" ] && GATEWAY="N/A"

    # --------------------------------------------------------
    # Extract Products
    # --------------------------------------------------------

    echo "$PRODUCTS" | jq -r '
        .results[]? |
        [
            (.name // "N/A"),
            (.version // "N/A"),
            (.state // "N/A")
        ] |
        @tsv
    ' | while IFS=$'\t' read -r PRODUCT VERSION STATE
    do

        echo "Product : $PRODUCT"
        echo "Version : $VERSION"
        echo "State   : $STATE"
        echo "Gateway : $GATEWAY"

        # Write to CSV
        echo "\"$CATALOG\",\"$SPACE\",\"$PRODUCT\",\"$VERSION\",\"$STATE\",\"$GATEWAY\"" \
            >> "$OUTPUT"

    done

done

echo ""
echo "================================================"
echo "Completed"
echo "================================================"
echo "CSV File: $(pwd)/$OUTPUT"
echo "================================================"