<!-- Edit Profile View -->
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="tf" tagdir="/WEB-INF/tags/forms" %>

<t:base title="Profile">
    <h2>Edit Profile Information</h2>
    <tf:account-edit login="${user.login}" email="${user.email}" />
</t:base>