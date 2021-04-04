package com.example.maconarioutlinemvc.dao;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;

import com.example.maconarioutlinemvc.domain.Outline;

@Repository
public class OutlineDaoImpl implements OutlineDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;

	@Autowired
	private NamedParameterJdbcTemplate npJdbcTemplate;

	@Override
	public List<Outline> findAll() throws Exception {
		List<Outline> outlineList = new ArrayList<>();
		String sql = "SELECT * FROM macooutline.outline";
		outlineList = jdbcTemplate.query(
				sql,
				new BeanPropertyRowMapper<Outline>(Outline.class));
		return outlineList;
	}

	@Override
	public Outline findById(Integer id) throws Exception {
		String sql="select * from outline where id=?";
		List<Outline> list = jdbcTemplate.query(
				sql,
				new BeanPropertyRowMapper<Outline>(Outline.class),
				id);
		Outline outline = list.get(0);
		return outline;
	}

	@Override
	public void insert(Outline outline) throws Exception {
		String sql = "INSERT INTO outline (id, goal, gutaitekigoal, kadai, kaiketsusaku)"
				+ " VALUES (null, :goal, :gutaitekigoal, :kadai, :kaiketsusaku)";
		BeanPropertySqlParameterSource param = new BeanPropertySqlParameterSource(outline);
		npJdbcTemplate.update(sql, param);

	}

	@Override
	public void update(Outline outline) throws Exception {
		String sql ="update outline set"
				+ " goal=:goal,gutaitekigoal=:gutaitekigoal,kadai=:kadai,kaiketsusaku=:kaiketsusaku"
				+ " where id=:id";
		BeanPropertySqlParameterSource param = new BeanPropertySqlParameterSource(outline);
		npJdbcTemplate.update(sql, param);
	}

	@Override
	public void delete(Outline outline) throws Exception {
		String sql = "delete from outline where id=:id";
		BeanPropertySqlParameterSource param = new BeanPropertySqlParameterSource(outline);
		npJdbcTemplate.update(sql, param);

	}

}
