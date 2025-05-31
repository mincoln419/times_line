package org.mermer.todoapi.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Entity
@Builder
@Getter
@RequiredArgsConstructor
@AllArgsConstructor
public class TimeLineHabit {

	@Id @GeneratedValue(strategy = GenerationType.SEQUENCE)
	private Long id;

	@ManyToOne(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
	@JoinColumn(name = "user_id")
	private TimeUser timeUser;

	private String contents;

}
