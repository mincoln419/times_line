package org.mermer.todoapi.runner;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import jakarta.annotation.Resource;
import lombok.AllArgsConstructor;
import org.mermer.todoapi.entity.TodoItem;
import org.mermer.todoapi.repository.TodoItemRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Component;

import java.io.BufferedReader;
import java.io.FileReader;

@Component
@AllArgsConstructor
public class BasicDataGenerator implements CommandLineRunner{

	@Resource
	final private TodoItemRepository todoItemRepository;

	@Override
	public void run(String... args) throws Exception {

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
