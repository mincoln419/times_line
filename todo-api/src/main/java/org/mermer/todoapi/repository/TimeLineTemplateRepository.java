package org.mermer.todoapi.repository;

import org.mermer.todoapi.entity.TimeLineTemplate;
import org.mermer.todoapi.entity.TimeUser;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface TimeLineTemplateRepository extends JpaRepository<TimeLineTemplate, Long> {

	@Query("SELECT t FROM TimeLineTemplate t WHERE t.timeUser.id = :userId")
	List<TimeLineTemplate> findByUserId(@Param("userId") String userId);

	List<TimeLineTemplate> findByTimeUserId(String userId);
}
