package org.mermer.todoapi.repository;

import org.mermer.todoapi.dto.SearchCond;
import org.mermer.todoapi.entity.TodoItem;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class TodoItemJpaRepository implements TodoItemRepository {
	@Override
	public TodoItem save(TodoItem item) {
		return null;
	}

	@Override
	public TodoItem findById(Long id) {
		return null;
	}

	@Override
	public List<TodoItem> findAll(SearchCond searchCond) {
		return null;
	}
}
