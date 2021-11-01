package kr.co.forspace.booking;

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
	@PostMapping("/insertbook")
	public String insertbook(int roNo, String boStart, int roLimit, int scNo, Authentication auth, RedirectAttributes rttr) {
		log.info(roNo+" "+boStart+" "+roLimit);
		String meEmail = auth.getName();
		
		String[] boStartTime = boStart.split(":");
		
		int firstBoStart = Integer.parseInt(boStartTime[0]);
		String sndBoStart = boStartTime[1];
		
		int boEndTime = firstBoStart+roLimit;
		String boEnd = boEndTime+":"+sndBoStart;
		//insert
		BookingDTO bookingDTO = BookingDTO.builder()
								.scNo(scNo)
								.meEmail(meEmail)
								.roNo(roNo)
								.boStart(boStart)
								.boEnd(boEnd)
								.build();
		
		boolean boResult = bookingService.insertBook(bookingDTO);
		if(boResult == true) {
			return "success";
		}else {
			return "false";
		}
	}
}
