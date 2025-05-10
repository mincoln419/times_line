package org.mermer.todoapi.repository;

import org.mermer.todoapi.dto.SearchCond;
import org.mermer.todoapi.entity.TodoItem;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

public interface TodoItemRepository  {

	TodoItem save(TodoItem item);

	TodoItem findById(Long id);

	List<TodoItem> findAll(SearchCond searchCond);

}
