<!-- Reset Password Form -->
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="tf" tagdir="/WEB-INF/tags/forms" %>

<t:base title="Ask a Question">
    <h2>Ask a Question</h2>
    <tf:support-ask login="${user.login}" />
</t:base>