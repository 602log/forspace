package kr.co.forspace.room;

import java.time.LocalDate;
import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface RoomService {

	List<RoomDTO> roomNoList(int scNo);

	List<RoomDTO> floorList(int scNo);

	RoomDTO roomDetail(@Param("roNo") int roNo);

	List<RoomDTO> selectFloor(@Param("roFloor") int roFloor, @Param("scNo") int scNo);
	
	int getLike(int roNo);
	
	int getLikeInfo(@Param("roNo") int roNo, @Param("meEmail") String meEmail);
	
	void insertLike(@Param("roNo") int roNo, @Param("meEmail") String meEmail);
	void deleteLike(@Param("roNo") int roNo, @Param("meEmail") String meEmail);
	
	void updateLikeCnt(@Param("roNo") int roNo, @Param("myLike") int myLike);
	
	List<ItemDTO> searchItem(String itName);
	
	String maxRoomName(@Param("roFloor") int roFloor, @Param("scNo") int scNo);
	
	void insertRoom(RoomDTO roomDTO);
	
	void insertRoomItem(RoomItemDTO roomItemDTO);
	
	List<RoomItemDTO> selectRoomItem(int roNo);
	
	void deleteItem(int roNo);
	
	void updateRoom(RoomDTO roomDTO);
	
	void deleteRoom(int roNo);
}
