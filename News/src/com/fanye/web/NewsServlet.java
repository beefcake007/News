package com.fanye.web;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.fanye.dao.CommentDao;
import com.fanye.dao.NewsDao;
import com.fanye.dao.NewsTypeDao;
import com.fanye.model.Comment;
import com.fanye.model.News;
import com.fanye.model.NewsType;
import com.fanye.model.PageBean;
import com.fanye.util.DateUtil;
import com.fanye.util.DbUtil;
import com.fanye.util.NavUtil;
import com.fanye.util.PageUtil;
import com.fanye.util.PropertiesUtil;
import com.fanye.util.ResponseUtil;
import com.fanye.util.StringUtil;

public class NewsServlet extends HttpServlet{
	
	private static final long serialVersionUID = 1L;

	DbUtil dbUtil=new DbUtil();
	NewsDao newsDao=new NewsDao();
	NewsTypeDao newsTypeDao =new NewsTypeDao();
	CommentDao commentDao=new CommentDao();
	
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
		if("list".equals(action)){
			this.newsList(request, response);
		}else if("show".equals(action)){
			this.newsShow(request, response);
		}else if("preSave".equals(action)){
			this.newsPreSave(request, response);
		}else if("save".equals(action)){
			this.newsSave(request, response);
		}else if("backList".equals(action)){
			this.newsBackList(request,response);
		}else if("delete".equals(action)){
			this.newsDelete(request,response);
		}
	}	
	
	
	private void newsList(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String typeId=request.getParameter("typeId");
		
		String page=request.getParameter("page");
		if(StringUtil.isEmpty(page)){
			page="1";
		}
		Connection con=null;
		News s_news=new News();
		if(StringUtil.isNotEmpty(typeId)){
			s_news.setTypeId(Integer.parseInt(typeId));
		}
		try{
			con=dbUtil.getCon();
			int total=newsDao.newsCount(con, s_news,null,null);
			PageBean pageBean=new PageBean(Integer.parseInt(page),Integer.parseInt(PropertiesUtil.getValue("pageSize")));
			List<News> newestNewsListWithType=newsDao.newsList(con, s_news, pageBean,null,null);
			request.setAttribute("newestNewsListWithType", newestNewsListWithType);
			String typeName=newsTypeDao.getNewsTypeById(con, typeId).getTypeName();
			String navCode = NavUtil.genNewsListNavigation(typeName, typeId);
			request.setAttribute("navCode", navCode);
			request.setAttribute("pageCode", PageUtil.getUpAndDownPagation(total, Integer.parseInt(page), Integer.parseInt(PropertiesUtil.getValue("pageSize")), typeId));
			request.setAttribute("mainPage", "news/newsList.jsp");
			request.getRequestDispatcher("foreground/newsTemp.jsp").forward(request, response);
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
	
	private void newsShow(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String newsId=request.getParameter("newsId");
		Connection con=null;
		try{
			con=dbUtil.getCon();
			newsDao.newClick(con, newsId);
			News news=newsDao.getNewsById(con, newsId);
			Comment s_comment=new Comment();
			s_comment.setNewsId(Integer.parseInt(newsId));
			List<Comment> commentList=commentDao.commentList(con, s_comment,null,null,null);
			request.setAttribute("commentList", commentList);
			request.setAttribute("news", news);
			request.setAttribute("pageCode", this.getUpAndDownPageCode(newsDao.getUpAndDownPageId(con, newsId)));
			request.setAttribute("navCode", NavUtil.genNewsNavigation(news.getTypeName(),news.getTypeId()+"", news.getTitle()));
			request.setAttribute("mainPage", "news/newsShow.jsp");
			request.getRequestDispatcher("foreground/newsTemp.jsp").forward(request, response);
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
	
	
	private String getUpAndDownPageCode(List<News> upAndDownPage){
		News upNews=upAndDownPage.get(0);
		News downNews=upAndDownPage.get(1);
		StringBuffer pageCode=new StringBuffer();
		if(upNews.getNewsId()==-1){
			pageCode.append("<p>上一篇：没有了</p>");
		}else{
			pageCode.append("<p>上一篇：<a href='news?action=show&newsId="+upNews.getNewsId()+"'>"+upNews.getTitle()+"</a></p>");
		}
		
		if(downNews.getNewsId()==-1){
			pageCode.append("<p>下一篇：没有了</p>");
		}else{
			pageCode.append("<p>下一篇：<a href='news?action=show&newsId="+downNews.getNewsId()+"'>"+downNews.getTitle()+"</a></p>");
		}
		return pageCode.toString();
	}
	
	
	private void newsPreSave(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String newsId=request.getParameter("newsId");
		Connection con=null;
		try{
			con=dbUtil.getCon();
			if(StringUtil.isNotEmpty(newsId)){
				News news=newsDao.getNewsById(con, newsId);
				request.setAttribute("news", news);
			}
			List<NewsType> newsTypeList=newsTypeDao.newsTypeList(con);
			request.setAttribute("newsTypeList", newsTypeList);
			if(StringUtil.isNotEmpty(newsId)){
				request.setAttribute("navCode", NavUtil.genNewsManageNavigation("新闻管理", "新闻修改"));
			}else{
				request.setAttribute("navCode", NavUtil.genNewsManageNavigation("新闻管理", "新闻添加"));
			}
			request.setAttribute("mainPage", "/background/news/newsWrite.jsp");
			request.getRequestDispatcher("/background/mainTemp.jsp").forward(request, response);
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
	
	
	private void newsSave(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		FileItemFactory factory=new DiskFileItemFactory();
		ServletFileUpload upload=new ServletFileUpload(factory);
		List<FileItem> items=null;
		try {
			items=upload.parseRequest(request);
		} catch (Exception e) {
			e.printStackTrace();
		}
		Iterator itr=items.iterator();
		News news=new News();
		while(itr.hasNext()){
			FileItem item=(FileItem) itr.next();
			if(item.isFormField()){
				String fieldName=item.getFieldName();
				if("newsId".equals(fieldName)){
					if(StringUtil.isNotEmpty(item.getString("utf-8"))){
						news.setNewsId(Integer.parseInt(item.getString("utf-8")));
					}
				}
				if("title".equals(fieldName)){
					news.setTitle(item.getString("utf-8"));
				}
				if("content".equals(fieldName)){
					news.setContent(item.getString("utf-8"));
				}
				if("author".equals(fieldName)){
					news.setAuthor(item.getString("utf-8"));
				}
				if("typeId".equals(fieldName)){
					news.setTypeId(Integer.parseInt(item.getString("utf-8")));
				}
				if("isHead".equals(fieldName)){
					news.setIsHead(Integer.parseInt(item.getString("utf-8")));
				}
				if("isImage".equals(fieldName)){
					news.setIsImage(Integer.parseInt(item.getString("utf-8")));
				}
				if("isHot".equals(fieldName)){
					news.setIsHot(Integer.parseInt(item.getString("utf-8")));
				}
				if("imageName".equals(fieldName)&&news.getImageName()==null){
					if(StringUtil.isNotEmpty(item.getString("utf-8"))){
						news.setImageName(item.getString("utf-8").split("/")[1]);
					}
				}
			}else if(!"".equals(item.getName())){
				try {
					String imageName=DateUtil.getCurrentDateStr();
					news.setImageName(imageName+"."+item.getName().split("\\.")[1]);
					String filePath=PropertiesUtil.getValue("imagePath")+imageName+"."+item.getName().split("\\.")[1];
					item.write(new File(filePath));
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		
		Connection con=null;
		try{
			con=dbUtil.getCon();
			if(news.getNewsId()!=0){
				newsDao.newsUpdate(con, news);
			}else{
				newsDao.newsAdd(con, news);
			}
			
			request.getRequestDispatcher("/news?action=backList").forward(request, response);
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
	
	
	private void newsBackList(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String s_bPublishDate=request.getParameter("s_bPublishDate");
		String s_aPublishDate=request.getParameter("s_aPublishDate");
		String s_title=request.getParameter("s_title");
		String page=request.getParameter("page");
		HttpSession session=request.getSession();
		if(StringUtil.isEmpty(page)){
			page="1";
			session.setAttribute("s_bPublishDate", s_bPublishDate);
			session.setAttribute("s_aPublishDate", s_aPublishDate);
			session.setAttribute("s_title", s_title);
		}else{
			s_bPublishDate=(String) session.getAttribute("s_bPublishDate");
			s_aPublishDate=(String) session.getAttribute("s_aPublishDate");
			s_title=(String) session.getAttribute("s_title");
		}
		
		Connection con=null;
		News s_news=new News();
		if(StringUtil.isNotEmpty(s_title)){
			s_news.setTitle(s_title);
		}
		try{
			con=dbUtil.getCon();
			int total=newsDao.newsCount(con, s_news, s_bPublishDate, s_aPublishDate);
			String pageCode=PageUtil.getPagation(request.getContextPath()+"/news?action=backList", total, Integer.parseInt(page), Integer.parseInt(PropertiesUtil.getValue("backPageSize")));
			PageBean pageBean=new PageBean(Integer.parseInt(page),Integer.parseInt(PropertiesUtil.getValue("backPageSize")));
			List<News> newsBackList=newsDao.newsList(con, s_news,pageBean,s_bPublishDate,s_aPublishDate);
			request.setAttribute("pageCode", pageCode);
			request.setAttribute("newsBackList", newsBackList);
			request.setAttribute("navCode", NavUtil.genNewsManageNavigation("新闻管理", "新闻维护"));
			request.setAttribute("mainPage", "/background/news/newsList.jsp");
			request.getRequestDispatcher("/background/mainTemp.jsp").forward(request, response);
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
	
	
	private void newsDelete(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String newsId=request.getParameter("newsId");
		Connection con=null;
		boolean delFlag;
		try{
			con=dbUtil.getCon();
			int delNums=newsDao.newsDelete(con, newsId);
			if(delNums==1){
				delFlag=true;
			}else{
				delFlag=false;
			}
			ResponseUtil.write(delFlag, response);
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
	
}
