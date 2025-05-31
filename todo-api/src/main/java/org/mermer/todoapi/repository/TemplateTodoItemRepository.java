package org.mermer.todoapi.repository;

import org.mermer.todoapi.dto.SearchCondItem;
import org.mermer.todoapi.entity.TemplateTodoItem;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;


public interface TemplateTodoItemRepository  {

	public List<TemplateTodoItem> findAll(SearchCondItem searchCondItem);

	Optional<TemplateTodoItem> findById(Long id);

	TemplateTodoItem save(TemplateTodoItem item);
}
