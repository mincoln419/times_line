package org.mermer.todoapi.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.mermer.todoapi.dto.enumeration.TaskType;

import java.time.LocalDateTime;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class TodoItemDto {

	private int timeline;
	private String title;
	private String description;
	private TodoTaskStatus todoTaskStatus;
	private TaskType taskType;
	private LocalDateTime createdTime;

}
