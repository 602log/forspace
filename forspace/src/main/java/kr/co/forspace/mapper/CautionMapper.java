package kr.co.forspace.mapper;

import org.apache.ibatis.annotations.Param;

public interface CautionMapper {

	String findCloseDate(String meEmail);
	void insertCaution(@Param("meEmail") String meEmail, @Param("caReason") String caReason);
}
