package kr.co.forspace.mapper;

import java.util.List;

import kr.co.forspace.member.SchoolDTO;
import kr.co.forspace.member.StudentDTO;

public interface MemberMapper {

	List<SchoolDTO> getSchool(String scName);
	int duplecateEmail(String stEmail);
	int numCheck(int scNo, String scChecknum);
	void memberjoin(StudentDTO studentDTO);
}
