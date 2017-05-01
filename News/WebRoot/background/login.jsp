<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>狗崽子新闻</title>
<!--                       CSS                       -->
<!-- Reset Stylesheet -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/background/resources/css/reset.css" type="text/css" media="screen" />
<!-- Main Stylesheet -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/background/resources/css/style.css" type="text/css" media="screen" />
<!-- Invalid Stylesheet. This makes stuff look pretty. Remove it if you want the CSS completely valid -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/background/resources/css/invalid.css" type="text/css" media="screen" />
<!--                       Javascripts                       -->
<!-- jQuery -->
<script type="text/javascript" src="${pageContext.request.contextPath}/background/resources/scripts/jquery-1.3.2.min.js"></script>
<!-- jQuery Configuration -->
<script type="text/javascript" src="${pageContext.request.contextPath}/background/resources/scripts/simpla.jquery.configuration.js"></script>
<!-- Facebox jQuery Plugin -->
<script type="text/javascript" src="${pageContext.request.contextPath}/background/resources/scripts/facebox.js"></script>
<!-- jQuery WYSIWYG Plugin -->
<script type="text/javascript" src="${pageContext.request.contextPath}/background/resources/scripts/jquery.wysiwyg.js"></script>
</head>
<script type="text/javascript">
	function checkForm(){
		var userName=document.getElementById("userName").value;
		var password=document.getElementById("password").value;
		if(userName==null||userName==""){
			document.getElementById("error").innerHTML="用户名不能为空！";
			return false;
		}
		if(password==null||password==""){
			document.getElementById("error").innerHTML="密码不能为空！";
			return false;
		}
		return true;
	}
	

</script>
<body id="login">
<div id="login-wrapper" class="png_bg">
  <div id="login-top">
  	<h2>狗崽子新闻-后台管理</h2>
  </div>
  <div id="login-content">
    <form action="${pageContext.request.contextPath}/user?action=login" method="post" onsubmit="return checkForm()">
      <p>
       	<label>用户名：</label>
        <input class="text-input" type="text" id="userName" name="userName" value="${userName }"/>
      </p>
      <div class="clear"></div>
      <p>
         <label>密码：</label>
        <input class="text-input" type="password" id="password" name="password" value="${password }"/>
      </p>
      <div class="clear"></div>
       <font id="error" color="red">${error }</font>   <input class="button" type="submit" value="登录" />
    </form>
  </div>
</div>
</body>
</html>
