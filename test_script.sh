#!/bin/bash

# Send test message to Kafka
echo "test message 3" | /kafka_2.12-2.8.0/bin/kafka-console-producer.sh --broker-list localhost:9092 --topic test

# Wait for C++ application to receive message
sleep 5

# Check that C++ application received message
if grep -q "Received message: test message 3" consumer.log; then
    echo "Test passed"
else
    echo "Test failed"
fi
