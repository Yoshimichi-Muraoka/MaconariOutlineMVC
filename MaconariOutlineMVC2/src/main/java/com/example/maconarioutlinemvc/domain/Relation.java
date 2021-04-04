package com.example.maconarioutlinemvc.domain;

public class Relation {

	private Integer id;
	private Integer adminId;
	private Integer outlineId;
	private Integer scheduleId;

	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getAdminId() {
		return adminId;
	}
	public void setAdminId(Integer adminId) {
		this.adminId = adminId;
	}

	public Integer getOutlineId() {
		return outlineId;
	}

	public void setOutlineId(Integer outlineId) {
		this.outlineId = outlineId;
	}

	public Integer getScheduleId() {
		return scheduleId;
	}

	public void setScheduleId(Integer scheduleId) {
		this.scheduleId = scheduleId;
	}


}
