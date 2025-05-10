package org.mermer.todoapi.config;

import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.core.MethodParameter;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.support.WebDataBinderFactory;
import org.springframework.web.context.request.NativeWebRequest;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.method.support.ModelAndViewContainer;

@Component
public class QueryStringArgumentResolver implements HandlerMethodArgumentResolver {

	private ObjectMapper mapper;

	@Override
	public boolean supportsParameter(MethodParameter parameter) {
		return parameter.getParameterAnnotation(QueryString.class) != null;
	}

	@Override
	public Object resolveArgument(MethodParameter parameter, ModelAndViewContainer mavContainer, NativeWebRequest webRequest, WebDataBinderFactory binderFactory) throws Exception {
		final HttpServletRequest request = (HttpServletRequest) webRequest.getNativeRequest();
		final String json = qs2json(request.getQueryString());
		final Object a = mapper.readValue(json, parameter.getParameterType());
		return a;
	}


	private String qs2json(String a) {
		String res = "{\"";

		for (int i = 0; i < a.length(); i++) {
			if (a.charAt(i) == '=') {
				res += "\"" + ":" + "\"";
			} else if (a.charAt(i) == '&') {
				res += "\"" + "," + "\"";
			} else {
				res += a.charAt(i);
			}
		}
		res += "\"" + "}";
		return res;
	}
}
