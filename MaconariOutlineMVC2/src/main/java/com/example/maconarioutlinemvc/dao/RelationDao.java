package com.example.maconarioutlinemvc.dao;

import java.util.List;

import com.example.maconarioutlinemvc.domain.Relation;

public interface RelationDao {

	List<Relation> findAll() throws Exception;

	  Relation findById(Integer id) throws Exception;

	  List<Relation> findByRelation(Integer id) throws Exception;

	  List<Relation> findByAdmin(Integer id) throws Exception;

	  Relation findBySchedule(Integer id) throws Exception;

	  void insert(Relation relation) throws Exception;

	  void update(Relation relation) throws Exception;

	  void delete(Relation relation) throws Exception;

}
