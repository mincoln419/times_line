package org.mermer.todoapi.controller;

import lombok.RequiredArgsConstructor;
import org.mermer.todoapi.config.QueryString;
import org.mermer.todoapi.dto.SearchCondItem;
import org.mermer.todoapi.dto.TemplateTodoItemDto;
import org.mermer.todoapi.service.TemplateTodoItemService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/tmpItem")
public class TemplateTodoItemController {

	final private TemplateTodoItemService templateTodoItemService;


	@GetMapping("/")
	public ResponseEntity<List<TemplateTodoItemDto>> selectTemplateItem(@QueryString SearchCondItem searchCond){

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

}
