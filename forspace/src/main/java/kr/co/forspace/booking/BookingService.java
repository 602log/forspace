package kr.co.forspace.booking;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.co.forspace.paging.PagingDTO;

public interface BookingService {

	void insertBook(BookingDTO bookingDTO);
	
	List<BookingDTO> checkBook(@Param("roNo") int roNo, @Param("boDateStr") String boDateStr);
	
	int findMyBook(@Param("roNo") int roNo, @Param("boDateStr") String boDateStr, @Param("meEmail") String meEmail);
	
	int findBookingTime(@Param("roNo") int roNo, @Param("boDateStr") String boDateStr, @Param("boTimeStr") String boTimeStr);
	
	List<BookingDTO> mybookingList(String meEmail);
	
	List<BookingDTO> findAll(@Param("scNo") int scNo, @Param("pagingDTO") PagingDTO pagingDTO);
	
	int countBooking(int scNo);
	
	void cancelBooking(@Param("roNo") int roNo, @Param("meEmail") String meEmail, @Param("boDateStr") String boDateStr);
	
	List<BookingDTO> todayMyBooking(@Param("meEmail") String meEmail, @Param("boDateStr") String boDateStr);
}
