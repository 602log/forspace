package kr.co.forspace.caution;

import org.apache.ibatis.annotations.Param;

public interface CautionService {
	
	String findCloseDate(String meEmail);
	
	void insertCaution(@Param("meEmail") String meEmail, @Param("caReason") String caReason);

}
