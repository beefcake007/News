package com.fanye.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.fanye.model.News;
import com.fanye.model.NewsType;
import com.fanye.model.PageBean;
import com.fanye.util.DateUtil;
import com.fanye.util.PropertiesUtil;
import com.fanye.util.StringUtil;

public class NewsDao {
	
	public List<News> newsList(Connection con,String sql)throws Exception{
		List<News> newsList=new ArrayList<News>();
		PreparedStatement pstmt=con.prepareStatement(sql);
		ResultSet re=pstmt.executeQuery();
		while(re.next()){
			News news=new News();
			news.setNewsId(re.getInt("newsId"));
			news.setTitle(re.getString("title"));
			news.setContent(re.getString("content"));
			news.setPublishDate(DateUtil.formatString(re.getString("publishDate"), "yyyy-MM-dd HH:mm:ss"));
			news.setAuthor(re.getString("author"));
			news.setTypeId(re.getInt("typeId"));
			news.setClick(re.getInt("click"));
			news.setIsHead(re.getInt("isHead"));
			news.setImageName(PropertiesUtil.getValue("userImage")+re.getString("imageName"));
			news.setIsHot(re.getInt("isHot"));
			newsList.add(news);
		}
		return newsList;
	}
	
	public List<News> newsList(Connection con,News s_news,PageBean pageBean,String s_bPublishDate,String s_aPublishDate)throws Exception{
		List<News> newsList=new ArrayList<News>();
		StringBuffer db=new StringBuffer("select * from t_news t1,t_newsType t2 where t1.typeId=t2.newsTypeId ");
		if(s_news.getTypeId()!=-1){
			db.append(" and t1.typeId="+s_news.getTypeId());
		}
		if(StringUtil.isNotEmpty(s_news.getTitle())){
			db.append(" and t1.title like '%"+s_news.getTitle()+"%'");
		}
		if(StringUtil.isNotEmpty(s_bPublishDate)){
			db.append(" and TO_DAYS(t1.publishDate)>=TO_DAYS('"+s_bPublishDate+"')");
		}
		if(StringUtil.isNotEmpty(s_aPublishDate)){
			db.append(" and TO_DAYS(t1.publishDate)<=TO_DAYS('"+s_aPublishDate+"')");
		}
		db.append(" order by t1.publishDate desc ");
		if(pageBean!=null){
			db.append(" limit "+pageBean.getStart()+","+pageBean.getPageSize());
		}
		PreparedStatement pstmt=con.prepareStatement(db.toString());
		ResultSet re=pstmt.executeQuery();
		while(re.next()){
			News news=new News();
			news.setNewsId(re.getInt("newsId"));
			news.setTitle(re.getString("title"));
			news.setContent(re.getString("content"));
			news.setPublishDate(DateUtil.formatString(re.getString("publishDate"), "yyyy-MM-dd HH:mm:ss"));
			news.setAuthor(re.getString("author"));
			news.setTypeId(re.getInt("typeId"));
			news.setTypeName(re.getString("typeName"));
			news.setClick(re.getInt("click"));
			news.setIsHead(re.getInt("isHead"));
			news.setImageName(PropertiesUtil.getValue("userImage")+re.getString("imageName"));
			news.setIsHot(re.getInt("isHot"));
			newsList.add(news);
		}
		return newsList;
	}
	
	public int newsCount(Connection con,News s_news,String s_bPublishDate,String s_aPublishDate)throws Exception{
		StringBuffer sb=new StringBuffer("select count(*) as total from t_news");
		if(s_news.getTypeId()!=-1){
			sb.append(" and typeId="+s_news.getTypeId());
		}
		if(StringUtil.isNotEmpty(s_news.getTitle())){
			sb.append(" and title like '%"+s_news.getTitle()+"%'");
		}
		if(StringUtil.isNotEmpty(s_bPublishDate)){
			sb.append(" and TO_DAYS(publishDate)>=TO_DAYS('"+s_bPublishDate+"')");
		}
		if(StringUtil.isNotEmpty(s_aPublishDate)){
			sb.append(" and TO_DAYS(publishDate)<=TO_DAYS('"+s_aPublishDate+"')");
		}
		PreparedStatement pstmt=con.prepareStatement(sb.toString().replaceFirst("and", "where"));
		ResultSet rs=pstmt.executeQuery();
		if(rs.next()){
			return rs.getInt("total");
		}else{
			return 0;
		}
	}
	
