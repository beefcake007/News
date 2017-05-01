package com.fanye.web;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import com.fanye.dao.NewsDao;
import com.fanye.dao.NewsTypeDao;
import com.fanye.model.News;
import com.fanye.model.NewsType;
import com.fanye.util.DbUtil;
import com.fanye.util.ResponseUtil;

public class InitServlet extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	DbUtil dbUtil=new DbUtil();
	NewsDao newsDao=new NewsDao();
	NewsTypeDao newsTypeDao=new NewsTypeDao();

	@Override
	public void init(ServletConfig config) throws ServletException {
		ServletContext application = config.getServletContext();
		this.refreshSystem(application);
	}

	private void refreshSystem(ServletContext application){
		Connection con=null;
		
		try {
			con=dbUtil.getCon();
			
			List<NewsType> newsTypeList=newsTypeDao.newsTypeList(con);
			application.setAttribute("newsTypeList", newsTypeList);
			
			String sql="select * from t_news order by publishDate desc limit 0,8";
			List<News> newestNewsList=newsDao.newsList(con, sql);
			application.setAttribute("newestNewsList", newestNewsList);
			
			sql="select * from t_news order by click desc limit 0,8";
			List<News> hotNewsList=newsDao.newsList(con, sql);
			application.setAttribute("hotNewsList", hotNewsList);
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			try {
				dbUtil.closeCon(con);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doPost(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		HttpSession session=request.getSession();
		ServletContext application=session.getServletContext();
		this.refreshSystem(application);
		JSONObject result=new JSONObject();
		result.put("success", true);
		try {
			ResponseUtil.write(result, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}	
}
