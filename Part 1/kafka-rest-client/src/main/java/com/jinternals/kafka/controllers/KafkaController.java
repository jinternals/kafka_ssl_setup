package com.jinternals.kafka.controllers;

import com.jinternals.kafka.controllers.response.KafkaTopics;
import com.jinternals.kafka.exception.FailedToFetchTopicsException;
import com.jinternals.kafka.services.KafkaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import static org.springframework.http.MediaType.APPLICATION_JSON_VALUE;
import static org.springframework.http.MediaType.APPLICATION_XML_VALUE;

@RestController
@RequestMapping(value = "/api/kafka")
@Validated
public class KafkaController {

    private KafkaService kafkaService;

    @Autowired
    public KafkaController(KafkaService kafkaService) {
        this.kafkaService = kafkaService;
    }

    @GetMapping("/topics")
    public KafkaTopics getTopics() throws FailedToFetchTopicsException {
        return new KafkaTopics(kafkaService.getKafkaTopics());
    }

    @PostMapping( value = "/topic/{topicName}", consumes = APPLICATION_JSON_VALUE)
    public void sendJsonEventToTopic(@PathVariable("topicName") String topicName,
                                     @RequestHeader(name = "key") String key,
                                     @RequestBody String payload){
        kafkaService.sendEventToTopic(topicName, key, payload);
    }

}
