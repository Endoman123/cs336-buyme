<!-- Profile View -->
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="tf" tagdir="/WEB-INF/tags/forms" %>

<t:base title="Profile">
    <h2>Your Profile</h2>
    <tf:account-edit login="${user.login}" email="${user.email}" />
    <button onclick="askDelete()">Delete Account</a>

    <script>
        function askDelete() {
            if (confirm("Are you sure you want to delete your account, ${user.login}?") == true) {
                alert("Deleting ${user.login}!");
                fetch("./profile", {
                  method: "DELETE",
                  redirect: "follow"
                }).then(res => {
                    self.location = res.url;
                });
            }
        }    
    </script>
</t:base>