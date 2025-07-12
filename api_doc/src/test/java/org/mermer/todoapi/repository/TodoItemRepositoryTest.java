package org.mermer.todoapi.repository;

import jakarta.annotation.Resource;
import net.datafaker.Faker;
import org.junit.jupiter.api.Test;
import org.mermer.todoapi.dto.SearchCondItem;
import org.mermer.todoapi.entity.DailyTimeline;
import org.mermer.todoapi.entity.TimeUser;
import org.mermer.todoapi.entity.TodoItem;
import org.mermer.todoapi.entity.enumeration.ContentType;
import org.mermer.todoapi.entity.enumeration.TaskStatus;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.time.LocalDate;
import java.util.List;

import static org.assertj.core.api.Assertions.*;

@SpringBootTest
class TodoItemRepositoryTest {

	@Autowired
	private TimeUser timeUser;

	@Resource
	private TodoItemRepository todoItemRepository;

	@Resource
	private DailyTimelineRepository timelineRepository;


	private static Faker faker = new Faker();
	@Test
	void save_timelineUser_success(){
		//given
		DailyTimeline dailyTimeline = timelineRepository.save(getDailyTimeline());

		//when
		todoItemRepository.save(getTodoItem(dailyTimeline));
		SearchCondItem cond = SearchCondItem.builder()
				.timeUserId(timeUser.getId())
				.build();
		//then
		List<TodoItem> items = todoItemRepository.findAll( cond);
		assertThat(items).isNotEmpty();
		assertThat(items.get(0)).isNotNull();
	}

	private DailyTimeline getDailyTimeline() {
		return DailyTimeline.builder()
				.timelineDate(LocalDate.now().minusDays(faker.number().numberBetween(1, 30))) // 최근 30일 내 날짜 랜덤 생성
				.timeUser(timeUser) // 연관된 사용자 설정
				.build();
	}

	private TodoItem getTodoItem(DailyTimeline dailyTimeline) {
		return TodoItem.builder()
				.dailyTimeline(dailyTimeline)
				.title(faker.book().title()) // 랜덤한 책 제목 활용
				.contents(faker.lorem().sentence()) // 랜덤한 문장 생성
				.contentType(ContentType.values()[(int) (Math.random() * ContentType.values().length)])
				.taskStatus(TaskStatus.values()[(int) (Math.random() * TaskStatus.values().length)])
				.build();
	}
}