package com.fanye.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.fanye.model.Link;


public class LinkDao {

	
	public List<Link> linkList(Connection con,String sql)throws Exception{
		List<Link> linkList=new ArrayList<Link>();
		PreparedStatement pstmt=con.prepareStatement(sql);
		ResultSet re=pstmt.executeQuery();
		while(re.next()){
			Link link=new Link();
			link.setLinkId(re.getInt("linkId"));
			link.setLinkName(re.getString("linkName"));
			link.setLinkUrl(re.getString("linkUrl"));
			link.setLinkEmail(re.getString("linkEmail"));
			link.setOrderNum(re.getInt("orderNum"));
			linkList.add(link);
		}
		return linkList;
	}
	
	public int linkAdd(Connection con,Link link)throws Exception{
		String sql="insert into t_link values(null,?,?,?,?)";
		PreparedStatement pstmt=con.prepareStatement(sql);
		pstmt.setString(1, link.getLinkName());
		pstmt.setString(2, link.getLinkUrl());
		pstmt.setString(3, link.getLinkEmail());
		pstmt.setInt(4, link.getOrderNum());
		return pstmt.executeUpdate();
	}
	
	public int linkUpdate(Connection con,Link link)throws Exception{
		String sql="update t_link set linkName=?,linkUrl=?,linkEmail=?,orderNum=? where linkId=?";
		PreparedStatement pstmt=con.prepareStatement(sql);
		pstmt.setString(1, link.getLinkName());
		pstmt.setString(2, link.getLinkUrl());
		pstmt.setString(3, link.getLinkEmail());
		pstmt.setInt(4, link.getOrderNum());
		pstmt.setInt(5, link.getLinkId());
		return pstmt.executeUpdate();
	}
	
	public int linkDelete(Connection con,String linkId)throws Exception{
		String sql="delete from t_link where linkId=?";
		PreparedStatement pstmt=con.prepareStatement(sql);
		pstmt.setString(1, linkId);
		return pstmt.executeUpdate();
	}
	
	public Link getLinkById(Connection con,String linkId)throws Exception{
		String sql="select * from t_link where linkId=?";
		PreparedStatement pstmt=con.prepareStatement(sql);
		pstmt.setString(1, linkId);
		ResultSet re=pstmt.executeQuery();
		Link link=new Link();
		while(re.next()){
			link.setLinkId(re.getInt("linkId"));
			link.setLinkName(re.getString("linkName"));
			link.setLinkUrl(re.getString("linkUrl"));
			link.setLinkEmail(re.getString("linkEmail"));
			link.setOrderNum(re.getInt("orderNum"));
		}
		return link;
	}
}
