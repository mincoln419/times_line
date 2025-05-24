package org.mermer.todoapi.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDate;
import java.util.List;

@Entity
@Getter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class DailyTimeline extends BaseEntity{

	@Id @GeneratedValue(strategy = GenerationType.SEQUENCE)
	@Column(name = "daily_timeline_id")
	private Long id;
	private LocalDate timelineDate;

	@ManyToOne(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
	@JoinColumn
	private TimeUser timeUser;

	@OneToMany(mappedBy = "dailyTimeline", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
	private List<TodoItem> items;
}
