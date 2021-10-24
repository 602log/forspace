package kr.co.forspace.security;

import java.util.ArrayList;
import java.util.Collection;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;

import kr.co.forspace.mapper.MemberMapper;
import kr.co.forspace.member.MemberDTO;
import lombok.NoArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@NoArgsConstructor
public class CustomUserDetailsService implements UserDetailsService{
	//UserDetailsService : DB의 유저정보를 가져옴
	
	@Autowired
	private MemberMapper memberMapper;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		//DB에서 유저정보를 불러오는 메소드
		MemberDTO memberDTO = memberMapper.myProfile(username);//로그인 USER정보 가져오기
		Collection<GrantedAuthority> authList = new ArrayList<GrantedAuthority>();
		authList.add(new SimpleGrantedAuthority("ROLE_"+memberDTO.getMeRole()));
		
		return new CustomUser(memberDTO, authList);
	}
	
}
