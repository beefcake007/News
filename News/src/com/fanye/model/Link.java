package com.fanye.model;

public class Link {

	private int linkId;
	private String linkName;
	private String linkUrl;
	private String linkEmail;
	private int orderNum;
	
	
	public Link() {
		super();
	}
	
	
	public Link(String linkName, String linkUrl, String linkEmail, int orderNum) {
		super();
		this.linkName = linkName;
		this.linkUrl = linkUrl;
		this.linkEmail = linkEmail;
		this.orderNum = orderNum;
	}


	public int getLinkId() {
		return linkId;
	}
	public void setLinkId(int linkId) {
		this.linkId = linkId;
	}
	public String getLinkName() {
		return linkName;
	}
	public void setLinkName(String linkName) {
		this.linkName = linkName;
	}
	public String getLinkUrl() {
		return linkUrl;
	}
	public void setLinkUrl(String linkUrl) {
		this.linkUrl = linkUrl;
	}
	public String getLinkEmail() {
		return linkEmail;
	}
	public void setLinkEmail(String linkEmail) {
		this.linkEmail = linkEmail;
	}
	public int getOrderNum() {
		return orderNum;
	}
	public void setOrderNum(int orderNum) {
		this.orderNum = orderNum;
	}
	
	
	
}
