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
	function newsTypeDelete(newsTypeId){
		if(confirm("确认要删除这条新闻类别吗？")){
			$.post("newsType?action=delete",{newsTypeId:newsTypeId},
				function(result){
					var result=eval('('+result+')');
					if(result.success){
						alert("删除成功!");
						window.location.href="${pageContext.request.contextPath }/newsType?action=backList";
					}else{
						alert(result.errorMsg);
					}
					
				});
		}
	}
</script>
</head>
<body>
<div class="data_list backMain">
	<div class="dataHeader navi">
		${navCode }
	</div>
	<div class="data_content">
		<table class="table table-hover table-bordered">
			<tr>
				<th>序号</th>
				<th>新闻类别名称</th>
				<th>操作</th>
			</tr>
			
			<c:forEach var="newsTypeBack" items="${newsTypeBackList }" varStatus="status">
				<tr>
					<td>${status.index+1 }</td>
					<td>${newsTypeBack.typeName }</td>
					<td><button type="button" class="btn btn-info btn-primary btn-xs" onclick="javascript:window.location='newsType?action=preSave&newsTypeId=${newsTypeBack.newsTypeId}'">修改</button>&nbsp;&nbsp;<button type="button" class="btn btn-danger btn-primary btn-xs" onclick="newsTypeDelete(${newsTypeBack.newsTypeId})">删除</button></td>
				</tr>
			</c:forEach>
		</table>
	</div>
</div>
</body>
</html>