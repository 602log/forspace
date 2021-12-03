package kr.co.forspace.caution;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.co.forspace.paging.PagingDTO;

public interface CautionService {
	
	String findCloseDate(String meEmail);
	
	void insertCaution(@Param("meEmail") String meEmail, @Param("caReason") String caReason, @Param("caReg") String caReg);
	
	List<CautionDTO> cautionList(@Param("caReg") String caReg, @Param("pagingDTO") PagingDTO pagingDTO);
	
	int cntCaution(String caReg);
	
	void cancelCaution(int caNo);
	
	String myCaution(String meEmail);

}
