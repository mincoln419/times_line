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

	private String templateTitle;

	private String contents;

	private ContentType contentType;

	public static List<TemplateTodoItemDto> body(List<TemplateTodoItem> todoItems) {

		return todoItems == null ? List.of() : todoItems.stream().map(item -> TemplateTodoItemDto
				.builder()
								.timeUser(item.getTimeLineTemplate().getTimeUser())
								.templateTitle(item.getTitle())
								.contents(item.getContents())
								.contentType(item.getContentType())
						.build()
				)
				.collect(Collectors.toList());
	}
}
