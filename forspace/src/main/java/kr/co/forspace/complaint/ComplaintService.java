package kr.co.forspace.complaint;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.co.forspace.paging.PagingDTO;

public interface ComplaintService {

	List<ComplaintDTO> selectComplaint(@Param("roNo") int roNo, @Param("pagingDTO") PagingDTO pagingDTO);
	
	int countComplaint(int roNo);
}
