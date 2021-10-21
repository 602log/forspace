package kr.co.forspace.member;

import java.util.List;

public interface MemberService {
	
	List<SchoolDTO> getSchool(String scName);
	int duplecateEmail(String stEmail);
	int numCheck(int scNo, String scChecknum);
	void memberjoin(StudentDTO studentDTO);
	void memberjoinWithprofileImg(StudentDTO studentDTO) throws Exception;

}
