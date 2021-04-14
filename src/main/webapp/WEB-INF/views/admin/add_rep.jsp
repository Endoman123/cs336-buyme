<!-- Account Addition View -->
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="tf" tagdir="/WEB-INF/tags/forms" %>

<t:base context="${pageContext.request.contextPath}" title="Add Customer Rep">
    <h2>New Customer Representative</h2>
    <tf:account action="admin/add_rep" />
</t:base>