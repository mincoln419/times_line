package org.mermer.todoapi.controller;

import lombok.RequiredArgsConstructor;
import org.mermer.todoapi.config.QueryString;
import org.mermer.todoapi.dto.SearchCondItem;
import org.mermer.todoapi.dto.TemplateTodoItemDto;
import org.mermer.todoapi.service.TemplateTodoItemService;
import org.springframework.data.repository.query.Param;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/tmp-item")
public class TemplateTodoItemController {

	final private TemplateTodoItemService templateTodoItemService;


	@GetMapping
	public ResponseEntity<List<TemplateTodoItemDto>> selectTemplateItem(@QueryString SearchCondItem searchCond) {

		//**validation
		//+ required parameter
		//+ date range check
		//+ formatting check
		//


		//service call
		List<TemplateTodoItemDto> result = templateTodoItemService.selectTemplateTodoItems(searchCond);


		//response
		return ResponseEntity.ok(result);
	}


	@GetMapping(value = "/{id}")
	public ResponseEntity<TemplateTodoItemDto> selectTemplateItem(@PathVariable("id") Long id) {


		TemplateTodoItemDto result = templateTodoItemService.selectTemplateTodoItems(SearchCondItem.builder().templateId(id).build()).get(0);
		return ResponseEntity.ok().body(result);
	}

	@PostMapping("/")
	public ResponseEntity<TemplateTodoItemDto> saveTemplateItem(@RequestBody TemplateTodoItemDto dto) {

		TemplateTodoItemDto result = templateTodoItemService.saveTemplateTodoItem(dto);

		return ResponseEntity.ok().body(result);
	}
}
