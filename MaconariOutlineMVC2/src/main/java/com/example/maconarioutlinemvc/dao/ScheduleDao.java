package com.example.maconarioutlinemvc.dao;

import java.util.List;

import com.example.maconarioutlinemvc.domain.Schedule;

public interface ScheduleDao {

	List<Schedule> findAll() throws Exception;

	  Schedule findById(Integer id) throws Exception;

	  void insert(Schedule schedule) throws Exception;

	  void update(Schedule schedule) throws Exception;

	  void delete(Schedule schedule) throws Exception;
}
