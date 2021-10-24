package kr.co.forspace.room;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.forspace.member.MemberService;
import lombok.RequiredArgsConstructor;
import lombok.extern.java.Log;
import lombok.extern.log4j.Log4j;

@Controller
@RequiredArgsConstructor
@Log4j
@RequestMapping("/room")
public class RoomController {

	private final RoomService roomService;
	private final MemberService memberService;

	@GetMapping("/addroom")
	public void addroom() {

	}

//	@PreAuthorize("isAuthenticated()")
	@GetMapping("/roomDetail")
	public String roomDetail(String roName, Model model, Authentication auth) {// 연습실별 상세정보
		String meEmail = auth.getName();//이용자의 이메일
		int scNo = memberService.mySchoolNo(meEmail);
		
		log.info("roName:" + roName);

		model.addAttribute("dto", roomService.roomDetail(roName, scNo));

		return "room/roomDetailPage";
	}

//	@PreAuthorize("isAuthenticated()")
	@GetMapping("/roomList")
	public String roomList(Model model, Authentication auth) {// 연습실 리스트
		
		//이용자의 학교 번호 찾기
		String meEmail = auth.getName();//이용자의 이메일
		int scNo = memberService.mySchoolNo(meEmail);
		//int scNo = 1;
		log.info("이용자의 학교"+scNo);
		List<RoomDTO> list = roomService.roomNoList(scNo);// 가장 낮은 층의 연습실 리스트

		List<RoomDTO> floorList = roomService.floorList(scNo);// 층 리스트

		model.addAttribute("list", list);
		model.addAttribute("floorList", floorList);

		return "room/roomList";
	}

//	@PreAuthorize("isAuthenticated()")
	@GetMapping("/roomFloor")
	public void roomFloor(Model model, @Param("roFloor") int roFloor, Authentication auth) {// 층별 연습실 리스트
		String meEmail = auth.getName();//이용자의 이메일
		int scNo = memberService.mySchoolNo(meEmail);
		//int scNo = 1;
		log.info("이용자의 학교"+scNo);

		List<RoomDTO> list = roomService.selectFloor(roFloor, scNo);

		List<RoomDTO> floorList = roomService.floorList(scNo);// 층 리스트

		model.addAttribute("list", list);
		model.addAttribute("floorList", floorList);

	}
}
