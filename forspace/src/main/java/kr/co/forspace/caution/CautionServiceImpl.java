package kr.co.forspace.caution;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import kr.co.forspace.mapper.CautionMapper;
import kr.co.forspace.paging.PagingDTO;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@RequiredArgsConstructor
@Log4j
public class CautionServiceImpl implements CautionService{

	private final CautionMapper cautionMapper;
	
	@Override
	public void cancelCaution(int caNo) {
		cautionMapper.cancelCaution(caNo);
	}
	
	@Override
	public int cntCaution(String caReg) {
		return cautionMapper.cntCaution(caReg);
	}
	
	@Override
	public List<CautionDTO> cautionList(@Param("caReg") String caReg, @Param("pagingDTO") PagingDTO pagingDTO) {
		return cautionMapper.cautionList(caReg, pagingDTO);
	}
	@Override
	public void insertCaution(@Param("meEmail") String meEmail, @Param("caReason") String caReason, @Param("caReg") String caReg) {
		cautionMapper.insertCaution(meEmail, caReason, caReg);
	}
	
	@Override
	public String findCloseDate(String meEmail) {
		return cautionMapper.findCloseDate(meEmail);
	}
}
