package com.example.maconarioutlinemvc.domain;

import java.sql.Date;
import java.sql.Time;

public class Schedule {

	private Integer id;
	private String schedule;
	private String memo;
	private Date scheduledate;
	private Time starttime;
	private Time endtime;

	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}

	public String getSchedule() {
		return schedule;
	}
	public void setSchedule(String schedule) {
		this.schedule = schedule;
	}

	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}

	public Date getScheduledate() {
		return scheduledate;
	}
	public void setScheduledate(Date scheduledate) {
		this.scheduledate = scheduledate;
	}
	public Time getStarttime() {
		return starttime;
	}
	public void setStarttime(Time starttime) {
		this.starttime = starttime;
	}
	public Time getEndtime() {
		return endtime;
	}
	public void setEndtime(Time endtime) {
		this.endtime = endtime;
	}

}
