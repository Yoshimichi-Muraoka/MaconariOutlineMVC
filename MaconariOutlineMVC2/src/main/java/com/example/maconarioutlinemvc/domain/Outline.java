package com.example.maconarioutlinemvc.domain;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;

public class Outline {
	private Integer id;
	@NotBlank
	@Length(min=0,max=200)
	private String goal;
	@Length(min=0,max=500)
	private String gutaitekigoal;
	@Length(min=0,max=800)
	private String kadai;
	@Length(min=0,max=800)
	private String kaiketsusaku;

	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getGoal() {
		return goal;
	}
	public void setGoal(String goal) {
		this.goal = goal;
	}
	public String getGutaitekigoal() {
		return gutaitekigoal;
	}
	public void setGutaitekigoal(String gutaitekigoal) {
		this.gutaitekigoal = gutaitekigoal;
	}
	public String getKadai() {
		return kadai;
	}
	public void setKadai(String kadai) {
		this.kadai = kadai;
	}
	public String getKaiketsusaku() {
		return kaiketsusaku;
	}
	public void setKaiketsusaku(String kaiketsusaku) {
		this.kaiketsusaku = kaiketsusaku;
	}



}
