package com.fanye.web;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.fanye.dao.UserDao;
import com.fanye.model.User;
import com.fanye.util.DbUtil;

public class UserServlet extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	DbUtil dbUtil=new DbUtil();
	UserDao userDao=new UserDao();

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doPost(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		String action=request.getParameter("action");
		if("login".equals(action)){
			this.login(request,response);
		}else if("logout".equals(action)){
			this.logout(request,response);
		}
	}

	private void login(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String userName=request.getParameter("userName");
		String password=request.getParameter("password");
		
		HttpSession session = request.getSession();
		Connection con=null;
		 try{
			 con=dbUtil.getCon();
			 User user=new User(userName,password);
			 User currentUser=userDao.login(con, user);
			 if(currentUser==null){
				 request.setAttribute("error", "用户名或密码错误");
				 request.setAttribute("userName", userName);
				 request.setAttribute("password", password);
				 request.getRequestDispatcher("/background/login.jsp").forward(request, response);
			 }else{
				 session.setAttribute("currentUser", currentUser);
				 request.setAttribute("mainPage", "/background/default.jsp");
				 request.getRequestDispatcher("/background/mainTemp.jsp").forward(request, response);
			 }
		 }catch(Exception e){
			 e.printStackTrace();
		 }finally{
			 try {
				dbUtil.closeCon(con);
			} catch (Exception e) {
				e.printStackTrace();
			}
		 }
	}
	
	
	private void logout(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.getSession().invalidate();
		System.out.println(request.getContextPath()+"/background/login.jsp");
		response.sendRedirect(request.getContextPath()+"/background/login.jsp");
	}
	
}
