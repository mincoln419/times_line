package org.mermer.todoapi.service;

import jakarta.annotation.Resource;
import lombok.AllArgsConstructor;
import org.mermer.todoapi.dto.SearchCondItem;
import org.mermer.todoapi.dto.TodoItemDto;
import org.mermer.todoapi.entity.TodoItem;
import org.mermer.todoapi.repository.TodoItemRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.function.Function;

@Service
@AllArgsConstructor
public class TodoItemService {

	@Resource
	final private TodoItemRepository todoItemRepository;

	public List<TodoItemDto> selectTodoList(SearchCondItem searchCondItem) {

		return todoItemRepository.findAll(searchCondItem)
				.stream()
				.map(getTodoItemTodoItemDtoFunction())
				.toList();
	}

	public Function<TodoItem, TodoItemDto> getTodoItemTodoItemDtoFunction() {
		return item -> TodoItemDto
				.builder()
				.description(item.getContents())
				.createdTime(item.getCreateAt())

				.build();
	}
}
