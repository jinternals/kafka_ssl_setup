package com.jinternals.kafka.controllers.response;

import java.util.Set;

public class KafkaTopics {

    private Set<String> topics;

    public KafkaTopics() {
    }

    public KafkaTopics(Set<String> topics) {
        this.topics = topics;
    }

    public Set<String> getTopics() {
        return topics;
    }

    public void setTopics(Set<String> topics) {
        this.topics = topics;
    }

}
