package com.example.maconarioutlinemvc.dao;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;

import com.example.maconarioutlinemvc.domain.Schedule;

@Repository
public class ScheduleDaoImpl implements ScheduleDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;

	@Autowired
	private NamedParameterJdbcTemplate npJdbcTemplate;

	@Override
	public List<Schedule> findAll() throws Exception {
		List<Schedule> scheduleList = new ArrayList<>();
		String sql = "SELECT * FROM macooutline.schedule";
		scheduleList = jdbcTemplate.query(
				sql,
				new BeanPropertyRowMapper<Schedule>(Schedule.class));
		return scheduleList;
	}

	@Override
	public Schedule findById(Integer id) throws Exception {
		String sql="select * from schedule where id=?";
		List<Schedule> list = jdbcTemplate.query(
				sql,
				new BeanPropertyRowMapper<Schedule>(Schedule.class),
				id);
		Schedule schedule = list.get(0);
		return schedule;
	}

	@Override
	public void insert(Schedule schedule) throws Exception {
		String sql = "INSERT INTO schedule (id, schedule, memo, scheduledate, starttime, endtime)"
				+ " VALUES (null, :schedule, :memo, :scheduledate, :starttime, :endtime)";
		BeanPropertySqlParameterSource param = new BeanPropertySqlParameterSource(schedule);
		npJdbcTemplate.update(sql, param);

	}

	@Override
	public void update(Schedule schedule) throws Exception {
		String sql ="update schedule set"
				+ " schedule=:schedule,memo=:memo,scheduledate=:scheduledate,starttime=:starttime,endtime=:endtime"
				+ " where id=:id";
		BeanPropertySqlParameterSource param = new BeanPropertySqlParameterSource(schedule);
		npJdbcTemplate.update(sql, param);
	}

	@Override
	public void delete(Schedule schedule) throws Exception {
		String sql = "delete from schedule where id=:id";
		BeanPropertySqlParameterSource param = new BeanPropertySqlParameterSource(schedule);
		npJdbcTemplate.update(sql, param);

	}

}
