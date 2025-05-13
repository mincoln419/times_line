package org.mermer.todoapi.entity;

import jakarta.persistence.*;
import lombok.Getter;
import org.springframework.data.annotation.CreatedBy;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedBy;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDate;
import java.time.LocalDateTime;

@EntityListeners(AuditingEntityListener.class)
@MappedSuperclass
@Getter
public class BaseEntity {

	@CreatedDate
	@Column(updatable = false)
	@DateTimeFormat(pattern = "yyyy-MM-dd'T'hh:mm:ss")
	private LocalDateTime createAt;

	@LastModifiedDate
	@DateTimeFormat(pattern = "yyyy-MM-dd'T'hh:mm:ss")
	private LocalDateTime updateAt;

	@CreatedBy
	@ManyToOne
	@JoinColumn(updatable = false, name = "user_id")
	private TimeUser createdBy;

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
