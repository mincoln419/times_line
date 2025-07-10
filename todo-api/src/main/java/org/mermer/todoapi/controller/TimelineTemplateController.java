package org.mermer.todoapi.controller;

import jakarta.annotation.Resource;
import lombok.RequiredArgsConstructor;
import org.mermer.todoapi.config.QueryString;
import org.mermer.todoapi.dto.SearchCondTemplate;
import org.mermer.todoapi.dto.TemplateTodoItemDto;
import org.mermer.todoapi.dto.TimelineTemplateDto;
import org.mermer.todoapi.entity.TemplateTodoItem;
import org.mermer.todoapi.entity.TimeLineTemplate;
import org.mermer.todoapi.service.TimelineTemplateService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.Objects;

@RestController
@RequiredArgsConstructor
public class TimelineTemplateController {

	@Resource
	final private TimelineTemplateService timelinetemplateService;

	@GetMapping
	public ResponseEntity<TimelineTemplateDto> getTimelineTemplate(@QueryString SearchCondTemplate searchCond){

		return ResponseEntity
				.status(200)
				.body(Objects
						.requireNonNull(TimelineTemplateDto
								.convert(timelinetemplateService
										.selectTimelineTemplate(searchCond))));
	}

	@PostMapping("")
	public ResponseEntity<TimelineTemplateDto> saveTimelineTemplate(@RequestBody TimelineTemplateDto dto){

		return ResponseEntity
				.status(200)
				.body(Objects.requireNonNull(TimelineTemplateDto
						.convert(timelinetemplateService.saveTimelineTemplate(dto))));
	}
}
