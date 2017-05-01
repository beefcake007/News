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

	function checkChange(){
		if(document.getElementById("isImage").checked){
			$("#hdtp").show();	
		}else{
			$("#hdtp").hide();
		}
	}
	
	function checkForm(){
		var title=document.getElementById("title").value;
		var author=document.getElementById("author").value;
		var typeId=document.getElementById("typeId").value;
		var isImage=document.getElementById("isImage").checked;
		var content=CKEDITOR.instances.content.getData();
		if(title==null||title==""){
			document.getElementById("error").innerHTML="新闻标题不能为空！";
			return false;
		}
		if(author==null||author==""){
			document.getElementById("error").innerHTML="作者不能为空！";
			return false;
		}
		if(typeId==null||typeId==""){
			document.getElementById("error").innerHTML="请选择新闻类别！";
			return false;
		}
		if(content==null||content==""){
			document.getElementById("error").innerHTML="新闻内容不能为空！";
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
		<form action="news?action=save" method="post" enctype="multipart/form-data" onsubmit="return checkForm()">
			<table cellpadding="5" width="100%">
				<tr>
					<td width="80px">
						<label>新闻标题：</label>
					</td>
					<td>
						<input type="text" class="form-control" id="title" name="title" value="${news.title }"/>
					</td>
				</tr>
				<tr>
					<td>
						<label>新闻作者：</label>
					</td>
					<td>
						<input type="text" class="form-control" id="author" name="author" value="${news.author }"/>
					</td>
				</tr>
				<tr>
					<td>
						<label>新闻类别：</label>
					</td>
					<td>
						<select id="typeId" class="form-control" name="typeId">
							<option value="">请选择新闻类别</option>
							<c:forEach var="newsType" items="${newsTypeList }">
								<option value="${newsType.newsTypeId }" ${newsType.newsTypeId==news.typeId?'selected':'' }>${newsType.typeName }</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<td>
						<label>新闻属性：</label>
					</td>
					<td>
						<label class="checkbox-inline">
						  <input type="checkbox" id="isHead" name="isHead" value="1" ${news.isHead==1?'checked':'' }> 头条
						</label>
						<label class="checkbox-inline">
						  <input type="checkbox" id="isImage" name="isImage" value="1" onclick="checkChange()" ${news.isImage==1?'checked':'' }> 幻灯
						</label>
						<label class="checkbox-inline">
						  <input type="checkbox" id="isHot" name="isHot" value="3" ${news.isHot==1?'checked':'' }> 热点
						</label>
					</td>
				</tr>
				<tr id="hdtp" style="display:none;">
					<td>
						<label>幻灯图片：</label>
					</td>
					<td>
						<input type="file" id="picFile" name="picFile"/>
						<input type="hidden" id="imageName" name="imageName" value="${news.imageName }">
					</td>
				</tr>
				<tr>
					<td valign="top">
						<label>新闻内容：</label>
					</td>
					<td>
						<textarea class="ckeditor" id="content" name="content">${news.content }</textarea>
					</td>
				</tr>
				<tr>
					<td>
						<input type="hidden" id="newsId" name="newsId" value="${news.newsId }"/>
					</td>
					<td>
						<input type="submit" class="btn btn-primary" value="保存新闻"/>&nbsp;&nbsp;
						<input type="button" class="btn btn-primary" value="返回" onclick="javascript:history.back()"/>&nbsp;&nbsp;<font id="error" color="red">${error }</font>
					</td>
				</tr>
			</table>
		</form>
	</div>
</div>
</body>
</html>

<script>
	if('${news.isImage}'==1){
		$("#hdtp").show();
	}
	
</script>