package org.mermer.todoapi.service;

import lombok.RequiredArgsConstructor;
import org.mermer.todoapi.dto.SearchCondTemplate;
import org.mermer.todoapi.dto.TimelineTemplateDto;
import org.mermer.todoapi.repository.TimeLineTemplateRepository;
import org.springframework.http.ProblemDetail;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
@RequiredArgsConstructor
public class TimelineTemplateService {

	private final TimeLineTemplateRepository timeLineTemplateRepository;


	public TimelineTemplateDto selectTimelineTemplate(SearchCondTemplate searchCond) {

		return TimelineTemplateDto.convert(timeLineTemplateRepository.findById(searchCond.templateId));
	}
}
