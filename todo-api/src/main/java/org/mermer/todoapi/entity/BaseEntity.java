package org.mermer.todoapi.entity;

import jakarta.persistence.*;
import lombok.Getter;
import org.springframework.data.annotation.CreatedBy;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedBy;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import java.time.LocalDateTime;

@EntityListeners(AuditingEntityListener.class)
@MappedSuperclass
@Getter
public class BaseEntity {

	@CreatedDate
	@Column(updatable = false)
	private LocalDateTime createAt;

	@LastModifiedDate
	private LocalDateTime updateAt;

	@CreatedBy
	@ManyToOne
	@JoinColumn(updatable = false, name = "user_id")
	private TimeUser createdBy;

	@LastModifiedBy
	@ManyToOne
	@JoinColumn(name = "user_id")
	private TimeUser updatedBy;


	@PrePersist
	public void prePersist() {
		LocalDateTime now = LocalDateTime.now();
		createAt = now;
		updateAt = now;
	}

	@PreUpdate
	public void preUpdate(){
		createAt = LocalDateTime.now();
	}

}
