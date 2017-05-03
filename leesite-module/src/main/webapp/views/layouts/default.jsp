<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/views/include/taglib.jsp"%>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>

<!DOCTYPE html>
<!--[if IE 8]> <html lang="zh" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="zh" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html>
<!--<![endif]-->
<!-- BEGIN HEAD -->
<head>
	<title><sitemesh:title/></title>
	<%@include file="/views/include/head.jsp" %>
	<sitemesh:head/>
</head>
<!-- END HEAD -->

<body id="<sitemesh:getProperty property='body.id'/>" class="<sitemesh:getProperty property='body.class'/>" style="<sitemesh:getProperty property='body.style'/>">
<!-- BEGIN HEADER -->
<div class="page-header navbar navbar-fixed-top" style="height: 76px;">
	<!-- BEGIN HEADER INNER -->
	<div class="page-header-inner">
		<!-- BEGIN LOGO -->
		<div class="page-logo">
			<a href="${ctx}" style="text-decoration:none; margin-top: -2px;">
				<h4 class="logo-default font-white bold">${fns:getConfig('productName')}</h4>
			</a>
			<div class="menu-toggler sidebar-toggler">
				<!-- DOC: Remove the above "hide" to enable the sidebar toggler button on header -->
			</div>
		</div>
		<!-- END LOGO -->
		<!-- BEGIN RESPONSIVE MENU TOGGLER -->
		<a href="javascript:;" class="menu-toggler responsive-toggler" data-toggle="collapse" data-target=".navbar-collapse"> </a>
		<!-- END RESPONSIVE MENU TOGGLER -->
		<!-- BEGIN PAGE TOP -->
		<div class="page-top">
			<!-- BEGIN HEADER SEARCH BOX -->
			<!-- DOC: Apply "search-form-expanded" right after the "search-form" class to have half expanded search box -->
			<%--<form class="search-form" action="${ctx}" method="GET">--%>
				<%--<div class="input-group">--%>
					<%--<input type="text" class="form-control input-sm" placeholder="搜索..." name="query">--%>
					<%--<span class="input-group-btn">--%>
								<%--<a href="javascript:;" class="btn submit">--%>
									<%--<i class="icon-magnifier"></i>--%>
								<%--</a>--%>
							<%--</span>--%>
				<%--</div>--%>
			<%--</form>--%>
			<!-- END HEADER SEARCH BOX -->
			<!-- BEGIN TOP NAVIGATION MENU -->
			<div class="top-menu">
				<ul class="nav navbar-nav pull-right">
					<li class="separator hide"> </li>
					<!-- BEGIN NOTIFICATION DROPDOWN -->
					<!-- DOC: Apply "dropdown-dark" class after below "dropdown-extended" to change the dropdown styte -->
					<!-- DOC: Apply "dropdown-hoverable" class after "dropdown" and remove data-toggle="dropdown" data-hover="dropdown" data-close-others="true" attributes to enable hover dropdown mode -->
					<!-- DOC: Remove "dropdown-hoverable" and add data-toggle="dropdown" data-hover="dropdown" data-close-others="true" attributes to the below A element with dropdown-toggle class -->
					<li class="dropdown dropdown-extended dropdown-notification dropdown-dark" id="header_notification_bar">
						<a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
							<i class="icon-bell"></i>
							<span class="badge badge-success"> ${fns:noReadNotifyCount()} </span>
						</a>
						<ul class="dropdown-menu">
							<li class="external">
								<h3>您有
									<span class="bold">${fns:noReadNotifyCount()} 条</span> 未读消息</h3>
								<a href="${ctx}/oa/oaNotify/self/">全部</a>
							</li>
						</ul>
					</li>
					<!-- END NOTIFICATION DROPDOWN -->
					<li class="separator hide"> </li>
					<!-- BEGIN INBOX DROPDOWN -->
					<!-- DOC: Apply "dropdown-dark" class after below "dropdown-extended" to change the dropdown styte -->
					<li class="dropdown dropdown-extended dropdown-inbox dropdown-dark" id="header_inbox_bar">
						<a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
							<i class="icon-envelope-open"></i>
							<span class="badge badge-danger"> ${fns:noReadMailCount()} </span>
						</a>
						<ul class="dropdown-menu">
							<li class="external">
								<h3>您有
									<span class="bold">${fns:noReadMailCount()} 条</span> 未读邮件</h3>
								<a href="${ctx}/iim/mailBox/list?orderBy=sendtime desc">全部</a>
							</li>
						</ul>
					</li>
					<!-- END INBOX DROPDOWN -->
					<!-- BEGIN USER LOGIN DROPDOWN -->
					<!-- DOC: Apply "dropdown-dark" class after below "dropdown-extended" to change the dropdown styte -->
					<li class="dropdown dropdown-user dropdown-dark">
						<a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
							<span class="username username-hide-on-mobile"> ${fns:getUser().name} </span>
							<!-- DOC: Do not remove below empty space(&nbsp;) as its purposely used -->
							<c:choose>
								<c:when test="${not empty fns:getUser().photo}">
									<img alt="" class="img-circle" src="${fns:getUser().photo}" />
								</c:when>
								<c:otherwise>
									<img alt="" class="img-circle" src="${ctxStatic}/assets/layouts/layout/img/avatar.png" />
								</c:otherwise>
							</c:choose>
						</a>
						<ul class="dropdown-menu dropdown-menu-default">
							<li>
								<a href="${ctx}/sys/user/imageEdit">
									<i class="icon-picture"></i> 修改头像 </a>
							</li>
							<li>
								<a href="${ctx}/sys/user/info">
									<i class="icon-user"></i> 我的资料 </a>
							</li>
							<li>
								<a href="${ctx}/iim/mailBox/list?orderBy=sendtime desc">
									<i class="icon-envelope-open"></i> 我的信箱
									<span class="badge badge-danger"> ${fns:noReadMailCount()} </span>
								</a>
							</li>
							<li>
								<a href="${ctx}/iim/contact/index">
									<i class="icon-notebook"></i> 我的通讯录
								</a>
							</li>
							<li class="divider"> </li>
							<li>
								<a href="${ctx}/logout">
									<i class="icon-key"></i> 安全退出 </a>
							</li>
						</ul>
					</li>
					<!-- END USER LOGIN DROPDOWN -->
				</ul>
			</div>
			<!-- END TOP NAVIGATION MENU -->
		</div>
		<!-- END PAGE TOP -->
	</div>
	<!-- END HEADER INNER -->
</div>
<!-- END HEADER -->

<!-- BEGIN HEADER & CONTENT DIVIDER -->
<div class="clearfix"> </div>
<!-- END HEADER & CONTENT DIVIDER -->
<sitemesh:body/>

<!-- 页面加载动画效果 -->
<script src="${ctxStatic}/assets/global/scripts/loader/loading.js" type="text/javascript"></script>
<%--<script src="${ctxStatic}/assets/global/scripts/pace/pace.min.js" type="text/javascript"></script>--%>
<%--<script src="${ctxStatic}/assets/global/scripts/pace/loadpace.js" type="text/javascript"></script>--%>
</body>
</html>