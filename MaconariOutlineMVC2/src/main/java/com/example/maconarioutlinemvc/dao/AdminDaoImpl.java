package com.example.maconarioutlinemvc.dao;

import java.util.ArrayList;
import java.util.List;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;

import com.example.maconarioutlinemvc.domain.Admin;



@Repository
public class AdminDaoImpl implements AdminDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;

	@Autowired
	private NamedParameterJdbcTemplate npJdbcTemplate;

	@Override
	public List<Admin> findAll() throws Exception {
		List<Admin> adminList = new ArrayList<>();
		String sql = "SELECT * FROM macooutline.admin";
		adminList = jdbcTemplate.query(
				sql,
				new BeanPropertyRowMapper<Admin>(Admin.class));
		return adminList;
	}

	@Override
	public Admin findById(Integer id) throws Exception {
		String sql="select * from outline where id=?";
		List<Admin> list = jdbcTemplate.query(
				sql,
				new BeanPropertyRowMapper<Admin>(Admin.class),
				id);
		Admin admin = list.get(0);
		return admin;
	}

	@Override
	public Admin findByLoginId(String loginId) throws Exception {
		String sql="select * from admin where login_id=?";
		List<Admin> list = jdbcTemplate.query(
				sql,
				new BeanPropertyRowMapper<Admin>(Admin.class),
				loginId);
		Admin admin = list.get(0);
		return admin;
	}

	@Override
	public void insert(Admin admin) throws Exception {
		String sql = "INSERT INTO admin (id, login_id, login_pass)"
				+ " VALUES (null, :loginId, :loginPass)";
		BeanPropertySqlParameterSource param = new BeanPropertySqlParameterSource(admin);
		npJdbcTemplate.update(sql, param);

	}

	@Override
	public void update(Admin admin) throws Exception {
		// TODO 自動生成されたメソッド・スタブ

	}

	@Override
	public void delete(Admin admin) throws Exception {
		String sql = "delete from admin where id=:id";
		BeanPropertySqlParameterSource param = new BeanPropertySqlParameterSource(admin);
		npJdbcTemplate.update(sql, param);
	}

	@Override
	public Admin findByLoginIdAndLoginPass(String loginId, String loginPass)
			throws Exception {
		String sql = "SELECT * FROM admin WHERE login_id=?";
		List<Admin> admins = jdbcTemplate.query(
				sql,
				new BeanPropertyRowMapper<Admin>(Admin.class),
				loginId);
		if (admins.isEmpty()) {
			return null;
		} else {
			Admin admin = admins.get(0);
			if (BCrypt.checkpw(loginPass, admin.getLoginPass())) {
				return admin;
			} else {
				return null;
			}
		}
	}

}
