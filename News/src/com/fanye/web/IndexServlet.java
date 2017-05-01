package com.fanye.web;

import java.io.IOException;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fanye.dao.LinkDao;
import com.fanye.dao.NewsDao;
import com.fanye.dao.NewsTypeDao;
import com.fanye.model.Link;
import com.fanye.model.News;
import com.fanye.model.NewsType;
import com.fanye.util.DbUtil;
import com.fanye.util.StringUtil;

public class IndexServlet extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	DbUtil dbUtil=new DbUtil();
	NewsDao newsDao=new NewsDao();
	NewsTypeDao newsTypeDao=new NewsTypeDao();
	LinkDao linkDao=new LinkDao();
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doPost(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		
		Connection con=null;
		try {
			con=dbUtil.getCon();
			
			List<NewsType> newsTypeList=newsTypeDao.newsTypeList(con);
			
			String sql="select * from t_news where isImage=1 order by publishDate desc limit 0,5";
			List<News> imageNewsList=newsDao.newsList(con, sql);
			request.setAttribute("imageNewsList", imageNewsList);
			
			sql="select * from t_news where isHead=1 order by publishDate desc limit 0,1";
			List<News> headNewsList=newsDao.newsList(con, sql);
			News headNews=headNewsList.get(0);
			headNews.setContent(StringUtil.Html2Text(headNews.getContent()));
			request.setAttribute("headNews", headNews);
			
//			sql="select * from t_news order by publishDate desc limit 0,8";
//			List<News> newestNewsList=newsDao.newsList(con, sql);
//			request.setAttribute("newestNewsList", newestNewsList);
			
			sql="select * from t_news where isHot=1 order by publishDate desc limit 0,8";
			List<News> hotSpotNewsList=newsDao.newsList(con, sql);
			request.setAttribute("hotSpotNewsList", hotSpotNewsList);
			
			List allIndexNewsList=new ArrayList();
			if(newsTypeList!=null && newsTypeList.size()!=0){
				for(int i=0;i<newsTypeList.size();i++){
					NewsType newsType=newsTypeList.get(i);
					sql="select * from t_news,t_newsType where typeId=newsTypeId and typeId="+newsType.getNewsTypeId()+" order by publishDate desc limit 0,8";
					List<News> oneSubList=newsDao.newsList(con, sql);
					allIndexNewsList.add(oneSubList);
				}
			}
			request.setAttribute("allIndexNewsList", allIndexNewsList);
			
			sql="select * from t_link order by orderNum";
			List<Link> linkList=linkDao.linkList(con, sql);
			request.setAttribute("linkList", linkList);
			
			request.getRequestDispatcher("index.jsp").forward(request, response);
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

	
}
