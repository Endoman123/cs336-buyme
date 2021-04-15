<!-- Reset Password Form -->
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="tf" tagdir="/WEB-INF/tags/forms" %>

<t:base title="Reset ${param.login}'s password">
    <h2>Password reset</h2>
    <tf:password-reset login="${param.login}" action="support/reset-password" />
</t:base>