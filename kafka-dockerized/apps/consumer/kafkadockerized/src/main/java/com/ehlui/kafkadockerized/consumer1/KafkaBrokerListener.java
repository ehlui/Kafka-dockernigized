package com.ehlui.kafkadockerized.consumer1;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.stereotype.Component;

@Component
public class KafkaBrokerListener {
    private final static Logger logger = LoggerFactory.getLogger(ConsumerController.class);

    @KafkaListener(topics = "${message.topic.name:test2}", groupId = "${spring.kafka.consumer.group-id:group_1}")
    public void listenTopicTest(String message) {
        System.out.println("Recieved Message of topic1 in  listener: " + message);
        logger.info("Recieved Message of topic1 in  listener: " + message);
    }
}
