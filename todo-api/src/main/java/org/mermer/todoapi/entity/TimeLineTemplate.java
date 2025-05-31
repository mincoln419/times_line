package org.mermer.todoapi.entity;

import jakarta.persistence.*;
import lombok.*;

import java.util.ArrayList;
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

	@ManyToOne(fetch = FetchType.LAZY, cascade = CascadeType.MERGE)
	public TimeUser timeUser;

	public String templateTitle;

	@OneToMany(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
	@JoinColumn(name = "template_todo_item_id")
	public List<TemplateTodoItem> items = new ArrayList<>();


}
