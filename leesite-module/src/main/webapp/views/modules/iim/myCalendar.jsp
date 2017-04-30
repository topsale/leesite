<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/views/include/taglib.jsp"%>

<!DOCTYPE html>
<!--[if IE 8]> <html lang="zh" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="zh" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html>
<!--<![endif]-->
<!-- BEGIN HEAD -->
<head>
    <title>${fns:getConfig('productName')} | 我的日程</title>
    <meta name="decorator" content="default"/>

    <link href="${ctxStatic}/assets/global/plugins/fancybox/source/jquery.fancybox.css" rel="stylesheet" type="text/css" />
    <link href="${ctxStatic}/assets/global/plugins/fullcalendar/fullcalendar.min.css" rel="stylesheet" type="text/css" />
</head>

<body class="page-container-bg-solid page-header-fixed page-sidebar-closed-hide-logo">
<!-- BEGIN CONTAINER -->
<div class="page-container">
    <!-- BEGIN SIDEBAR -->
    <div class="page-sidebar-wrapper">
        <!-- BEGIN SIDEBAR -->
        <div class="page-sidebar navbar-collapse collapse">
            <!-- BEGIN SIDEBAR MENU -->
            <ul class="page-sidebar-menu" data-keep-expanded="false" data-auto-scroll="true" data-slide-speed="200">
                <li class="heading">
                    <h3 class="uppercase">功能菜单</h3>
                </li>
                <t:menu menu="${fns:getTopMenu()}"></t:menu>
            </ul>
            <!-- END SIDEBAR MENU -->
        </div>
        <!-- END SIDEBAR -->
    </div>
    <!-- END SIDEBAR -->
    <!-- BEGIN CONTENT -->
    <div class="page-content-wrapper">
        <!-- BEGIN CONTENT BODY -->
        <div class="page-content" style="padding-top: 0;">
            <div class="row">
                <div class="col-md-12">
                    <!-- BEGIN Portlet PORTLET-->
                    <div class="portlet light portlet-fit bordered calendar">
                        <div class="portlet-title">
                            <div class="caption">
                                <span class="caption-subject bold font-grey-gallery uppercase"> 我的日程 </span>
                            </div>
                        </div>
                        <div class="portlet-body">
                            <div id="my_calendar" class="has-toolbar"></div>
                        </div>
                    </div>
                    <!-- END GRID PORTLET-->
                </div>
            </div>
        </div>
        <!-- END CONTENT BODY -->
    </div>
    <!-- END CONTENT -->
</div>
<!-- END CONTAINER -->

<%@include file="/views/include/foot.jsp" %>
<script src="${ctxStatic}/assets/global/plugins/fancybox/source/jquery.fancybox.pack.js" type="text/javascript"></script>
<script src="${ctxStatic}/assets/global/plugins/fullcalendar/fullcalendar.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/assets/global/plugins/fullcalendar/lang/zh-cn.js" type="text/javascript"></script>
<script src="${ctxStatic}/assets/global/plugins/jquery-ui/jquery-ui.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/assets/global/plugins/jquery-ui/jquery.ui.datepicker.zh-CN.js" type="text/javascript"></script>
<script type="text/javascript">
    $(function () {
        var h = {};

        if ($('#my_calendar').parents(".portlet").width() <= 720) {
            $('#my_calendar').addClass("mobile");
            h = {
                left: 'title, prev, next',
                center: '',
                right: 'today,month,agendaWeek,agendaDay'
            };
        } else {
            $('#my_calendar').removeClass("mobile");
            h = {
                left: 'title',
                center: '',
                right: 'prev,next,today,month,agendaWeek,agendaDay'
            };
        }

        // 页面加载完初始化日历
        $('#my_calendar').fullCalendar({
            // 设置日历头部信息
            header: h,

            firstDay: 1, // 每行第一天为周一
            editable: true, // 启用拖动
            events: '${ctx}/iim/myCalendar/findList',
            // 点击某一天时促发
            dayClick: function (date, allDay, jsEvent, view) {
                // 新版本中使用 moment 调用，不再使用 $.fullCalendar.formatDate 的方式
//                var selDate = $.fullCalendar.formatDate(date, 'yyyy-MM-dd');
                var selDate = moment(date, 'DD.MM.YYYY').format('YYYY-MM-DD');
                $.fancybox({
                    'type': 'ajax',
                    'href': '${ctx}/iim/myCalendar/addform?date=' + selDate
                });
            },

            // 单击事件项时触发
            eventClick: function (calEvent, jsEvent, view) {
                $.fancybox({
                    'type': 'ajax',
                    'href': '${ctx}/iim/myCalendar/editform?id=' + calEvent.id
                });
            },

            // 拖动事件
            eventDrop: function (event, dayDelta, minuteDelta, allDay, revertFunc) {
                $.post("${ctx}/iim/myCalendar/drag", {
                    id: event.id,
                    daydiff: dayDelta,
                    minudiff: minuteDelta,
                    allday: allDay
                }, function (msg) {
                    if (msg != 1) {
                        alert(msg);
                        revertFunc(); //恢复原状
                    }
                });
            },

            // 日程事件的缩放
            eventResize: function (event, dayDelta, minuteDelta, revertFunc) {
                $.post("${ctx}/iim/myCalendar/resize", {
                    id: event.id,
                    daydiff: dayDelta,
                    minudiff: minuteDelta
                }, function (msg) {
                    if (msg != 1) {
                        alert(msg);
                        revertFunc();
                    }
                });
            },

            selectable: true, // 允许用户拖动
            select: function (startDate, endDate, allDay, jsEvent, view) {
                var start = moment(startDate, 'DD.MM.YYYY').format('YYYY-MM-DD');
                var end = moment(endDate, 'DD.MM.YYYY').format('YYYY-MM-DD');
                $.fancybox({
                    'type': 'ajax',
                    'href': '${ctx}/iim/myCalendar/addform?date=' + start + '&end=' + end
                });
            }
        });
    });
</script>
</body>
</html>