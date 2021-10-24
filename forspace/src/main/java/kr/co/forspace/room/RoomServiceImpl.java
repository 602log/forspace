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
	public RoomDTO roomDetail(String roName, int scNO) {
		return roomMapper.roomDetail(roName, scNO);
	}

	@Override
	public List<RoomDTO> selectFloor(@Param("roFloor") int roFloor, @Param("scNo") int scNo) {
		log.info(roFloor + scNo);
		return roomMapper.selectFloor(roFloor, scNo);
	}
}
