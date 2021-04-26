<!-- Profile View -->
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="tf" tagdir="/WEB-INF/tags/forms" %>
<%@ taglib prefix="u" uri="/WEB-INF/taglibs/util.tld" %>

<t:base title="Profile">
    <h2>My Profile</h2>
    <div class="profile__info">
        <p><b>Login:</b> ${user.login}</p>
        <p><b>E-Mail:</b> ${user.email}</p>
    </div>
    <div class="profile__auctions">
        <h3>Auctions Won</h3>
        <u:get-auctions winner="${user.login}">
           <div class="auctions__auction">
                <p>${auction.closeDate}</p>
                <p>${auction.name}: ${auction.finalPrice}</p>
           </div>
        </u:get-auctions>
    </div>
</t:base>