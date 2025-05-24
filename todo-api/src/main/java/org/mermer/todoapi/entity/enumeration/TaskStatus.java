package org.mermer.todoapi.entity.enumeration;

import org.springframework.scheduling.config.Task;

public enum TaskStatus {

    DONE("성공"),

    NOT_YET("미수행"),

    FAIL("실패");

    private final String message;

    private TaskStatus(String message){
        this.message = message;
    }
}
