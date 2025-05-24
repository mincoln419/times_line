package org.mermer.todoapi.repository;

import org.mermer.todoapi.entity.DailyTimeline;
import org.springframework.data.jpa.repository.JpaRepository;

public interface DailyTimelineRepository {
	DailyTimeline save(DailyTimeline dailyTimeline);

	DailyTimeline findById(Long id);

}
