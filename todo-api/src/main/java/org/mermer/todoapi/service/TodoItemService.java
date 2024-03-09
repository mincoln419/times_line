package org.mermer.todoapi.service;

import org.mermer.todoapi.dto.QueryDto;
import org.mermer.todoapi.dto.TodoItemDto;
import org.mermer.todoapi.entity.TodoItem;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TodoItemService {

	public List<TodoItemDto> selectTodoList(QueryDto todoItemDto){
		return null;
	}
}
