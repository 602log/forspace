package kr.co.forspace.booking;

import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface BookingService {

	void insertBook(BookingDTO bookingDTO);
	
	List<BookingDTO> checkBook(@Param("roNo") int roNo, @Param("boDateStr") String boDateStr);
}
