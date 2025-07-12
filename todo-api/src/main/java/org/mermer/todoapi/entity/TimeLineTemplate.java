package org.mermer.todoapi.entity;

import jakarta.persistence.*;
import lombok.*;
import org.mermer.todoapi.repository.TimeUserRepository;

import java.util.ArrayList;
import java.util.List;
import java.util.function.Supplier;

@Entity
@Getter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class TimeLineTemplate extends BaseEntity {

	@Id @GeneratedValue(strategy = GenerationType.SEQUENCE)
	@Column(name="timeline_template_id")
	public Long id;

	@ManyToOne(fetch = FetchType.LAZY, cascade = CascadeType.MERGE)
	@JoinColumn(name = "user_id", insertable=false, updatable=false)
	public TimeUser timeUser;

	public String templateTitle;

	public String userId;

	// User 객체를 설정하면 자동으로 userId도 설정
	public void setUser(TimeUser user) {
		this.timeUser = user;
		if (user != null) {
			this.userId = user.getId();
		}
	}

	// userId로 User 객체를 조회해야 할 때 사용할 수 있는 메서드
	public TimeUser getUser(TimeUserRepository userRepository) {
		if (this.timeUser == null && this.userId != null) {
			this.timeUser = userRepository.findById(this.userId).orElse(null);
		}
		return this.timeUser;
	}

	@Transient
	public List<TemplateTodoItem> items = new ArrayList<>();


	public static Supplier<? extends TimeLineTemplate> empty() {
		return () -> TimeLineTemplate.builder().build();
	}
}
