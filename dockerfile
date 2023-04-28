# This dockerfile starts with an Ubuntu image and installs the Java runtime and wget. It then downloads and extracts Kafka, compiles the C++ application using g++, and starts the Kafka server. After a short delay to ensure the Kafka server is ready, it creates a test topic and produces two test messages using the Kafka console producer. Finally, it runs the C++ application.

# build and run the Docker container using the following commands:
#docker build -t kafka-cpp .
#docker


FROM ubuntu:latest

# Install Kafka and dependencies
RUN apt-get update && apt-get install -y openjdk-8-jdk wget && \
    wget https://downloads.apache.org/kafka/2.8.0/kafka_2.12-2.8.0.tgz && \
    tar -xzf kafka_2.12-2.8.0.tgz && \
    rm kafka_2.12-2.8.0.tgz

# Copy C++ application
COPY consumer.cpp /

# Compile C++ application
RUN apt-get install -y g++ && \
    g++ -std=c++11 -I/usr/local/include/librdkafka consumer.cpp -L/usr/local/lib -lrdkafka -lrdkafka++ -o consumer

# Start Kafka server
CMD /kafka_2.12-2.8.0/bin/zookeeper-server-start.sh /kafka_2.12-2.8.0/config/zookeeper.properties & \
    /kafka_2.12-2.8.0/bin/kafka-server-start.sh /kafka_2.12-2.8.0/config/server.properties & \
    sleep 10 && \
    # Create test topic and produce data
    /kafka_2.12-2.8.0/bin/kafka-topics.sh --create --bootstrap-server localhost:9092 --replication-factor 1 --partitions 1 --topic test && \
    echo "test message 1" | /kafka_2.12-2.8.0/bin/kafka-console-producer.sh --broker-list localhost:9092 --topic test && \
    echo "test message 2" | /kafka_2.12-2.8.0/bin/kafka-console-producer.sh --broker-list localhost:9092 --topic test && \
    # Run C++ application
    ./consumer
