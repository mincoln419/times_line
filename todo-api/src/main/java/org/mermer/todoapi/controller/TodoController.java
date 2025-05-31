package org.mermer.todoapi.controller;

import jakarta.annotation.Resource;
import org.mermer.todoapi.config.QueryString;
import org.mermer.todoapi.dto.SearchCondItem;
import org.mermer.todoapi.dto.TodoItemDto;
import org.mermer.todoapi.service.TodoItemService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/v1/todos")
public class TodoController {

	@Resource
	private TodoItemService todoItemService;
	@GetMapping
	public ResponseEntity<List<TodoItemDto>> selectTodoList(@QueryString SearchCondItem searchCondItem){

		List<TodoItemDto> todos = todoItemService.selectTodoList(searchCondItem);

	return ResponseEntity.of(Optional.ofNullable(todos));
}

}