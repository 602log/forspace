package kr.co.forspace.mapper;

import java.util.List;

import kr.co.forspace.member.SchoolDTO;
import kr.co.forspace.member.MemberDTO;

public interface MemberMapper {

	List<SchoolDTO> getSchool(String scName);

	int duplecateEmail(String meEmail);

	int numCheck(int scNo, String scChecknum);

	void memberjoin(MemberDTO memberDTO);
	
	MemberDTO myProfile(String meEmail);
	
	int mySchoolNo(String meEmail);
}