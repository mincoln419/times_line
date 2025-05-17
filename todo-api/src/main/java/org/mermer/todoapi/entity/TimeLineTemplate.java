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
	@Column(name="timeline_template_id")
	public Long id;

	public String content;
	@Enumerated(EnumType.STRING)
	public ContentType contentType;

	public String templateTitle;

	@OneToMany(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
	@JoinColumn(name = "template_todo_item_id")
	public List<TemplateTodoItem> items;


}
