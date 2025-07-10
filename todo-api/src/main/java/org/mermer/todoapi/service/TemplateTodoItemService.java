package org.mermer.todoapi.service;

import lombok.RequiredArgsConstructor;
import org.mermer.todoapi.dto.SearchCondItem;
import org.mermer.todoapi.dto.SearchCondTemplate;
import org.mermer.todoapi.dto.TemplateTodoItemDto;
import org.mermer.todoapi.entity.TemplateTodoItem;
import org.mermer.todoapi.entity.TimeLineTemplate;
import org.mermer.todoapi.repository.TemplateTodoItemRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional
public class TemplateTodoItemService {

	private final TemplateTodoItemRepository templateTodoItemRepository;

	private final TimelineTemplateService timelineTemplateService;

	public List<TemplateTodoItemDto> selectTemplateTodoItems(SearchCondItem searchCond) {

		List<TemplateTodoItem> todoItem = templateTodoItemRepository.findAll(searchCond);

		return TemplateTodoItemDto.parseTemplateItemDtoList(todoItem);
	}

	public TemplateTodoItemDto saveTemplateTodoItem(TemplateTodoItemDto dto) {

		TemplateTodoItem parse = TemplateTodoItem.builder()
				.timeLineTemplate(timelineTemplateService.selectTimelineTemplate(SearchCondTemplate.builder().build()).orElseGet(TimeLineTemplate.empty()))

				.build();
		TemplateTodoItem result = templateTodoItemRepository.save(parse);
		return TemplateTodoItemDto.parseTemplateItemDto(result);
	}
}
