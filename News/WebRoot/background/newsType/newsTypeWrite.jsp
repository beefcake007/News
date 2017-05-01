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
		var newsTypeName=document.getElementById("newsTypeName").value;
		if(linkName==null||linkName==""){
			document.getElementById("error").innerHTML="新闻类别名称不能为空！";
			return false;
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
		<form action="newsType?action=save" method="post" onsubmit="return checkForm()">
			<table cellpadding="5">
				<tr>
					<td>
						<label>新闻类别名称：</label>
					</td>
					<td>
						<input type="text" class="form-control" id="typeName" name="typeName" value="${newsType.typeName }"/>
					</td>
				</tr>
	
				
				<tr>
					<td>
						<input type="hidden" id="newsTypeId" name="newsTypeId" value="${newsType.newsTypeId }"/>
					</td>
					<td>
						<input type="submit" class="btn btn-primary" value="保存新闻类别"/>&nbsp;&nbsp;
						<input type="button" class="btn btn-primary" value="返回" onclick="javascript:history.back()"/>&nbsp;&nbsp;<font id="error" color="red">${error }</font>
					</td>
				</tr>
			</table>
		</form>
	</div>
</div>
</body>
</html>