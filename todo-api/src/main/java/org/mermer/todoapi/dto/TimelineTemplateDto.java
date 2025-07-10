package org.mermer.todoapi.dto;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.mermer.todoapi.entity.TemplateTodoItem;
import org.mermer.todoapi.entity.TimeLineTemplate;
import org.mermer.todoapi.entity.TimeUser;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class TimelineTemplateDto {

	public Long timelineId;

	public String timeUserId;

	public String templateTitle;

	public static TimelineTemplateDto convert(TimeLineTemplate timeLineTemplate) {
			return TimelineTemplateDto.builder()
					.timelineId(timeLineTemplate.getId())
					.timeUserId(timeLineTemplate.getTimeUser().getId())
					.templateTitle(timeLineTemplate.getTemplateTitle())
					.build();
	}
}
