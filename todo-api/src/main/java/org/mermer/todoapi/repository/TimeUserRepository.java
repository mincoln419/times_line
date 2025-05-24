package org.mermer.todoapi.repository;

import org.mermer.todoapi.entity.TimeUser;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TimeUserRepository extends JpaRepository<TimeUser, String> {
}
