package org.mermer.todoapi.repository;

import groovy.util.logging.Slf4j;
import jakarta.annotation.Resource;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestInstance;
import org.mermer.todoapi.dto.TimeUserDto;
import org.mermer.todoapi.entity.TimeLineTemplate;
import org.mermer.todoapi.entity.TimeUser;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import static org.assertj.core.api.Assertions.*;

@SpringBootTest
@Slf4j
@TestInstance(TestInstance.Lifecycle.PER_CLASS)
class TimeLineTemplateRepositoryTest {

	@Resource
	private TimeLineTemplateRepository repository;

	@Resource
	private TimeUserRepository userRepository;

	private TimeLineTemplate template;
	private TimeUser timeUser;

	private static String userId = "stenly";

	@BeforeAll
	public void createTimelineTemplate(){
		userRepository.save(TimeUser.registerTimeUser(TimeUserDto.builder()
				.id(userId)
				.password("123456789")
				.userName("Stenly Cho")
				.hp("010-8013-9018")
				.email("mincoln419@naver.com")
				.cd(UUID.randomUUID().toString())
				.ci(UUID.randomUUID().toString())
				.build()));
		timeUser = userRepository.findById(userId)
				.orElseThrow(() -> new RuntimeException("User not found"));
	};
	@Test
	void findByUserId() {
		//given
		template = TimeLineTemplate.builder()
				.templateTitle("test title")
				.content("hello")
				.timeUser(timeUser)
				.items(new ArrayList<>())
				.build();
		TimeLineTemplate savedTemplate = repository.save(template);

		//when
		List<TimeLineTemplate> templates = repository.findByTimeUserId(timeUser.getId());

		//then
		assertThat(templates).isNotEmpty();
	}

	@Test
	void findAll_success(){
		//given
		template = TimeLineTemplate.builder()
				.templateTitle("test title")
				.content("hello")
				.timeUser(timeUser)
				.items(new ArrayList<>())
				.build();

		repository.save(template);

		//when
		List<TimeLineTemplate> templates = repository.findAll();

		//then
		assertThat(templates).isNotEmpty();
		assertThat(templates.size()).isEqualTo(1);
		System.out.println(templates.get(0).getTemplateTitle());
		assertThat(templates.get(0).timeUser.getId()).isEqualTo(userId);
	}
}