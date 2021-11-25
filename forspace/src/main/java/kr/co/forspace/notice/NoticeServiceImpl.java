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
	public void insertNotice(NoticeDTO noticeDTO) {
		noticeMapper.insertNotice(noticeDTO);
	}
	
	@Override
	public void updateCnt(int noNo) {
		noticeMapper.updateCnt(noNo);
	}
	
	@Override
	public void removeNotice(int noNo) {
		noticeMapper.removeNotice(noNo);
	}
	@Override
	public void modify(NoticeDTO noticeDTO) {
		noticeMapper.modify(noticeDTO);
	}
	
	@Override
	public NoticeDTO readNotice(int noNo) {
		return noticeMapper.readNotice(noNo);
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
