package org.mermer.todoapi.entity;

import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import lombok.*;
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

	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate targetDate;

	@DateTimeFormat(pattern = "yyyy-MM-dd'T'hh:mm:ss")
	private LocalDateTime createdAt;


}
