package com.fanye.model;

import java.util.Date;

public class Comment {
	
	private int commentId;
	private int newsId=-1;
	private String newsTitle;
	private String content;
	private String userIP;
	private Date commentDate;
	
	
	
	public Comment() {
		super();
	}
	public Comment(int newsId, String content, String userIp) {
		super();
		this.newsId = newsId;
		this.content = content;
		this.userIP = userIp;
	}
	
	
	public String getNewsTitle() {
		return newsTitle;
	}
	public void setNewsTitle(String newsTitle) {
		this.newsTitle = newsTitle;
	}
	public int getCommentId() {
		return commentId;
	}
	public void setCommentId(int commentId) {
		this.commentId = commentId;
	}
	public int getNewsId() {
		return newsId;
	}
	public void setNewsId(int newsId) {
		this.newsId = newsId;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getUserIP() {
		return userIP;
	}
	public void setUserIP(String userIP) {
		this.userIP = userIP;
	}
	public Date getCommentDate() {
		return commentDate;
	}
	public void setCommentDate(Date commentDate) {
		this.commentDate = commentDate;
	}
	
	
}
