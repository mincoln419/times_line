package org.mermer.todoapi.entity;

import jakarta.persistence.*;
import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(callSuper = true)
@Entity
@Data
public class TimeLineTemplate extends BaseEntity {

	@Id @GeneratedValue(strategy = GenerationType.SEQUENCE)
	public Long id;

	public String content;
	@Enumerated(EnumType.STRING)
	public ContentType contentType;

	@ManyToOne(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
	@JoinColumn(name = "type_id")
	public TypeRegister typeRegister;


}
