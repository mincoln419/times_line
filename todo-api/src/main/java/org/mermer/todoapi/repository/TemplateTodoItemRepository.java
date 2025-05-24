package org.mermer.todoapi.repository;

import org.mermer.todoapi.entity.TemplateTodoItem;
import org.springframework.data.jpa.repository.JpaRepository;


public interface TemplateTodoItemRepository extends JpaRepository<TemplateTodoItem, Long> {


}
