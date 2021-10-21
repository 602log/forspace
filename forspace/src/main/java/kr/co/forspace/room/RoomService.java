package kr.co.forspace.room;

import java.util.List;

public interface RoomService {

	List<RoomDTO> roomNoList(int scNo);
	List<RoomDTO> floorList(int scNo);
	RoomDTO roomDetail(String roName);
}
