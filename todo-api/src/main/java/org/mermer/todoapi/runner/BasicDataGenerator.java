package org.mermer.todoapi.runner;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import jakarta.annotation.Resource;
import lombok.AllArgsConstructor;
import org.mermer.todoapi.dto.TemplateTodoItemDto;
import org.mermer.todoapi.dto.TimeUserDto;
import org.mermer.todoapi.dto.TimelineTemplateDto;
import org.mermer.todoapi.entity.TemplateTodoItem;
import org.mermer.todoapi.entity.TimeLineTemplate;
import org.mermer.todoapi.entity.TodoItem;
import org.mermer.todoapi.repository.TemplateTodoItemRepository;
import org.mermer.todoapi.repository.TimeLineTemplateRepository;
import org.mermer.todoapi.repository.TodoItemRepository;
import org.mermer.todoapi.service.TimeUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Component;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.List;

@Component
@AllArgsConstructor
public class BasicDataGenerator implements CommandLineRunner{

	@Resource
	final private TodoItemRepository todoItemRepository;

	@Resource
	final private TemplateTodoItemRepository templateTodoItemRepository;

	@Resource
	final private TimeLineTemplateRepository timeLineTemplateRepository;

	@Resource
	final private TimeUserService timeUserService;

	@Autowired
	final private ObjectMapper mapper;


	@Override
	public void run(String... args) throws Exception {

		timeUserGenerator();
		todoItemGenerator();
		timelineTemplateGenerator();
		templateTodoItemGenerator();
	}

	private void timeUserGenerator() throws IOException {
		TimeUserDto user = mapper.readValue(parsingPayload("timeUser.json"), TimeUserDto.class);
		timeUserService.saveTimeUser(user);
		System.out.println(user);
	}

	private void timelineTemplateGenerator() throws IOException {
		List<TimelineTemplateDto> templates = mapper.readValue(parsingPayload("timelineTemplate.json"), new TypeReference<List<TimelineTemplateDto>>() {
		});
		templates.forEach(dto -> {

			TimeLineTemplate template = TimeLineTemplate.builder()
					.templateTitle(dto.templateTitle)
					.timeUser(timeUserService.selectTimeUser(dto.getTimeUserId()))
					.build();
			//todo tmmplatetodoitemId 를 받아서 tmplate 객체로 변경해서 등록하는 프로세스로 수정 필요
			timeLineTemplateRepository.save(template);
		});
	}

	private void templateTodoItemGenerator() throws IOException {
		List<TemplateTodoItemDto> templateTodoItems = mapper.readValue(parsingPayload("templateTodoItem.json"), new TypeReference<List<TemplateTodoItemDto>>() {
		});
		templateTodoItems.forEach(dto -> {

			//todo tmmplatetodoitemId 를 받아서 tmplate 객체로 변경해서 등록하는 프로세스로 수정 필요
			TemplateTodoItem item = TemplateTodoItem.builder()
					.title(dto.getTitle())
					.contentType(dto.getContentType())
					.timeLineTemplate(timeLineTemplateRepository.findById(dto.getTimeLineTemplateId()).orElse(new TimeLineTemplate()))
					.build();

			templateTodoItemRepository.save(item);
		});
	}

	private void todoItemGenerator() throws IOException {

		TodoItem todoItem = mapper.readValue(parsingPayload("todoItem.json"), TodoItem.class);
		todoItemRepository.save(todoItem);
		System.out.println(todoItem);
	}

	private String parsingPayload(String fileLocation) throws IOException {
		ClassPathResource resource = new ClassPathResource(fileLocation);
		BufferedReader reader = new BufferedReader(new FileReader(resource.getFile()));

		StringBuffer sb = new StringBuffer();
		String str;
		while((str = reader.readLine()) != null){
			sb.append(str);
		}

		reader.close();
		mapper.registerModule(new JavaTimeModule());
		return sb.toString();

	}
}
