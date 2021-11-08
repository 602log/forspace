package kr.co.forspace.member;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.co.forspace.image.ImageDTO;

public interface MemberService {

	List<SchoolDTO> getSchool(String scName);

	int duplecateEmail(String meEmail);

	int numCheck(int scNo, String scChecknum);

	void memberjoin(MemberDTO memberDTO);

	void memberjoinWithprofileImg(MemberDTO memberDTO) throws Exception;

	MemberDTO myProfile(String meEmail);
	
	int mySchoolNo(String meEmail);
	
	void insertSchool(SchoolDTO schoolDTO);
	
	int duplecateSchool(@Param("scName") String scName, @Param("scCampus") String scCampus, @Param("scMajor") String scMajor);
	
	void updateProfileImg(MemberDTO memberDTO) throws Exception;
	
	void updateProfileWithoutPwd(MemberDTO memberDTO) throws Exception;
	
	ImageDTO myImg(String imEmail);
}
