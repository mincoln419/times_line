package org.mermer.todoapi.repository;

import jakarta.annotation.Resource;
import net.datafaker.Faker;
import org.junit.jupiter.api.Test;
import org.mermer.todoapi.entity.TimeLineHabit;
import org.mermer.todoapi.entity.TimeUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import static org.assertj.core.api.Assertions.*;

@SpringBootTest
class TimeLineHabitRepositoryTest {

	@Autowired
	private TimeUser timeUser;

	@Resource
	private TimeLineHabitRepository timeLineHabitRepository;

	private static Faker faker = new Faker();

	@Test
	void habit_save_success(){
		String title = getTitle();
		TimeLineHabit timeLineHabit = TimeLineHabit.builder()
				.contents(title)
				.build();
		TimeLineHabit savedHabit = timeLineHabitRepository.save(timeLineHabit);
		TimeLineHabit result = timeLineHabitRepository.findById(savedHabit.getId()).orElseGet(() -> TimeLineHabit.builder().build());

		assertThat(result).isNotNull();
		assertThat(result.getContents()).isEqualTo(title);
	}

	private String getTitle() {
		return faker.book().title();
	}

}