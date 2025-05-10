package org.mermer.todoapi.entity;

import jakarta.persistence.*;
import lombok.*;

import java.util.List;

@Entity
@Getter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class TimeLineTemplate extends BaseEntity {

	@Id @GeneratedValue(strategy = GenerationType.SEQUENCE)
	public Long id;

	public String content;
	@Enumerated(EnumType.STRING)
	public ContentType contentType;

	public String typeRegister;

	@OneToMany(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
	@JoinColumn(name = "todo_item_id")
	public List<TodoItem> items;


}
