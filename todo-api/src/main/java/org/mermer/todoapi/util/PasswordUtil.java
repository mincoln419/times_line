package org.mermer.todoapi.util;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class PasswordUtil {

	private static final BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();

	public static String encryptPassword(String rawPassword) {
		return encoder.encode(rawPassword);
	}

	public static boolean verifyPassword(String rawPassword, String encryptedPassword) {
		return encoder.matches(rawPassword, encryptedPassword);
	}
}
