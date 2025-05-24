package org.mermer.todoapi.repository;

import org.mermer.todoapi.dto.SearchCondItem;
import org.mermer.todoapi.entity.TodoItem;

import java.util.List;

public interface TodoItemRepository  {

	TodoItem save(TodoItem item);

	TodoItem findById(Long id);

	List<TodoItem> findAll(SearchCondItem searchCondItem);

}
