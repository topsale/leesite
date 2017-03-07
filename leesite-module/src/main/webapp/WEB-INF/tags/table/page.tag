<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/views/include/taglib.jsp"%>
<%@ attribute name="page" type="com.funtl.leesite.common.persistence.Page" required="true"%>
<%-- 表格分页工具栏，使用方法： 原样输出page --%>
${page}
<!-- pagination的css样式设定-->
<style>
.fixed-table-pagination div.pagination,
.fixed-table-pagination div.pagination-roll,
.fixed-table-pagination .pagination-detail {
    margin-top: 0px;
    margin-bottom: 10px;
}

.fixed-table-pagination div.pagination-roll .pagination,
.fixed-table-pagination div.pagination .pagination {
    margin: 0;
}

.fixed-table-pagination .pagination a {
    padding: 6px 12px;
    line-height: 1.428571429;
}

.fixed-table-pagination .pagination-info {
    line-height: 34px;
    margin-right: 5px;
}

.fixed-table-pagination .btn-group {
    position: relative;
    display: inline-block;
    vertical-align: middle;
}

.fixed-table-pagination .dropup .dropdown-menu {
    margin-bottom: 0;
}

.fixed-table-pagination .page-list {
    display: inline-block;
}

</style>