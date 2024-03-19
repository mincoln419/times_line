package org.mermer.todoapi.controller;

import jakarta.annotation.Resource;
import org.mermer.todoapi.dto.TodoItemDto;
import org.mermer.todoapi.service.TodoItemService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Optional;

@RestController
public class TodoController {

	@Resource
	private TodoItemService todoItemService;
	@GetMapping("/api/v1/todos")
	public ResponseEntity<List<TodoItemDto>> selectTodoList(){

		List<TodoItemDto> todos = todoItemService.selectTodoList();

	return ResponseEntity.of(Optional.ofNullable(todos));
}

}