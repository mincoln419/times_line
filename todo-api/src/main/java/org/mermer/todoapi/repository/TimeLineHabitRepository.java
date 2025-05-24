package org.mermer.todoapi.repository;

import org.mermer.todoapi.entity.TimeLineHabit;
import org.springframework.data.jpa.repository.JpaRepository;

public interface TimeLineHabitRepository extends JpaRepository<TimeLineHabit, Long> {
}
