package org.mermer.todoapi.dto;

import lombok.Builder;
import lombok.Data;
import org.mermer.todoapi.entity.TemplateTodoItem;
import org.mermer.todoapi.entity.TimeLineTemplate;
import org.mermer.todoapi.entity.TimeUser;
import org.mermer.todoapi.entity.enumeration.ContentType;

import java.util.List;
import java.util.stream.Collectors;

@Data
@Builder
public class TemplateTodoItemDto {

	private TimeUser timeUser;

	private Long timeLineTemplateId;

	private String title;

	private ContentType contentType;

	public static List<TemplateTodoItemDto> body(List<TemplateTodoItem> todoItems) {

		return todoItems == null ? List.of() : todoItems.stream().map(item -> TemplateTodoItemDto
				.builder()
								.timeUser(item.getTimeLineTemplate().getTimeUser())
								.title(item.getTitle())
								.contentType(item.getContentType())
						.build()
				)
				.collect(Collectors.toList());
	}
}
