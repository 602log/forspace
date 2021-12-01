package kr.co.forspace.booking;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.ZoneOffset;
import java.time.format.DateTimeFormatter;
import java.util.Calendar;
import java.util.Collection;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.forspace.caution.CautionController;
import kr.co.forspace.caution.CautionService;
import kr.co.forspace.member.MemberService;
import kr.co.forspace.paging.PagingDTO;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequiredArgsConstructor
@Log4j
@RequestMapping("/booking")
public class BookingController {
	
	private final BookingService bookingService;
	private final MemberService memberService;
	private final CautionService cautionService;
	
	@ResponseBody
	@PostMapping("/todayBooking")
	public List<BookingDTO> todayBooking(String meEmail, Authentication auth) {
		log.info("todayBooking.................................");
		log.info(meEmail);
		
		Date now = new Date();
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy/MM/dd");
		String boDateStr = simpleDateFormat.format(now);
		List<BookingDTO> list = bookingService.todayMyBooking(meEmail, boDateStr);

		log.info(list.get(0).getRoNo());
		return list;
	}
	
	@ResponseBody
	@PostMapping("/cancelBooking")
	public String cancelBooking(int roNo, String meEmail) {
		log.info("cancelBooking.....................................");
		log.info("roNo: "+roNo + " meEmail: "+meEmail);
		Date now = new Date();
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy/MM/dd");
		String boDateStr = simpleDateFormat.format(now);
		bookingService.cancelBooking(roNo, meEmail, boDateStr);
		
		return "success";
	}
	
	@ResponseBody
	@PostMapping("/getMyBooking")
	public List<BookingDTO> getMyBooking(String meEmail) {
		log.info("getMyBooking...................................");
		List<BookingDTO> list = bookingService.mybookingList(meEmail);
		for(int i=0; i<=list.size()-1; i++) {
			
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd"); 
			String strNowDate = simpleDateFormat.format(list.get(i).getBoDate());

			list.get(i).setBoDateStr(strNowDate);
		}
		log.info(list);		

		return list;
	}
	
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@GetMapping("/bookingAdminList")
	public void bookingAdminList(Authentication auth, Model model, @Param("pagingDTO") PagingDTO pagingDTO, 
			@RequestParam(value="nowPage", required=false) String nowPage,
			@RequestParam(value="cntPerPage", required=false) String cntPerPage) {
		log.info("bookingAdminList...................................");
		
		String meEmail = auth.getName();
		int scNo = memberService.mySchoolNo(meEmail);
		
		int total = bookingService.countBooking(scNo);
		log.info("total: "+total);
		if(nowPage == null && cntPerPage == null) {
			nowPage = "1";
			cntPerPage = "5";
		}else if(nowPage == null) {
			nowPage = "1";
		}else if(cntPerPage == null) {
			cntPerPage = "5";
		}
		
		pagingDTO = new PagingDTO(total, Integer.valueOf(nowPage), Integer.valueOf(cntPerPage));
		List<BookingDTO> list = bookingService.findAll(scNo, pagingDTO);
		
		Date now = new Date();
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy/MM/dd");
		String nowStr = simpleDateFormat.format(now);
		nowStr.trim();
		
		for(int i=0; i<list.size(); i++) {
			
			String dateStr = simpleDateFormat.format(list.get(i).getBoDate());
			dateStr.trim();
			list.get(i).setBoDateStr(dateStr);

			if(nowStr.equals(dateStr)) {//예약이 오늘인 경우
				//현재 시간 구하기
				LocalTime nowTime = LocalTime.now();
				int hour = nowTime.getHour();
				log.info("hour:"+hour);
				
				//예약 시간 구하기
				String[] boTimeSplit = list.get(i).getBoTime().split(":");
				int firstBoTime = Integer.parseInt(boTimeSplit[0]);
				
				if(hour > firstBoTime || hour == firstBoTime) { //예약 시간이 지난 경우
					list.get(i).setRefused("기한만료");
				}else if(hour < firstBoTime) {//예약시간이 아직 지나지 않은 경우
					list.get(i).setRefused("취소");
				}
			
			}else if(nowStr != dateStr) {//예약이 오늘이 아닌 경우
				list.get(i).setRefused("기한만료");
			}
		}//end of for
				
		log.info(list);
		model.addAttribute("list", list);
		model.addAttribute("paging", pagingDTO);
	}
	
	
	@PreAuthorize("hasRole('ROLE_USER')")
	@GetMapping("/bookingList")
	public void bookingList() {
		log.info("bookingList...................................");
				
	}
	
	
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
	public String insertbook(int roNo, String boTime, int roLimit, int scNo, Authentication auth, Model model, RedirectAttributes rttr) {
		log.info(roNo+" "+boTime+" "+roLimit);
		String meEmail = auth.getName();
		
		CautionController cont = new CautionController(cautionService);
		String str = cont.selMyCaution(meEmail);
		if(str == "success") {
			
			String[] boTimeSplit = boTime.split(":");
			
			int firstBoTime = Integer.parseInt(boTimeSplit[0]);//시
			String sndBoTime = boTimeSplit[1];//분
			
			LocalDate now = LocalDate.now();
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy/MM/dd");
			String boDateStr = now.format(formatter);
			
			//내 예약 찾기
			int cnt = bookingService.findMyBook(roNo, boDateStr, meEmail);
			if(cnt > 0) {//오늘 예약 기록이 있으면
				//rttr.addFlashAttribute("msg", "이미 예약하셨습니다.");
				//model.addAttribute("msg", "이미 예약하셨습니다.");
				return "already";
			}else {//예약한 적이 없으면
				
				//Limit에 맞춰서 insert
				for(int i=0; i<roLimit; i++) {
					int bookingTime = firstBoTime+i;
					String boTimeStr = bookingTime+":"+sndBoTime;
					
					//예약한 시간 찾기
					int check = bookingService.findBookingTime(roNo, boDateStr, boTimeStr);
					if(check == 0) {//예약시간이 없으면
						BookingDTO bookingDTO = BookingDTO.builder()
								.scNo(scNo)
								.meEmail(meEmail)
								.roNo(roNo)
								.boTime(boTimeStr)
								.build();
						
						//예약하기
						bookingService.insertBook(bookingDTO);
						//rttr.addFlashAttribute("msg", "예약되었습니다.");
						//model.addAttribute("msg", "예약되었습니다.");
						
					}//end of if
				}//end of for
				return "success";
			}//end of if
		}else {
			return "dont";
		}

	}
}
