package org.mermer.todoapi.entity;

import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import jakarta.persistence.*;
import lombok.*;
import org.mermer.todoapi.dto.TaskType;
import org.mermer.todoapi.dto.TodoTaskStatus;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Getter
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Entity
@ToString
public class TodoItem extends BaseEntity {

	@Id @GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "todo_item_id")
	private Long id;

	private String contents;

	@Enumerated(EnumType.STRING)
	private ContentType contentType;

}
