package org.mermer.todoapi.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
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
@Entity
public class TodoItem {

	@Id @GeneratedValue(strategy = GenerationType.AUTO)
	private Long id;

	private String name;

	private LocalDate targetDate;

	private LocalDateTime createdAt;


}
