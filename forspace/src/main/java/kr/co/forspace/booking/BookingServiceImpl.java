package kr.co.forspace.booking;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import kr.co.forspace.mapper.BookingMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@RequiredArgsConstructor
@Log4j
public class BookingServiceImpl implements BookingService {

	private final BookingMapper bookingMapper;
	
	@Override
	public int findBookingTime(@Param("roNo") int roNo, @Param("boDateStr") String boDateStr, @Param("boTimeStr") String boTimeStr) {
		return bookingMapper.findBookingTime(roNo, boDateStr, boTimeStr);
	}
	
	@Override
	public int findMyBook(@Param("roNo") int roNo, @Param("boDateStr") String boDateStr, @Param("meEmail") String meEmail) {
		return bookingMapper.findMyBook(roNo, boDateStr, meEmail);
	}
	
	@Override
	public void insertBook(BookingDTO bookingDTO) {
		bookingMapper.insertBook(bookingDTO);
	}

	@Override
	public List<BookingDTO> checkBook(@Param("roNo") int roNo, @Param("boDateStr") String boDateStr) {
		log.info("Service........");
		log.info(roNo+ " "+ boDateStr);
		return bookingMapper.checkBook(roNo, boDateStr);
	}
}
