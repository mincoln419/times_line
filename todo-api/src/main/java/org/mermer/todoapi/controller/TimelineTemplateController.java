package org.mermer.todoapi.controller;

import jakarta.annotation.Resource;
import lombok.RequiredArgsConstructor;
import org.mermer.todoapi.config.QueryString;
import org.mermer.todoapi.dto.SearchCondTemplate;
import org.mermer.todoapi.dto.TimelineTemplateDto;
import org.mermer.todoapi.service.TimelineTemplateService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
public class TimelineTemplateController {

	@Resource
	final private TimelineTemplateService timelinetemplateService;
	public ResponseEntity<TimelineTemplateDto> getTimelineTemplate(@QueryString SearchCondTemplate searchCond){

		return ResponseEntity.status(200).body(timelinetemplateService.selectTimelineTemplate(searchCond));
	}
}
