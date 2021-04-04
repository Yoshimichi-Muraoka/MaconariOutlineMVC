package com.example.maconarioutlinemvc.dao;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;

import com.example.maconarioutlinemvc.domain.Relation;

@Repository
public class RelationDaoImpl implements RelationDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;

	@Autowired
	private NamedParameterJdbcTemplate npJdbcTemplate;

	@Override
	public List<Relation> findAll() throws Exception {
		List<Relation> relationList = new ArrayList<>();
		String sql = "SELECT * FROM macooutline.relation";
		relationList = jdbcTemplate.query(
				sql,
				new BeanPropertyRowMapper<Relation>(Relation.class));
		return relationList;
	}

	@Override
	public Relation findById(Integer id) throws Exception {
		String sql="select * from relation where id=?";
		List<Relation> list = jdbcTemplate.query(
				sql,
				new BeanPropertyRowMapper<Relation>(Relation.class),
				id);
		Relation relation = list.get(0);
		return relation;
	}

	@Override
	public List<Relation> findByRelation(Integer id) throws Exception {
		String sql="select * from macooutline.relation where outline_id=?";
		List<Relation> relationList = jdbcTemplate.query(
				sql,
				new BeanPropertyRowMapper<Relation>(Relation.class),
				id);
		return relationList;
	}

	@Override
	public List<Relation> findByAdmin(Integer id) throws Exception {
		String sql="select * from macooutline.relation where admin_id=?";
		List<Relation> relationList = jdbcTemplate.query(
				sql,
				new BeanPropertyRowMapper<Relation>(Relation.class),
				id);
		return relationList;
	}

	@Override
	public Relation findBySchedule(Integer id) throws Exception {
		String sql="select * from relation where schedule_id=?";
		List<Relation> list = jdbcTemplate.query(
				sql,
				new BeanPropertyRowMapper<Relation>(Relation.class),
				id);
		Relation relation = list.get(0);
		return relation;
	}

	@Override
	public void insert(Relation relation) throws Exception {
		String sql = "INSERT INTO relation (id, admin_id, outline_id, schedule_id) VALUES (null, :adminId, :outlineId, :scheduleId);";
		BeanPropertySqlParameterSource param = new BeanPropertySqlParameterSource(relation);
		npJdbcTemplate.update(sql, param);

	}

	@Override
	public void update(Relation relation) throws Exception {
		String sql ="update relation set"
				+ " admin_id=:adminId, outline_id=:outlineId, schedule_id=:scheduleId"
				+ " where id=:id";
		BeanPropertySqlParameterSource param = new BeanPropertySqlParameterSource(relation);
		npJdbcTemplate.update(sql, param);
	}

	@Override
	public void delete(Relation relation) throws Exception {
		String sql = "delete from relation where id=:id";
		BeanPropertySqlParameterSource param = new BeanPropertySqlParameterSource(relation);
		npJdbcTemplate.update(sql, param);
	}

}
