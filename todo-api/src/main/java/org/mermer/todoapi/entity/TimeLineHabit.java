package org.mermer.todoapi.entity;

import jakarta.persistence.*;

@Entity
public class TimeLineHabit {

	@Id @GeneratedValue(strategy = GenerationType.SEQUENCE)
	private Long id;

	@ManyToOne(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
	@JoinColumn(name = "user_id")
	private TimeUser timeUser;

	private String contents;


}
