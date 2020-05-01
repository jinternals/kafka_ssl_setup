package com.jinternals.kafka.services;

import com.jinternals.kafka.exception.FailedToFetchTopicsException;
import org.apache.kafka.clients.admin.AdminClient;
import org.apache.kafka.clients.admin.ListTopicsOptions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.kafka.core.KafkaAdmin;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.stereotype.Service;

import java.util.Set;

import static java.util.stream.Collectors.toSet;
import static org.apache.kafka.clients.admin.AdminClient.create;

@Service
public class KafkaService {
    public static final String INTERNAL_CONSUMER_PREFIX = "__";

    private KafkaTemplate<String, String> kafkaTemplate;

    private KafkaAdmin kafkaAdmin;

    @Autowired
    public KafkaService(KafkaAdmin kafkaAdmin,
                        KafkaTemplate<String, String> kafkaTemplate){
        this.kafkaAdmin = kafkaAdmin;
        this.kafkaTemplate = kafkaTemplate;
    }

    public Set<String> getKafkaTopics() throws FailedToFetchTopicsException {
        AdminClient client = create(kafkaAdmin.getConfig());
        try {
            return getNonInternalKafkaTopics(client.listTopics(new ListTopicsOptions()).names().get());
        }catch (Exception exception){
            throw new FailedToFetchTopicsException("Failed to fetch kafka topics.", exception);
        }finally {
            client.close();
        }
    }

    public void sendEventToTopic(String topic,String key,String event) {
        kafkaTemplate.send(topic,key, event);
    }

    private Set<String> getNonInternalKafkaTopics(Set<String> topics) {
        return topics
                .stream()
                .filter(KafkaService::nonInternalKafkaTopic)
                .collect(toSet());
    }

    private static boolean nonInternalKafkaTopic(String s) {
        return !s.startsWith(INTERNAL_CONSUMER_PREFIX);
    }

}
