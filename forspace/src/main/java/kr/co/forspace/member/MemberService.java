package kr.co.forspace.member;

import java.util.List;

public interface MemberService {

	List<SchoolDTO> getSchool(String scName);

	int duplecateEmail(String meEmail);

	int numCheck(int scNo, String scChecknum);

	void memberjoin(MemberDTO memberDTO);

	void memberjoinWithprofileImg(MemberDTO memberDTO) throws Exception;

	MemberDTO myProfile(String meEmail);
	
	int mySchoolNo(String meEmail);
}
