# Exit on Error
set -e

OUTPUT_FILE=/secrets/elasticsearch.keystore
NATIVE_FILE=/usr/share/elasticsearch/config/elasticsearch.keystore


# Create Keystore
printf "========== Creating Elasticsearch Keystore ==========\n"
printf "=====================================================\n"
elasticsearch-keystore create >> /dev/null

# Setting Secrets

## Setting Bootstrap Password
echo "Setting bootstrap.password..."
(echo "$ELASTIC_PASSWORD" | elasticsearch-keystore add -x 'bootstrap.password')
echo "Elastic password is: $ELASTIC_PASSWORD"


# Replace current Keystore
if [ -f "$OUTPUT_FILE" ]; then
    echo "Remove old elasticsearch.keystore"
    rm $OUTPUT_FILE
fi

echo "Saving new elasticsearch.keystore"
mv $NATIVE_FILE $OUTPUT_FILE
chmod 0644 $OUTPUT_FILE

printf "======= Keystore setup completed successfully =======\n"
printf "=====================================================\n"