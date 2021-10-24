package kr.co.forspace.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.co.forspace.room.RoomDTO;

public interface RoomMapper {

	List<RoomDTO> roomNoList(int scNo);

	List<RoomDTO> floorList(int scNo);

	RoomDTO roomDetail(String roName, int scNo);

	List<RoomDTO> selectFloor(@Param("roFloor") int roFloor, @Param("scNo") int scNo);
	
	int mySchoolNo(String meEmail);
}
