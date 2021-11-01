package kr.co.forspace.booking;

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
	public boolean insertBook(BookingDTO bookingDTO) {
		return bookingMapper.insertBook(bookingDTO);
	}

}
