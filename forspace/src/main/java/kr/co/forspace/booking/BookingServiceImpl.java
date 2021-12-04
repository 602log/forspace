package kr.co.forspace.booking;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import kr.co.forspace.mapper.BookingMapper;
import kr.co.forspace.paging.PagingDTO;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@RequiredArgsConstructor
@Log4j
public class BookingServiceImpl implements BookingService {

	private final BookingMapper bookingMapper;
	
	@Override
	public List<BookingDTO> findAllmyBooking(@Param("meEmail") String meEmail, @Param("pagingDTO") PagingDTO pagingDTO) {
		return bookingMapper.findAllmyBooking(meEmail, pagingDTO);
	}
	
	@Override
	public int mybookingCnt(String meEmail) {
		return bookingMapper.mybookingCnt(meEmail);
	}
	
	@Override
	public List<BookingDTO> todayMyBooking(@Param("meEmail") String meEmail, @Param("boDateStr") String boDateStr) {
		return bookingMapper.todayMyBooking(meEmail, boDateStr);
	}
	
	@Override
	public void cancelBooking(@Param("roNo") int roNo, @Param("meEmail") String meEmail, @Param("boDateStr") String boDateStr) {
		bookingMapper.cancelBooking(roNo, meEmail, boDateStr);
	}
	
	@Override
	public int countBooking(int scNo) {
		return bookingMapper.countBooking(scNo);
	}
	@Override
	public List<BookingDTO> findAll(@Param("scNo") int scNo, @Param("pagingDTO") PagingDTO pagingDTO) {
		return bookingMapper.findAll(scNo, pagingDTO);
	}
	
	@Override
	public List<BookingDTO> mybookingList(String meEmail) {
		return bookingMapper.mybookingList(meEmail);
	}
	
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
