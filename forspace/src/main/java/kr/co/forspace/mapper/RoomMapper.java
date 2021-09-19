package kr.co.forspace.mapper;

import java.util.List;

import kr.co.forspace.room.RoomDTO;

public interface RoomMapper {

	List<RoomDTO> roomNoList(int scNo);
	
	List<RoomDTO> floorList(int scNo);
}
