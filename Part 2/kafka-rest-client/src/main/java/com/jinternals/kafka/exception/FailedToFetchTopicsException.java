package com.jinternals.kafka.exception;

public class FailedToFetchTopicsException extends Exception {
    public FailedToFetchTopicsException(String message, Throwable cause) {
        super(message, cause);
    }
}
