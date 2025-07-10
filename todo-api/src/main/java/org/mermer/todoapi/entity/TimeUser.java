package org.mermer.todoapi.entity;

import jakarta.persistence.*;
import lombok.*;
import org.mermer.todoapi.dto.TimeUserDto;
import org.mermer.todoapi.util.PasswordUtil;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Getter
@NoArgsConstructor
public class TimeUser {

	@Id
	@Column(name = "user_id")
	private String id;
	private String userName;
	private String email;
	private String password;
	private String ci;
	private String di;
	private String hp;
	private LocalDateTime signUpAt;

	@OneToMany(fetch = FetchType.LAZY)
	@JoinColumn(name = "sign_in_history_id")
	private List<SignInHistory> signInHistories = new ArrayList<>();

	private LocalDateTime lastSignAt;

	@Builder
	private TimeUser(String id, String userName, String email, String password, String hp, String ci, String di,
	             LocalDateTime signUpAt, List<SignInHistory> signInHistories, LocalDateTime lastSignAt) {
		this.id = id;
		this.userName = userName;
		this.email = email;
		this.password = password;
		this.hp = hp;
		this.ci = ci;
		this.di = di;
		this.signUpAt = signUpAt;
		this.signInHistories = signInHistories;
		this.lastSignAt = lastSignAt;
	}

	public static TimeUser registerTimeUser(TimeUserDto userDto){

		TimeUser user = TimeUser.builder()
				.id(userDto.getId())
				.userName(userDto.getUserName())
				.email(userDto.getEmail())
				.ci(userDto.getCi())
				.di(userDto.getDi())
				.hp(userDto.getHp())
				.build();
		user.setPassword(userDto.getPassword());
		user.signUpAt = LocalDateTime.now();
		return user;
	}

	public LocalDateTime updateLastSignAt(TimeUser user){
		LocalDateTime now = LocalDateTime.now();
		user.lastSignAt = now;
		return now;
	}

	private void setPassword(String rawPassword){
		this.password = PasswordUtil.encryptPassword(rawPassword);
	}

	public static boolean verifyPassword(String rawPassword, String encryptPassword){
		return PasswordUtil.verifyPassword(rawPassword, encryptPassword);
	}
}
