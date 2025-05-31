package org.mermer.todoapi.runner;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import jakarta.annotation.Resource;
import lombok.AllArgsConstructor;
import org.mermer.todoapi.entity.TemplateTodoItem;
import org.mermer.todoapi.entity.TodoItem;
import org.mermer.todoapi.repository.TemplateTodoItemRepository;
import org.mermer.todoapi.repository.TodoItemRepository;
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

	@Override
	public void run(String... args) throws Exception {

		todoItemGenerator();
		templateTodoItemGenerator();
	}

	private void templateTodoItemGenerator() throws IOException {
		ClassPathResource resource = new ClassPathResource("templateTodoItem.json");
		BufferedReader reader = new BufferedReader(new FileReader(resource.getFile()));

		StringBuffer sb = new StringBuffer();
		String str;
		while((str = reader.readLine()) != null){
			sb.append(str);
		}

		reader.close();

		ObjectMapper mapper = new ObjectMapper();
		mapper.registerModule(new JavaTimeModule());
		List<TemplateTodoItem> templateTodoItems = mapper.readValue(sb.toString(), new TypeReference<List<TemplateTodoItem>() {
		});
		templateTodoItems.stream().forEach(item -> {
			templateTodoItemRepository.save(item);
		});
	}

	private void todoItemGenerator() throws IOException {
		ClassPathResource resource = new ClassPathResource("todoItem.json");
		BufferedReader reader = new BufferedReader(new FileReader(resource.getFile()));

		StringBuffer sb = new StringBuffer();
		String str;
		while((str = reader.readLine()) != null){
			sb.append(str);
		}

		reader.close();

		ObjectMapper mapper = new ObjectMapper();
		mapper.registerModule(new JavaTimeModule());
		TodoItem todoItem = mapper.readValue(sb.toString(), TodoItem.class);
		todoItemRepository.save(todoItem);
		System.out.println(todoItem);
	}
}
