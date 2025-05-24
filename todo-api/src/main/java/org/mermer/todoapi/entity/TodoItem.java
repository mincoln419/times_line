package org.mermer.todoapi.entity;

import jakarta.persistence.*;
import lombok.*;
import org.mermer.todoapi.entity.enumeration.ContentType;
import org.mermer.todoapi.entity.enumeration.TaskStatus;

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

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "daily_timeline_id")
	private DailyTimeline dailyTimeline;

	private String title;

	private String contents;

	@Enumerated(EnumType.STRING)
	private ContentType contentType;

	@Enumerated(EnumType.STRING)
	private TaskStatus taskStatus;

}
