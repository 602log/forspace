package kr.co.forspace.room;

import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface RoomService {

	List<RoomDTO> roomNoList(int scNo);

	List<RoomDTO> floorList(int scNo);

	RoomDTO roomDetail(String roName, int scNo);

	List<RoomDTO> selectFloor(@Param("roFloor") int roFloor, @Param("scNo") int scNo);
	
	
}
