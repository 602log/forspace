package kr.co.forspace.room;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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
 
	@PostMapping("/addroom")
	public void addroom(RoomDTO roomDTO, int[] itNo, int[] riCnt, int roomCnt, Authentication auth) {
		log.info(roomDTO);
		log.info(roomDTO.getRoClose().getClass().getSimpleName());
		log.info(itNo.length);
		log.info("만들 연습실 개수"+roomCnt);
		
		String meEmail = auth.getName();
		int scNo = memberService.mySchoolNo(meEmail);
		
		//해당 학교, 해당 층의 가장 나중에 입력한 연습실 이름
		String maxRoName = roomService.maxRoomName(roomDTO.getRoFloor(), scNo);
		
		//등록 층수(int)를 string으로 형변환
		String roFloorStr = Integer.toString(roomDTO.getRoFloor());
		
		if(maxRoName == "" || maxRoName == null) {//해당 층에 등록된 연습실이 없으면
			
			log.info("등록된 연습실이 없음");
			String RoNamestr;
			
			for(int i=1; i<=roomCnt; i++) {
				//층수 + 개수로 roName 등록
				if(roomCnt>9) {
					RoNamestr = roFloorStr+i;
				}else {
					RoNamestr = roFloorStr+0+i;
				}
				
				roomDTO.setScNo(scNo);
				roomDTO.setRoName(RoNamestr);
				
				roomService.insertRoom(roomDTO);
				int roNo = roomDTO.getRoNo();
				//room item insert
				for(int a=0; a<=itNo.length-1; a++) {
					
					RoomItemDTO roomItemDTO = RoomItemDTO.builder()
											.roNo(roNo)
											.itNo(itNo[a])
											.riCnt(riCnt[a])
											.build();

					log.info(roomItemDTO);
					roomService.insertRoomItem(roomItemDTO);
				}

			}
			
		}else {//해당 층에 등록된 연습실이 있음
			log.info("등록된 연습실이 있음"+maxRoName);

			int roNameInt; //형변환 후 연습실 이름을 담을 변수
			
			//string to int (문자열인 경우 예외처리)
			try {
				roNameInt = Integer.valueOf(maxRoName);//연습실 이름을 숫자로 변경
			}catch(NumberFormatException e){
				roNameInt = 0; //문자열을 숫자로 변경할 수 없을 경우 예외처리
			}
			
				if(roNameInt == 0){//층수 + 번호로 roName 등록
					String RoNamestr;
					
					for(int i=1; i<=roomCnt; i++) {
						//층수 + 개수로 roName 등록
						if(roomCnt>9) {
							RoNamestr = roFloorStr+i;
						}else {
							RoNamestr = roFloorStr+"0"+i;
						}
						
						roomDTO.setScNo(scNo);
						roomDTO.setRoName(RoNamestr);
						
						//연습실 등록(insert)
						roomService.insertRoom(roomDTO);
						int roNo = roomDTO.getRoNo();
						//room item insert
						for(int a=0; a<=itNo.length-1; a++) {
							
							RoomItemDTO roomItemDTO = RoomItemDTO.builder()
													.roNo(roNo)
													.itNo(itNo[a])
													.riCnt(riCnt[a])
													.build();

							log.info(roomItemDTO);
							roomService.insertRoomItem(roomItemDTO);
						}
					}
					
				}else {//층수 + 1로 roName 등록
					
					for(int i=1; i<=roomCnt; i++) {
	
						int newRoName = roNameInt + i;
						String newRoNameStr = Integer.toString(newRoName);
						
						roomDTO.setScNo(scNo);
						roomDTO.setRoName(newRoNameStr);
						
						roomService.insertRoom(roomDTO);
						int roNo = roomDTO.getRoNo();
						//room item insert
						for(int a=0; a<=itNo.length-1; a++) {
							
							RoomItemDTO roomItemDTO = RoomItemDTO.builder()
													.roNo(roNo)
													.itNo(itNo[a])
													.riCnt(riCnt[a])
													.build();

							log.info(roomItemDTO);
							roomService.insertRoomItem(roomItemDTO);
						}
				
					}//end of for
				}//end of if
			
		}//end of if
		
			
		
	}//end of addroom()
	
	@ResponseBody
	@PostMapping("/searchItem")
	public List<ItemDTO> searchItem(String itName){
		log.info(itName);
		List<ItemDTO> list = roomService.searchItem(itName);
		log.info(list);
		return list;
	}
	
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@GetMapping("/addroom")
	public void addroom() {

	}

	@PreAuthorize("isAuthenticated()")
	@GetMapping("/roomDetail")
	public String roomDetail(int roNo, Model model, Authentication auth) {// 연습실별 상세정보
		
		log.info("roNo:" + roNo);
		
		model.addAttribute("dto", roomService.roomDetail(roNo));		
		return "/room/roomDetail";
		
	}
	
	@PreAuthorize("isAuthenticated()")
	@RequestMapping("/roomList")
	public void roomList(Model model, int roFloor, Authentication auth) {// 연습실 리스트
		
		//이용자의 학교 번호 찾기
		String meEmail = auth.getName();//이용자의 이메일
		int scNo = memberService.mySchoolNo(meEmail);
		//int scNo = 1;
		log.info("이용자의 학교"+scNo);
		
		List<RoomDTO> list;
		
		list = roomService.selectFloor(roFloor, scNo);
		
		for(int i=0; i<list.size(); i++) {
		
			int roNo = list.get(i).getRoNo(); // i번째 roNo
			int myLike = roomService.getLikeInfo(roNo, meEmail);//user가 i번째를 좋아요 했으면 1, 아니면 0
			list.get(i).setMyLike(myLike);
		}
		/*
		 * 
		 * int likeCnt = roomService.getLike(roNo); //해당 연습실의 like 수
		 * list.get(i).setLikeCnt(likeCnt);//i번째의 like 수 setting
		 * 
		 * //model.addAttribute("likeList", likeDTO); //i번째를 좋아요 한 모든 정보
		 * 
		 * }
		 */
		
		model.addAttribute("list", list);
		log.info(list);
		List<RoomDTO> floorList = roomService.floorList(scNo);// 층 리스트
		model.addAttribute("floorList", floorList);
	}
	
	@ResponseBody
	@PostMapping("/insertLike")
	public String insertLike(int roNo, String meEmail) throws Exception {
		log.info("roNo : "+ roNo + "meEmail : "+meEmail);
		
		int myLike = roomService.getLikeInfo(roNo, meEmail); //user가 like 했는지
		
		String result = "";
		
		if(myLike == 0) {
			roomService.insertLike(roNo, meEmail);//insert like
			result =  "like";
			
		}else {
			roomService.deleteLike(roNo, meEmail);
			result =  "unlike";
		}
		roomService.updateLikeCnt(roNo, myLike);
		return result;
	}
	
}
