# cpp_kafka_interface
C++ application that connects to a Kafka server, subscribe to a topic, and receive the latest message

In this example, we create a ConsumerCb class that implements the consume_cb method, which is called by the Kafka client library whenever a new message is received. The consume_cb method simply prints the message payload to the console.

We then create a Kafka consumer object and configure it with the broker list and topic we want to subscribe to. We also set the start method to begin consuming messages from the end of the topic's partition to ensure we receive the latest message.

Finally, we enter a loop where we repeatedly call the consume method to poll for new messages. The consume_cb method is called whenever a new message is received, and the latest message is printed to the console.

Note that this is a very basic example and may need to be modified to suit your specific needs, such as adding error handling and message processing logic. Additionally, you will need to install the Kafka C++ client library and its dependencies in order to compile and run this code.
