package kr.co.forspace.booking;

import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface BookingService {

	void insertBook(BookingDTO bookingDTO);
	
	List<BookingDTO> checkBook(@Param("roNo") int roNo, @Param("boDateStr") String boDateStr);
	
	int findMyBook(@Param("roNo") int roNo, @Param("boDateStr") String boDateStr, @Param("meEmail") String meEmail);
	
	int findBookingTime(@Param("roNo") int roNo, @Param("boDateStr") String boDateStr, @Param("boTimeStr") String boTimeStr);
	
	List<BookingDTO> mybookingList(String meEmail);
}
