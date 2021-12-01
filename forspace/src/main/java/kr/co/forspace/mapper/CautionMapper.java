package kr.co.forspace.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.co.forspace.caution.CautionDTO;
import kr.co.forspace.paging.PagingDTO;

public interface CautionMapper {

	String findCloseDate(String meEmail);
	void insertCaution(@Param("meEmail") String meEmail, @Param("caReason") String caReason, @Param("caReg") String caReg);
	List<CautionDTO> cautionList(@Param("caReg") String caReg, @Param("pagingDTO") PagingDTO pagingDTO);
	int cntCaution(String caReg);
	void cancelCaution(int caNo);
}
