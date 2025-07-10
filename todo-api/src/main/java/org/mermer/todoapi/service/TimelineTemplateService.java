package org.mermer.todoapi.service;

import lombok.RequiredArgsConstructor;
import org.mermer.todoapi.dto.SearchCondTemplate;
import org.mermer.todoapi.dto.TimelineTemplateDto;
import org.mermer.todoapi.entity.TimeLineTemplate;
import org.mermer.todoapi.repository.TimeLineTemplateRepository;
import org.springframework.http.ProblemDetail;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
@RequiredArgsConstructor
public class TimelineTemplateService {

	private final TimeLineTemplateRepository timeLineTemplateRepository;

	private final TimeUserService timeUserService;


	public Optional<TimeLineTemplate> selectTimelineTemplate(SearchCondTemplate searchCond) {

		return timeLineTemplateRepository.findById(searchCond.templateId);
	}

	public TimeLineTemplate saveTimelineTemplate(TimelineTemplateDto dto) {
		TimeLineTemplate parse = TimeLineTemplate.builder()
				.templateTitle(dto.getTemplateTitle())
				.timeUser(timeUserService.selectTimeUser(dto.timeUserId))
				.templateTitle(dto.getTemplateTitle())
				.build();
		return timeLineTemplateRepository.save(parse);
	}
}
