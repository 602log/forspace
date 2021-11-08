package kr.co.forspace.member;

import java.util.List;

import org.apache.ibatis.annotations.Param;
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
	public void updateProfileWithoutPwd(MemberDTO memberDTO) throws Exception {
		memberMapper.updateProfileWithoutPwd(memberDTO);
		if (memberDTO.getImageDTO() != null && memberDTO.getImageDTO().getImName() != "") {
			ImageDTO imageDTO = memberDTO.getImageDTO();
			int cnt = imageMapper.selectMyImg(imageDTO.getImEmail());
			if(cnt == 1) {//이미 등록한 이미지가 있는 경우
				imageMapper.updateProfileImg(imageDTO);
			}else{//처음 이미지를 등록한 경우
				imageMapper.memberjoinWithprofileImg(imageDTO);
			}
		}
	}
	
	@Override
	public void updateProfileImg(MemberDTO memberDTO) throws Exception {
		memberDTO.setMePwd(passwordEncoder.encode(memberDTO.getMePwd()));
		memberMapper.updateProfile(memberDTO);//프로필 수정
		
		if (memberDTO.getImageDTO() != null && memberDTO.getImageDTO().getImName() != "") {
			ImageDTO imageDTO = memberDTO.getImageDTO();
			int cnt = imageMapper.selectMyImg(imageDTO.getImEmail());
			if(cnt == 1) {//이미 등록한 이미지가 있을 경우
				imageMapper.updateProfileImg(imageDTO);
			}else{//처음 이미지를 등록한 경우
				imageMapper.memberjoinWithprofileImg(imageDTO);
			}
		}
	}
	
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
	
	@Override
	public void insertSchool(SchoolDTO schoolDTO) {
		memberMapper.insertSchool(schoolDTO);
	}
	
	@Override
	public int duplecateSchool(@Param("scName") String scName, @Param("scCampus") String scCampus, @Param("scMajor") String scMajor) {
		return memberMapper.duplecateSchool(scName, scCampus, scMajor);
	}

}
