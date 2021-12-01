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
	public List<ComplaintDTO> notFinComplaint(String meEmail) {
		return complaintMapper.notFinComplaint(meEmail);
	}
	
	@Override
	public List<ComplaintDTO> selectComplaint(@Param("roNo") int roNo, @Param("pagingDTO") PagingDTO pagingDTO) {
		//log.info("serviceImpl"+roNo);
		return complaintMapper.selectComplaint(roNo, pagingDTO);
	}
	
	@Override
	public int countComplaint(int roNo) {
		return complaintMapper.countComplaint(roNo);
	}

	@Override
	public void insertComplaint(@Param("roNo") int roNo, @Param("coContent") String coContent, @Param("meEmail")String meEmail) throws Exception{
		log.info("ServiceImple.....................");
		log.info(roNo+coContent+meEmail);
		
		try {
			complaintMapper.insertComplaint(roNo, coContent, meEmail);
		}catch(Exception e) {
			log.info(e);
		}
		
	}
	
	@Override
	public boolean deleteComplaint(@Param("coNo") int coNo, @Param("roNo") int roNo){
		log.info("delete ServiceImple..................");
		return complaintMapper.deleteComplaint(coNo, roNo);

	}
	
	@Override
	public boolean FinishComplaint(@Param("coNo") int coNo, @Param("roNo") int roNo) {
		log.info("finishComplaint ServiceImple....................");
		return complaintMapper.FinishComplaint(coNo, roNo);
	}
}
