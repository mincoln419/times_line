package org.mermer.todoapi.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.mermer.todoapi.entity.TemplateTodoItem;
import org.mermer.todoapi.entity.enumeration.ContentType;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class TemplateTodoItemDto {


	private Long timeLineTemplateId;

	private String title;

	private LocalDateTime time;

	private ContentType contentType;

	public static List<TemplateTodoItemDto> parseTemplateItemDtoList(List<TemplateTodoItem> todoItems) {

		return todoItems == null ? List.of() : todoItems.stream().map(item -> TemplateTodoItemDto
				.builder()
								.title(item.getTitle())
								.time(item.getTime())
								.contentType(item.getContentType())
						.build()
				)
				.collect(Collectors.toList());
	}

	public static TemplateTodoItemDto parseTemplateItemDto(TemplateTodoItem result) {
		return TemplateTodoItemDto.builder()
				.timeLineTemplateId(result.getId())
				.contentType(result.getContentType())
				.time(result.getTime())
				.title(result.getTitle())
				.build();
	}
}
