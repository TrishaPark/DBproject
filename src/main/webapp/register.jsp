<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="css/register_style.css">
    <title>숙명식당 회원가입</title>
    
    <script>

    function checkUserId() {
        var userId = document.getElementById("user_id").value;
        if (userId === "") {
            document.getElementById("user_id_check").innerText = "아이디를 입력하세요.";
            return;
        }

        var xhr = new XMLHttpRequest();
        xhr.open("POST", "CheckUserIdServlet", true);
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

        xhr.onreadystatechange = function() {
            if (xhr.readyState === 4 && xhr.status === 200) {
                document.getElementById("user_id_check").innerText = xhr.responseText;
            }
        };

        xhr.send("user_id=" + encodeURIComponent(userId));
    }

    function blank_check() {
        if (document.getElementById("user_name").value == "") {
            alert("이름을 입력하세요");
            return false;
        }
        if (document.getElementById("user_id").value == "") {
            alert("아이디(학번)를 입력하세요");
            return false;
        }
        if (document.getElementById("user_password").value == "") {
            alert("비밀번호를 입력하세요");
            return false;
        }

        var userIdCheckText = document.getElementById("user_id_check").innerText;
        if (userIdCheckText === "이미 사용 중인 아이디입니다.") {
            alert("아이디가 중복되었습니다. 다른 아이디를 사용하세요.");
            return false;
        }

        return true; // 폼을 제출합니다.
    }

    function registerErr() {
        const urlParams = new URLSearchParams(window.location.search);
        if (urlParams.has('register_err')) {
            alert("회원가입 실패...\n 입력내용을 다시 한번 확인해주세요.");
        }
    }

    window.onload = function() {
        registerErr();
    }
  
    </script>
    
</head>
<style>
        .register-container a {
        	display : block;
            color: #357ab8;
            text-decoration: none;
            font-size: 14px;
            font-family: 'Noto Sans';
			font-style: normal;      
            text-align: center; 
            
            margin-top: 15px;
            /* 가운데 정렬 */
        }
        
        
        </style>

<body>

    <div class="register-container">
    <div class="logo-title">
        <svg width="35" height="35" viewBox="0 0 35 35" fill="none" xmlns="http://www.w3.org/2000/svg">
		<path d="M4.33001 0.194687C4.60983 0.0170535 4.94874 -0.0421766 5.27222 0.0300208C5.5957 0.102218 5.87727 0.299932 6.05501 0.579687L15.23 14.9997H19.7675L11.445 1.92469C11.267 1.64488 11.2074 1.30582 11.2794 0.982085C11.3513 0.65835 11.549 0.376464 11.8288 0.198437C12.1086 0.0204105 12.4476 -0.0391731 12.7714 0.032794C13.0951 0.104761 13.377 0.302384 13.555 0.582187L22.73 14.9997H33.8225C34.4725 14.9997 35 15.5247 35 16.1747V17.4997C35 19.2372 34.7475 20.9147 34.275 22.4997H0.725006C0.24276 20.8769 -0.00145076 19.1926 6.48324e-06 17.4997V16.1747C6.48324e-06 15.5247 0.525007 14.9997 1.17501 14.9997H12.2675L3.94501 1.92469C3.76737 1.64487 3.70814 1.30595 3.78034 0.982472C3.85254 0.65899 4.05025 0.377424 4.33001 0.199687M17.5 34.9997C14.1878 35.0004 10.9433 34.061 8.14378 32.2909C5.34423 30.5207 3.10454 27.9923 1.68501 24.9997H33.315C31.8955 27.9923 29.6558 30.5207 26.8562 32.2909C24.0567 34.061 20.8123 35.0004 17.5 34.9997Z" fill="#3D5576"/>
			</svg>
	<h1>숙명식당</h1>
	</div>
 <!-- 로고 이미지 -->       
        <form name="registerForm" action="register_user.jsp" method="post" onsubmit="return blank_check();">
            
            <input type="text" id="user_name" name="user_name" placeholder="이름" required>
            <input type="text" id="user_id" name="user_id" placeholder="학번(아이디)" onkeyup="checkUserId()" required>
       
            <span id="user_id_check" style="color: #3D5576; display: inline-block; margin-right: 200px; font-family: 'Noto Sans'; font-size : 14px"></span>
            
            <input type="text" id="user_password" name="user_password" placeholder="비밀번호" required>
            <input type="text" id="nickname" name="nickname" placeholder="닉네임(선택)" >
           
            
			
			
            <button type="submit" value = "submit" name ="register">회원가입</button>
            
           
        </form>
        
        <a href="login_page.jsp">이전화면</a> 
        
          
        
	 </div>
</body>

</html>
            