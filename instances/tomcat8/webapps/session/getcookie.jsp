<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%
Cookie[] cookies = request.getCookies();
Cookie cookie = null;

if(cookies !=null){
 for(int i=0;i<cookies.length;i++){
  cookie = cookies[i]; %>
 쿠키 이름 : <%=cookie.getName() %>, 쿠키 값 : <%=cookie.getValue() %>, 쿠키나이 : <%=cookie.getMaxAge() %>
 <BR>
 <%
 }
}

%>
<button onclick="cookielist()";></button>
<script>

function setCookie(cname, cvalue, exdays) {
    var d = new Date();
    d.setTime(d.getTime() + (exdays * 24 * 60 * 60 * 1000));
    var expires = "expires="+d.toUTCString();
    document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
}

function getCookie(cname) {
    var name = cname + "=";
    var ca = document.cookie.split(';');
    for(var i = 0; i < ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0) == ' ') {
            c = c.substring(1);
        }
        if (c.indexOf(name) == 0) {
            return c.substring(name.length, c.length);
        }
    }
    return "";
}

function checkCookie() {
    var user = getCookie("username");
    if (user != "") {
        alert("Welcome again " + user);
    } else {
        user = prompt("Please enter your name:", "");
        if (user != "" && user != null) {
            setCookie("username", user, 365);
        }
    }
}

function cookielist(){

console.log(document.cookie);
}
</script>

