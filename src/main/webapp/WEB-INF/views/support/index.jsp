<!-- Customer Support index -->
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="tf" tagdir="/WEB-INF/tags/forms" %>
<%@ taglib prefix="u" uri="/WEB-INF/taglibs/util.tld" %>

<t:base title="Customer Support">
    <h2>Customer Support</h2>
    <form method="get" action="./support">
        <label for="search">Search</label>
        <input type="text" name="search" placeholder="Enter search text here" value="${param.search}" required>
        <button type="submit">Search</button>
    </form>

    <u:get-questions searchQuery="${param.search}">
        <div class="questions__question">
            <h3>Question by ${question.euLogin}</h3>
            <a href="./support/view?questionID=${question.id}">${question.questionText}</a>
        </div>
    </u:get-questions>
</t:base>