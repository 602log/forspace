package kr.co.forspace.caution;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import kr.co.forspace.mapper.CautionMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@RequiredArgsConstructor
@Log4j
public class CautionServiceImpl implements CautionService{

	private final CautionMapper cautionMapper;
	
	@Override
	public void insertCaution(@Param("meEmail") String meEmail, @Param("caReason") String caReason) {
		cautionMapper.insertCaution(meEmail, caReason);
	}
	
	@Override
	public String findCloseDate(String meEmail) {
		return cautionMapper.findCloseDate(meEmail);
	}
}
