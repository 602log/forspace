package kr.co.forspace.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.co.forspace.notice.NoticeDTO;
import kr.co.forspace.paging.PagingDTO;

public interface NoticeMapper {

	List<NoticeDTO> noticeList(@Param("scNo") int scNo, @Param("pagingDTO") PagingDTO pagingDTO);
	
	int countNotice(int scNo);
	
	NoticeDTO readNotice(int noNo);
	
	void modify(NoticeDTO noticeDTO);
	
	void removeNotice(int noNo);
	
	void updateCnt(int noNo);
	
	void insertNotice(NoticeDTO noticeDTO);
}
