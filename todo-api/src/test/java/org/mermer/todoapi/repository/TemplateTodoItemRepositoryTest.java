package org.mermer.todoapi.repository;

import jakarta.annotation.Resource;
import net.datafaker.Faker;
import org.junit.jupiter.api.Test;
import org.mermer.todoapi.entity.TemplateTodoItem;
import org.mermer.todoapi.entity.TimeLineTemplate;
import org.mermer.todoapi.entity.TimeUser;
import org.mermer.todoapi.entity.enumeration.ContentType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.ArrayList;

import static org.assertj.core.api.Assertions.*;
@SpringBootTest
class TemplateTodoItemRepositoryTest {


	@Autowired
	private TimeUser timeUser;

	@Resource
	private TemplateTodoItemRepository templateTodoItemRepository;

	@Resource
	private TimeLineTemplateRepository timeLineTemplateRepository;

	private static Faker faker = new Faker();

	@Test
	void save_template_todoItems_success(){

		//given
		ContentType contentType = getContentType();
		String title = getTitle();
		String content = getContent();
		TemplateTodoItem item = TemplateTodoItem.builder()
				.title(title)
				.contents(content)
				.contentType(contentType)
				.timeLineTemplate(getTimeLineTemplate())
				.build();

		//when
		TemplateTodoItem savedItem = templateTodoItemRepository.save(item);
		TemplateTodoItem selectedItem = templateTodoItemRepository.findById(savedItem.getId()).orElseGet(() -> TemplateTodoItem.builder().build());

		//then
		assertThat(selectedItem).isNotNull();
		assertThat(selectedItem.getContents()).isEqualTo(content);
		assertThat(selectedItem.getTitle()).isEqualTo(title);
		assertThat(selectedItem.getContents()).isEqualTo(content);
	}

	private String getTitle() {
		return faker.book().title();
	}

	private String getContent(){
		return faker.book().author();
	}

	private TimeLineTemplate getTimeLineTemplate() {
		TimeLineTemplate template = TimeLineTemplate.builder()
				.templateTitle("test title")
				.content("hello")
				.timeUser(timeUser)
				.items(new ArrayList<>())
				.build();

		return timeLineTemplateRepository.save(template);
	}

	private ContentType getContentType(){
		return ContentType.values()[(int) (Math.random() * ContentType.values().length)];
	}

}