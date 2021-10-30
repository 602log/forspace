package kr.co.forspace.complaint;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import kr.co.forspace.mapper.ComplaintMapper;
import kr.co.forspace.paging.PagingDTO;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@RequiredArgsConstructor
@Log4j
public class ComplaintServiceImpl implements ComplaintService {

	private final ComplaintMapper complaintMapper;
	
	@Override
	public List<ComplaintDTO> selectComplaint(@Param("roNo") int roNo, @Param("pagingDTO") PagingDTO pagingDTO) {
		//log.info("serviceImpl"+roNo);
		return complaintMapper.selectComplaint(roNo, pagingDTO);
	}
	
	@Override
	public int countComplaint(int roNo) {
		return complaintMapper.countComplaint(roNo);
	}

}
