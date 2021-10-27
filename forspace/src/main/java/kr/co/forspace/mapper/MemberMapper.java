package kr.co.forspace.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.co.forspace.member.SchoolDTO;
import kr.co.forspace.member.MemberDTO;

public interface MemberMapper {

	List<SchoolDTO> getSchool(String scName);

	int duplecateEmail(String meEmail);

	int numCheck(int scNo, String scChecknum);

	void memberjoin(MemberDTO memberDTO);
	
	MemberDTO myProfile(String meEmail);
	
	int mySchoolNo(String meEmail);
	
	void insertSchool(SchoolDTO schoolDTO);
	
	int duplecateSchool(@Param("scName") String scName, @Param("scCampus") String scCampus, @Param("scMajor") String scMajor);
}
