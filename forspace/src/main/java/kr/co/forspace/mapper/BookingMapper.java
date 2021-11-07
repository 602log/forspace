package kr.co.forspace.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.co.forspace.booking.BookingDTO;

public interface BookingMapper {

	void insertBook(BookingDTO bookingDTO);
	
	List<BookingDTO> checkBook(@Param("roNo") int roNo, @Param("boDateStr") String boDateStr);
}