	public News getNewsById(Connection con,String newsId)throws Exception{
		String sql="select * from t_news t1,t_newsType t2 where t1.typeId=t2.newsTypeId and t1.newsId=?";
		PreparedStatement pstmt=con.prepareStatement(sql);
		pstmt.setString(1, newsId);
		ResultSet re=pstmt.executeQuery();
		News news =new News();
		if(re.next()){
			news.setNewsId(re.getInt("newsId"));
			news.setTitle(re.getString("title"));
			news.setContent(re.getString("content"));
			news.setPublishDate(DateUtil.formatString(re.getString("publishDate"), "yyyy-MM-dd HH:mm:ss"));
			news.setAuthor(re.getString("author"));
			news.setTypeId(re.getInt("typeId"));
			news.setTypeName(re.getString("typeName"));
			news.setClick(re.getInt("click"));
			news.setIsHead(re.getInt("isHead"));
			news.setIsImage(re.getInt("isImage"));
			news.setImageName(PropertiesUtil.getValue("userImage")+re.getString("imageName"));
			news.setIsHot(re.getInt("isHot"));
		}
		return news;
	}
	
	
	public int newClick(Connection con,String newsId )throws Exception{
		String sql="update t_news set click=click+1 where newsId=?";
		PreparedStatement pstmt=con.prepareStatement(sql);
		pstmt.setString(1, newsId);
		return pstmt.executeUpdate();
	}
	
	public List<News> getUpAndDownPageId(Connection con,String newsId)throws Exception{
		List<News> upAndDownPage=new ArrayList<News>();
		String sql="select * from t_news where newsId<? order by newsId desc limit 1";
		PreparedStatement pstmt=con.prepareStatement(sql);
		pstmt.setString(1, newsId);
		ResultSet re=pstmt.executeQuery();
		if(re.next()){
			upAndDownPage.add(new News(re.getInt("newsId"),re.getString("title")));
		}else{
			upAndDownPage.add(new News(-1,""));
		}
		
		sql="select * from t_news where newsId>? order by newsId asc limit 1";
		pstmt=con.prepareStatement(sql);
		pstmt.setString(1, newsId);
		re=pstmt.executeQuery();
		if(re.next()){
			upAndDownPage.add(new News(re.getInt("newsId"),re.getString("title")));
		}else{
			upAndDownPage.add(new News(-1,""));
		}
		return upAndDownPage;
	}
	
	
	public boolean existNewsWithNewsTypeId(Connection con,String typeId)throws Exception{
		String sql="select * from t_news where typeId=?";
		PreparedStatement pstmt=con.prepareStatement(sql);
		pstmt.setString(1, typeId);
		ResultSet re=pstmt.executeQuery();
		if(re.next()){
			return true;
		}else{
			return false;
		}
	}
	
	public int newsAdd(Connection con,News news)throws Exception{
		String sql="insert into t_news values(null,?,?,now(),?,?,0,?,?,?,?)";
		PreparedStatement pstmt=con.prepareStatement(sql);
		pstmt.setString(1, news.getTitle());
		pstmt.setString(2, news.getContent());
		pstmt.setString(3, news.getAuthor());
		pstmt.setInt(4, news.getTypeId());
		pstmt.setInt(5, news.getIsHead());
		pstmt.setInt(6, news.getIsImage());
		pstmt.setString(7, news.getImageName());
		pstmt.setInt(8, news.getIsHot());
		return pstmt.executeUpdate();
	}
	
	public int newsUpdate(Connection con,News news)throws Exception{
		String sql="update t_news set title=?,content=?,author=?,typeId=?,isHead=?,isImage=?,imageName=?,isHot=? where newsId=?";
		PreparedStatement pstmt=con.prepareStatement(sql);
		pstmt.setString(1, news.getTitle());
		pstmt.setString(2, news.getContent());
		pstmt.setString(3, news.getAuthor());
		pstmt.setInt(4, news.getTypeId());
		pstmt.setInt(5, news.getIsHead());
		pstmt.setInt(6, news.getIsImage());
		pstmt.setString(7, news.getImageName());
		pstmt.setInt(8, news.getIsHot());
		pstmt.setInt(9, news.getNewsId());
		return pstmt.executeUpdate();
	}
	
	
	public int newsDelete(Connection con,String newsId)throws Exception{
		String sql="delete from t_news where newsId=?";
		PreparedStatement pstmt=con.prepareStatement(sql);
		pstmt.setString(1, newsId);
		return pstmt.executeUpdate();
	}
}
