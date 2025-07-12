package org.mermer.todoapi.entity;

import jakarta.persistence.*;
import lombok.*;
import org.mermer.todoapi.entity.enumeration.ContentType;
import org.mermer.todoapi.repository.TimeLineTemplateRepository;
import org.mermer.todoapi.repository.TimeUserRepository;

import java.time.LocalDateTime;
import java.util.function.Supplier;

@Getter
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Entity
@ToString
public class TemplateTodoItem extends BaseEntity {

	@Id @GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "template_todo_item_id")
	private Long id;


	private Long timelineTemplateId;

	@Transient
	private TimeLineTemplate timeLineTemplate;

	public void setTimeLineTemplate(TimeLineTemplate template) {
		this.timeLineTemplate = template;
		if (template != null) {
			this.timelineTemplateId = template.getId();
		}
	}

	// userId로 User 객체를 조회해야 할 때 사용할 수 있는 메서드
	public TimeLineTemplate getTimeLineTemplate(TimeLineTemplateRepository timeLineTemplateRepository) {
		if (this.timeLineTemplate == null && this.timelineTemplateId != null) {
			this.timeLineTemplate = timeLineTemplateRepository.findById(this.timelineTemplateId).orElse(null);
		}
		return this.timeLineTemplate;
	}

	private String title;

	private LocalDateTime time;

	@Enumerated(EnumType.STRING)
	private ContentType contentType;

}
