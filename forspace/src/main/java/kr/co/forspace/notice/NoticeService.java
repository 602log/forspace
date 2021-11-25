package kr.co.forspace.notice;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.co.forspace.paging.PagingDTO;

public interface NoticeService {

	List<NoticeDTO> noticeList(@Param("scNo") int scNo, @Param("pagingDTO") PagingDTO pagingDTO);
	
	int countNotice(int scNo);
	
	NoticeDTO readNotice(int noNo);
	
	void modify(NoticeDTO noticeDTO);
	
	void removeNotice(int noNo);
	
	void updateCnt(int noNo);
	
	void insertNotice(NoticeDTO noticeDTO);
}
