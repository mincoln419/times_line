package org.mermer.todoapi.service;


import jakarta.annotation.Resource;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mermer.todoapi.dto.SearchCondItem;
import org.mermer.todoapi.dto.TodoItemDto;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;

@SpringBootTest
class TodoItemServiceTest {

	@Resource
	private TodoItemService todoItemService;
	@Test
	@DisplayName("runner 기본값 세팅 테스트")
	public void selectTodoItemList_success(){
		List<TodoItemDto> list = todoItemService.selectTodoList(SearchCondItem.builder().build());
		assertThat(list).isNotEmpty();
		assertThat(list.get(0).getTitle()).isEqualTo("테스트제목1");
	}
}