<!-- Manage User Form -->
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="tf" tagdir="/WEB-INF/tags/forms" %>

<t:base title="Manage ${editUser.login}">
    <h2>Manage ${param.login}</h2>
    <tf:account-edit login="${editUser.login}" email="${editUser.email}" />
    <button onclick="askDelete()">Delete Account</a>

    <script>
        function askDelete() {
            if (confirm("Are you sure you want to delete ${editUser.login}?") == true) {
                alert("Deleting ${editUser.login} !");
                fetch("./support/manage/user?login=${editUser.login}", {
                  method: "DELETE",
                  redirect: "follow"
                }).then(res => {
                    self.location = res.url;
                });
            }
        }    
    </script>
</t:base>