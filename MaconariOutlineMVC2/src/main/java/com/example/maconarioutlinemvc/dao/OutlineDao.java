package com.example.maconarioutlinemvc.dao;

import java.util.List;

import com.example.maconarioutlinemvc.domain.Outline;

public interface OutlineDao {

	 List<Outline> findAll() throws Exception;

	  Outline findById(Integer id) throws Exception;

	  void insert(Outline outline) throws Exception;

	  void update(Outline outline) throws Exception;

	  void delete(Outline outline) throws Exception;
}
