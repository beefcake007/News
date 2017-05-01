<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  <link href="${pageContext.request.contextPath }/style/news.css" rel="stylesheet">
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>狗崽子新闻</title>
<script type="text/javascript">
function checkForm(){
		var linkName=document.getElementById("linkName").value;
		var linkUrl=document.getElementById("linkUrl").value;
		var linkEmail=document.getElementById("linkEmail").value;
		var orderNum=document.getElementById("orderNum").value;
		if(linkName==null||linkName==""){
			document.getElementById("error").innerHTML="链接名称不能为空！";
			return false;
		}
		if(linkUrl==null||linkUrl==""){
			document.getElementById("error").innerHTML="链接地址不能为空！";
			return false;
		}
		if(linkEmail==null||linkEmail==""){
			document.getElementById("error").innerHTML="联系人邮件不能为空！";
			return false;
		}
		if(orderNum==null||orderNum==""){
			document.getElementById("error").innerHTML="排列顺序不能为空！";
			return false;
		}else{
			 var type="^[0-9]*[1-9][0-9]*$"; 
		     var re=new RegExp(type); 
	         if(orderNum.match(re)==null){ 
	           alert("排列顺序必须为正整数!"); 
	           return false;
	        }
			return true;
		}
		return true;
	}
</script>

<style type="text/css">
	table td{padding:5px;}
</style>
</head>
<body>
<div class="data_list backMain">
	<div class="dataHeader navi">
		${navCode }
	</div>
	<div class="data_content">
		<form action="link?action=save" method="post" onsubmit="return checkForm()">
			<table cellpadding="5">
				<tr>
					<td>
						<label>链接名称：</label>
					</td>
					<td>
						<input type="text" class="form-control" id="linkName" name="linkName" value="${link.linkName }"/>
					</td>
				</tr>
				<tr>
					<td>
						<label>链接地址：</label>
					</td>
					<td>
						<input type="text" class="form-control" id="linkUrl" name="linkUrl" value="${link.linkUrl }"/>
					</td>
				</tr>
				<tr>
					<td>
						<label>联系人邮件：</label>
					</td>
					<td>
						<input type="text" class="form-control" id="linkEmail" name="linkEmail" value="${link.linkEmail }"/>
					</td>
				</tr>
				<tr>
					<td>
						<label>排列顺序：</label>
					</td>
					<td>
						<input type="text" class="form-control" id="orderNum" name="orderNum" value="${link.orderNum }"/>
					</td>
				</tr>
				<tr>
					<td>
						<input type="hidden" id="linkId" name="linkId" value="${link.linkId }"/>
					</td>
					<td>
						<input type="submit" class="btn btn-primary" value="保存友情链接"/>&nbsp;&nbsp;
						<input type="button" class="btn btn-primary" value="返回" onclick="javascript:history.back()"/>&nbsp;&nbsp;<font id="error" color="red">${error }</font>
					</td>
				</tr>
			</table>
		</form>
	</div>
</div>
</body>
</html>