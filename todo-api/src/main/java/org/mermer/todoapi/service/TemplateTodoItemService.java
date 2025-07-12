package org.mermer.todoapi.service;

import lombok.RequiredArgsConstructor;
import org.mermer.todoapi.dto.SearchCondItem;
import org.mermer.todoapi.dto.SearchCondTemplate;
import org.mermer.todoapi.dto.TimeLineTemplateItemDto;
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

	public List<TimeLineTemplateItemDto> selectTemplateTodoItems(SearchCondItem searchCond) {

		List<TemplateTodoItem> todoItem = templateTodoItemRepository.findAll(searchCond);

		return TimeLineTemplateItemDto.parseTemplateItemDtoList(todoItem);
	}

	public TimeLineTemplateItemDto saveTemplateTodoItem(TimeLineTemplateItemDto dto) {

		TemplateTodoItem parse = TemplateTodoItem.builder()
				.timelineTemplateId(dto.getTimeLineTemplateId())
				.title(dto.getTitle())
				.time(dto.getTime())
				.contentType(dto.getContentType())
				.build();
		TemplateTodoItem result = templateTodoItemRepository.save(parse);
		return TimeLineTemplateItemDto.parseTemplateItemDto(result);
	}
}
