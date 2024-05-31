<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="css/login_page_style.css">
    <title>숙명식당 로그인</title>
    <script>
    function check() {
        if (document.getElementById("userID").value == "") {
            alert("아이디를 입력하세요");
            return false;
        }
        if (document.getElementById("userPassword").value == "") {
            alert("비밀번호를 입력하세요");
            return false;
        }
        return true; // true를 반환하여 폼이 제출되도록 함
    }
        function showError() {
            const urlParams = new URLSearchParams(window.location.search);
            if (urlParams.has('error')) {
                alert("아이디와 비밀번호가 올바르지 않습니다");
            }
        }
        
        window.onload = showError;
</script>

</head>
<style>
        html, body {
            margin: 0;
            padding: 0;
            width: 100%;
            height: 100%;
            display: flex;
            justify-content: center;
            align-items: center;
            background-color: #f0f0f0;
           }   
</style>

<body>

    <div class="login-container">
    <div class="logo-title">
        <svg width="35" height="35" viewBox="0 0 35 35" fill="none" xmlns="http://www.w3.org/2000/svg">
		<path d="M4.33001 0.194687C4.60983 0.0170535 4.94874 -0.0421766 5.27222 0.0300208C5.5957 0.102218 5.87727 0.299932 6.05501 0.579687L15.23 14.9997H19.7675L11.445 1.92469C11.267 1.64488 11.2074 1.30582 11.2794 0.982085C11.3513 0.65835 11.549 0.376464 11.8288 0.198437C12.1086 0.0204105 12.4476 -0.0391731 12.7714 0.032794C13.0951 0.104761 13.377 0.302384 13.555 0.582187L22.73 14.9997H33.8225C34.4725 14.9997 35 15.5247 35 16.1747V17.4997C35 19.2372 34.7475 20.9147 34.275 22.4997H0.725006C0.24276 20.8769 -0.00145076 19.1926 6.48324e-06 17.4997V16.1747C6.48324e-06 15.5247 0.525007 14.9997 1.17501 14.9997H12.2675L3.94501 1.92469C3.76737 1.64487 3.70814 1.30595 3.78034 0.982472C3.85254 0.65899 4.05025 0.377424 4.33001 0.199687M17.5 34.9997C14.1878 35.0004 10.9433 34.061 8.14378 32.2909C5.34423 30.5207 3.10454 27.9923 1.68501 24.9997H33.315C31.8955 27.9923 29.6558 30.5207 26.8562 32.2909C24.0567 34.061 20.8123 35.0004 17.5 34.9997Z" fill="#3D5576"/>
			</svg>
	<h1>숙명식당</h1>
	</div>
 <!-- 로고 이미지 -->  
        <form name ="loginForm" action="login_verify.jsp" method="post">
        
            <input type="text"  name="userID" id = "userID" placeholder="학번(아이디)" required>
            <input type="password" name="userPassword" id = "userPassword" placeholder="비밀번호" required>
            
			<label>
			<a href="lost_password.jsp">비밀번호 찾기</a>
			</label>
			
            <button type="submit" NAME="login" onclick = "check()">로그인</button>
            
        </form>
        
        <div style = "text-align: center;">
        <a href="register.jsp">회원가입</a>
        </div>
        
		
		

    </div>
    
</body>

</html>