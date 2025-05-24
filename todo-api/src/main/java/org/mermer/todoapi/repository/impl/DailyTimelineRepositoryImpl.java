package org.mermer.todoapi.repository.impl;

import jakarta.persistence.EntityManager;
import lombok.RequiredArgsConstructor;
import org.mermer.todoapi.entity.DailyTimeline;
import org.mermer.todoapi.repository.DailyTimelineRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
@RequiredArgsConstructor
public class DailyTimelineRepositoryImpl implements DailyTimelineRepository {


	final private EntityManager em;

	@Override
	public DailyTimeline save(DailyTimeline dailyTimeline) {
		em.persist(dailyTimeline);
		em.flush();
		return dailyTimeline ;
	}

	@Override
	public DailyTimeline findById(Long id) {
		return null;
	}
}
