package kr.co.forspace.member;

import java.util.List;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import kr.co.forspace.image.ImageDTO;
import kr.co.forspace.mapper.ImageMapper;
import kr.co.forspace.mapper.MemberMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@RequiredArgsConstructor
@Log4j
public class MemberServiceImpl implements MemberService {

	private final MemberMapper memberMapper;
	private final ImageMapper imageMapper;
	private final PasswordEncoder passwordEncoder;

	@Override
	public List<SchoolDTO> getSchool(String scName) {
		return memberMapper.getSchool(scName);
	}

	@Override
	public int duplecateEmail(String meEmail) {
		return memberMapper.duplecateEmail(meEmail);
	}

	@Override
	public int numCheck(int scNo, String scChecknum) {
		return memberMapper.numCheck(scNo, scChecknum);
	}

	@Override
	public void memberjoin(MemberDTO memberDTO) {
		memberDTO.setMePwd(passwordEncoder.encode(memberDTO.getMePwd()));
		memberMapper.memberjoin(memberDTO);
	}

	@Override
	public void memberjoinWithprofileImg(MemberDTO memberDTO) throws Exception {
		memberDTO.setMePwd(passwordEncoder.encode(memberDTO.getMePwd()));
		memberMapper.memberjoin(memberDTO);

		if (memberDTO.getImageDTO() != null && memberDTO.getImageDTO().getImName() != "") {
			ImageDTO imageDTO = memberDTO.getImageDTO();
			imageMapper.memberjoinWithprofileImg(imageDTO);
		}
	}
	
	@Override
	public MemberDTO myProfile(String meEmail) {
		return memberMapper.myProfile(meEmail);
	}
	
	@Override
	public int mySchoolNo(String meEmail) {
		return memberMapper.mySchoolNo(meEmail);
	}

}
