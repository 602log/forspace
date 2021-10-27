package kr.co.forspace.room;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import kr.co.forspace.mapper.RoomMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@RequiredArgsConstructor
@Log4j
public class RoomServiceImpl implements RoomService {

	private final RoomMapper roomMapper;

	@Override
	public List<RoomDTO> roomNoList(int scNo) {
		return roomMapper.roomNoList(scNo);
	}

	@Override
	public List<RoomDTO> floorList(int scNo) {
		return roomMapper.floorList(scNo);
	}

	@Override
	public RoomDTO roomDetail(@Param("roNo") int roNo) {
		return roomMapper.roomDetail(roNo);
	}

	@Override
	public List<RoomDTO> selectFloor(@Param("roFloor") int roFloor, @Param("scNo") int scNo) {
		log.info("선택한 층"+roFloor + "학교번호"+scNo);
		return roomMapper.selectFloor(roFloor, scNo);
	}
	
	@Override
	public int getLike(int roNo) {
		return roomMapper.getLike(roNo);
	}
	
	@Override
	public int getLikeInfo(@Param("roNo") int roNo, @Param("meEmail") String meEmail) {
		return roomMapper.getLikeInfo(roNo, meEmail);
	}
	
	@Override
	public void insertLike(int roNo, String meEmail) {
		roomMapper.insertLike(roNo, meEmail);
		
	}
	@Override
	public void deleteLike(int roNo, String meEmail) {
		roomMapper.deleteLike(roNo, meEmail);
	}
	
	@Override
	public void updateLikeCnt(@Param("roNo") int roNo, @Param("myLike") int myLike) {
		roomMapper.updateLikeCnt(roNo, myLike);
	}
}
