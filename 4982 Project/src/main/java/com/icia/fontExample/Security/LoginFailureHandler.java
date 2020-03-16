package com.icia.fontExample.Security;

import java.io.*;

import javax.servlet.*;
import javax.servlet.http.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.security.authentication.*;
import org.springframework.security.core.*;
import org.springframework.security.web.*;
import org.springframework.security.web.authentication.*;
import org.springframework.stereotype.*;

import com.icia.fontExample.Dao.*;

@Component("loginFailureHandler")
public class LoginFailureHandler extends SimpleUrlAuthenticationFailureHandler {
	@Autowired
	private LoginDao loginDao;
	// 인증에 실패하면 AuthenticationException이 발생
			// 이 예외가 BadCredentialException - 비밀번호 틀림
			// 이 예외가 InternalAuthenticationException - 아이디 없음
			//		Principal, UserDetailsService 작성이 필요
			// 이 예외가 DisabledException - 계정 차단
	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException e) throws IOException, ServletException {
		
		HttpSession session = request.getSession();
		if(e instanceof BadCredentialsException) {
			String username = request.getParameter("username");
			String count = loginDao.findLoginFailureCount(username);
			if(count==null) {
				session.setAttribute("msg", "아이디나 비밀번호를 확인하세요");
			}
			else {
				Integer loginFailureCount = Integer.parseInt(count);
				if(loginFailureCount<4) {
					loginDao.increaseLoginFailureCount(username);
					session.setAttribute("msg", (loginFailureCount + 1) + "회 로그인에 실패했습니다");
				}
				else if(loginFailureCount >= 4 && loginFailureCount <= 9) {
					loginDao.increaseLoginFailureCount(username);
					session.setAttribute("captcha", "captcha");
					session.setAttribute("msg", (loginFailureCount + 1) + "회 로그인에 실패했습니다");
				}
				else if(loginFailureCount > 9) {
					loginDao.block(username);
					session.setAttribute("msg", "10회이상 실패해 계정이 차단되었습니다");
				}
			}
		} else if(e instanceof DisabledException) {
			session.setAttribute("msg", "10회이상 실패해 차단된 계정입니다");
		}
		
		new DefaultRedirectStrategy().sendRedirect(request, response, "/login");
	}
}
