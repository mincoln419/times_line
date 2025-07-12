package org.mermer.todoapi.controller;

import lombok.RequiredArgsConstructor;
import org.mermer.todoapi.config.QueryString;
import org.mermer.todoapi.dto.SearchCondItem;
import org.mermer.todoapi.dto.TimeLineTemplateItemDto;
import org.mermer.todoapi.service.TemplateTodoItemService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/tmp-item")
public class TemplateTodoItemController {

	final private TemplateTodoItemService templateTodoItemService;


	@GetMapping
	public ResponseEntity<List<TimeLineTemplateItemDto>> selectTemplateItem(@QueryString SearchCondItem searchCond) {

		//**validation
		//+ required parameter
		//+ date range check
		//+ formatting check
		//


		//service call
		List<TimeLineTemplateItemDto> result = templateTodoItemService.selectTemplateTodoItems(searchCond);


		//response
		return ResponseEntity.ok(result);
	}


	@GetMapping(value = "/{id}")
	public ResponseEntity<TimeLineTemplateItemDto> selectTemplateItem(@PathVariable("id") Long id) {


		TimeLineTemplateItemDto result = templateTodoItemService.selectTemplateTodoItems(SearchCondItem.builder().templateId(id).build()).get(0);
		return ResponseEntity.ok().body(result);
	}

	@PostMapping("/")
	public ResponseEntity<TimeLineTemplateItemDto> saveTemplateItem(@RequestBody TimeLineTemplateItemDto dto) {

		TimeLineTemplateItemDto result = templateTodoItemService.saveTemplateTodoItem(dto);

		return ResponseEntity.ok().body(result);
	}
}
