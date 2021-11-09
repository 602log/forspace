package kr.co.forspace.booking;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Calendar;
import java.util.List;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequiredArgsConstructor
@Log4j
@RequestMapping("/booking")
public class BookingController {
	
	private final BookingService bookingService;
	
	@ResponseBody
	@PostMapping("/checkBook")
	public List<BookingDTO> checkBook(int roNo, String boTime) {
		//현재 날짜 string
		LocalDate now = LocalDate.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy/MM/dd");
		String boDateStr = now.format(formatter);
		//오늘 날짜의 해당 연습실 예약된 시간 찾기
		List<BookingDTO> dto = bookingService.checkBook(roNo, boDateStr);
	
		log.info(dto);
		return dto;
		
	}
	
	@ResponseBody
	@PostMapping("/insertbook")
	public void insertbook(int roNo, String boTime, int roLimit, int scNo, Authentication auth, RedirectAttributes rttr) {
		log.info(roNo+" "+boTime+" "+roLimit);
		String meEmail = auth.getName();
		
		String[] boTimeSplit = boTime.split(":");
		
		int firstBoTime = Integer.parseInt(boTimeSplit[0]);//시
		String sndBoTime = boTimeSplit[1];//분
		
		//Limit에 맞춰서 insert
		for(int i=0; i<roLimit; i++) {
			int bookingTime = firstBoTime+i;
			String boTimeStr = bookingTime+":"+sndBoTime;
			BookingDTO bookingDTO = BookingDTO.builder()
					.scNo(scNo)
					.meEmail(meEmail)
					.roNo(roNo)
					.boTime(boTimeStr)
					.build();
			bookingService.insertBook(bookingDTO);
		}
	}
}
