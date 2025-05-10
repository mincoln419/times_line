package org.mermer.todoapi.repository;

import org.mermer.todoapi.dto.SearchCond;
import org.mermer.todoapi.entity.TodoItem;

import java.util.List;

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
