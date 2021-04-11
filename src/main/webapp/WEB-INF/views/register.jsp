<!-- Register View -->
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="tf" tagdir="/WEB-INF/tags/forms" %>

<t:base context="${pageContext.request.contextPath}" title="Register">
    <h2>Register</h2>
    <tf:account action="register" />
</t:base>