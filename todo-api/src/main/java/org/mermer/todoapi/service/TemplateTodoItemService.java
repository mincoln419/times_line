package org.mermer.todoapi.service;

import lombok.RequiredArgsConstructor;
import org.mermer.todoapi.dto.SearchCondItem;
import org.mermer.todoapi.dto.TemplateTodoItemDto;
import org.mermer.todoapi.entity.TemplateTodoItem;
import org.mermer.todoapi.repository.TemplateTodoItemRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional
public class TemplateTodoItemService {

	private final TemplateTodoItemRepository templateTodoItemRepository;
	public List<TemplateTodoItemDto> selectTemplateTodoItems(SearchCondItem searchCond) {

		List<TemplateTodoItem> todoItem = templateTodoItemRepository.findAll(searchCond);

		return TemplateTodoItemDto.convert(todoItem);
	}
}
