package kr.co.forspace.member;

import java.util.List;

import org.springframework.stereotype.Service;

import kr.co.forspace.image.ImageDTO;
import kr.co.forspace.mapper.ImageMapper;
import kr.co.forspace.mapper.MemberMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@RequiredArgsConstructor
@Log4j
public class MemberServiceImpl implements MemberService{
	
	private final MemberMapper memberMapper;
	private final ImageMapper imageMapper;
	
	@Override
	public List<SchoolDTO> getSchool(String scName) {
		return memberMapper.getSchool(scName);
	}

	@Override
	public int duplecateEmail(String stEmail) {
		return memberMapper.duplecateEmail(stEmail);
	}

	@Override
	public int numCheck(int scNo, String scChecknum) {
		return memberMapper.numCheck(scNo, scChecknum);
	}

	@Override
	public void memberjoin(StudentDTO studentDTO) {
		memberMapper.memberjoin(studentDTO);
	}

	@Override
	public void memberjoinWithprofileImg(StudentDTO studentDTO) throws Exception {
		memberMapper.memberjoin(studentDTO);
		
		if(studentDTO.getImageDTO() != null && studentDTO.getImageDTO().getImName() != "") {
			ImageDTO imageDTO = studentDTO.getImageDTO();
			imageMapper.memberjoinWithprofileImg(imageDTO);
		}
	}

	
}
