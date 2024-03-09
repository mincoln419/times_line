package org.mermer.todoapi.service;

import jakarta.annotation.Resource;
import lombok.AllArgsConstructor;
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

	public List<TodoItemDto> selectTodoList() {

		return todoItemRepository.findAll()
				.stream()
				.map(getTodoItemTodoItemDtoFunction())
				.toList();
	}

	public Function<TodoItem, TodoItemDto> getTodoItemTodoItemDtoFunction() {
		return item -> TodoItemDto
				.builder()
				.title(item.getTitle())
				.contents(item.getContents())
				.createdAt(item.getCreatedAt())
				.targetDate(item.getTargetDate())
				.build();
	}
}
