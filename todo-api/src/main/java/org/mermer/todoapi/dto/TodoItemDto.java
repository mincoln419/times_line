package org.mermer.todoapi.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class TodoItemDto {

	private String title;

	private String contents;

	private LocalDate targetDate;

	private LocalDateTime createdAt;

	private String userId;

}
