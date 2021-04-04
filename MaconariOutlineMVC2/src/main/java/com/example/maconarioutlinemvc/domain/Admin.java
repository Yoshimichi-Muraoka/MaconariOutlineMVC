package com.example.maconarioutlinemvc.domain;

import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.NotBlank;

public class Admin {

	private Integer id;
	@NotBlank
	@Pattern(regexp="[a-z0-9]{4}")
	private String loginId;
	@NotBlank
	@Pattern(regexp="[a-z0-9]{4}")
	private String loginPass;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getLoginId() {
		return loginId;
	}

	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}

	public String getLoginPass() {
		return loginPass;
	}

	public void setLoginPass(String loginPass) {
		this.loginPass = loginPass;
	}

}
