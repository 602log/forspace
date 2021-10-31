package kr.co.forspace.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.co.forspace.complaint.ComplaintDTO;
import kr.co.forspace.paging.PagingDTO;

public interface ComplaintMapper {

	List<ComplaintDTO> selectComplaint(@Param("roNo") int roNo, @Param("pagingDTO") PagingDTO pagingDTO);
	
	int countComplaint(int roNo);
	
	void insertComplaint(@Param("roNo") int roNo, @Param("coContent") String coContent, @Param("meEmail")String meEmail);
	
	boolean deleteComplaint(@Param("coNo") int coNo, @Param("roNo") int roNo);
	
	boolean FinishComplaint(@Param("coNo") int coNo, @Param("roNo") int roNo);
}
