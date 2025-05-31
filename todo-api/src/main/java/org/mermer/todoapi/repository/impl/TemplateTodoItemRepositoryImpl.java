package org.mermer.todoapi.repository.impl;

import com.querydsl.core.types.Predicate;
import com.querydsl.core.types.dsl.BooleanExpression;
import com.querydsl.jpa.impl.JPAQueryFactory;
import jakarta.persistence.EntityManager;
import lombok.RequiredArgsConstructor;
import org.mermer.todoapi.dto.SearchCondItem;
import static org.mermer.todoapi.entity.QTemplateTodoItem.templateTodoItem;

import org.mermer.todoapi.entity.TemplateTodoItem;
import org.mermer.todoapi.repository.TemplateTodoItemRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;


@Repository
@RequiredArgsConstructor
@Transactional
public class TemplateTodoItemRepositoryImpl implements TemplateTodoItemRepository {

	private final JPAQueryFactory query;

	@Override
	public List<TemplateTodoItem> findAll(SearchCondItem searchCondItem) {
		query.select(templateTodoItem)
				.from(templateTodoItem)
				.where(
						//사용자별 템플릿 item을 조회하는 부분이기 때문에 사용자 id 와 템플릿 id는 필수조건
						templateIdEq(searchCondItem),
						userIdEq(searchCondItem)
				).fetch();
		return null;
	}

	@Override
	public Optional<TemplateTodoItem> findById(Long id) {
		return Optional.empty();
	}

	@Override
	public TemplateTodoItem save(TemplateTodoItem item) {
		return null;
	}

	private BooleanExpression templateIdEq(SearchCondItem searchCondItem) {
		String userIdEq = searchCondItem.getTimeUserId();
		return templateTodoItem.timeLineTemplate.timeUser.id.eq(userIdEq);
	}


	private static BooleanExpression userIdEq(SearchCondItem searchCondItem) {
		String userIdEq = searchCondItem.getTimeUserId();
		return templateTodoItem.timeLineTemplate.timeUser.id.eq(userIdEq);

	}
}
