package kr.co.forspace.notice;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import kr.co.forspace.mapper.NoticeMapper;
import kr.co.forspace.paging.PagingDTO;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@RequiredArgsConstructor
@Log4j
public class NoticeServiceImpl implements NoticeService{

	private final NoticeMapper noticeMapper;
	
	@Override
	public NoticeDTO getNoticeDetail(int noNo) {
		log.info("service....."+" "+noNo);
		return noticeMapper.getNoticeDetail(noNo);
	}
	@Override
	public List<NoticeDTO> noticeList(@Param("scNo") int scNo, @Param("pagingDTO") PagingDTO pagingDTO) {
		return noticeMapper.noticeList(scNo, pagingDTO);
	}
	
	@Override
	public int countNotice(int scNo) {
		return noticeMapper.countNotice(scNo);
	}
}
