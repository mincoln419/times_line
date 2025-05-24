package org.mermer.todoapi.repository.impl;

import org.mermer.todoapi.dto.SearchCondItem;
import org.mermer.todoapi.entity.TodoItem;
import org.mermer.todoapi.repository.TodoItemRepository;
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
	public List<TodoItem> findAll(SearchCondItem searchCondItem) {
		return null;
	}
}
