package com.jinternals.kafka.controllers;

import com.jinternals.kafka.controllers.response.KafkaTopics;
import com.jinternals.kafka.exception.FailedToFetchTopicsException;
import com.jinternals.kafka.services.KafkaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

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

}
