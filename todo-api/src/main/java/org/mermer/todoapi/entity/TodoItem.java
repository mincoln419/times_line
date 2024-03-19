package org.mermer.todoapi.entity;

import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import jakarta.persistence.*;
import lombok.*;
import org.mermer.todoapi.dto.TaskType;
import org.mermer.todoapi.dto.TodoTaskStatus;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Entity
@ToString
public class TodoItem {

	@Id @GeneratedValue(strategy = GenerationType.AUTO)
	private Long id;

	private String title;

	private String contents;

	@Enumerated(EnumType.STRING)
	private TaskType  taskType;

	@Enumerated(EnumType.STRING)
	private TodoTaskStatus todoTaskStatus;

	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate targetDate;

	@DateTimeFormat(pattern = "yyyy-MM-dd'T'hh:mm:ss")
	private LocalDateTime createdAt;


}
