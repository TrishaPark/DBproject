document.addEventListener("DOMContentLoaded", function() {
    // western1 버튼 클릭 시 모달 띄우기
    document.querySelector(".menu-item-card1").addEventListener("click", function() {
        openModal("western1");
    });

    // western2 버튼 클릭 시 모달 띄우기
    document.querySelector(".menu-item-card2").addEventListener("click", function() {
        openModal("western2");
    });
	// western3 버튼 클릭 시 모달 띄우기
    document.querySelector(".menu-item-card3").addEventListener("click", function() {
        openModal("western3");
    });

    // cwestern4 버튼 클릭 시 모달 띄우기
    document.querySelector(".menu-item-card4").addEventListener("click", function() {
        openModal("western4");
    });
    // western5 버튼 클릭 시 모달 띄우기
    document.querySelector(".menu-item-card5").addEventListener("click", function() {
        openModal("western5");
    });

    // western6 버튼 클릭 시 모달 띄우기
    document.querySelector(".menu-item-card6").addEventListener("click", function() {
        openModal("western6");
    });
    // western7 버튼 클릭 시 모달 띄우기
    document.querySelector(".menu-item-card7").addEventListener("click", function() {
        openModal("western7");
    });
    // western8 버튼 클릭 시 모달 띄우기
    document.querySelector(".menu-item-card8").addEventListener("click", function() {
        openModal("western8");
    });
    // western9 버튼 클릭 시 모달 띄우기
    document.querySelector(".menu-item-card9").addEventListener("click", function() {
        openModal("western9");
    });
    // western10 버튼 클릭 시 모달 띄우기
    document.querySelector(".menu-item-card10").addEventListener("click", function() {
        openModal("western10");
    });
    // western11 버튼 클릭 시 모달 띄우기
    document.querySelector(".menu-item-card11").addEventListener("click", function() {
        openModal("western11");
    });
    // western12 버튼 클릭 시 모달 띄우기
    document.querySelector(".menu-item-card12").addEventListener("click", function() {
        openModal("western12");
    });
    // western13 버튼 클릭 시 모달 띄우기
    document.querySelector(".menu-item-card13").addEventListener("click", function() {
        openModal("western13");
    });
    // western14 버튼 클릭 시 모달 띄우기
    document.querySelector(".menu-item-card14").addEventListener("click", function() {
        openModal("western14");
    });
    // western15 버튼 클릭 시 모달 띄우기
    document.querySelector(".menu-item-card15").addEventListener("click", function() {
        openModal("western15");
    });
    // western16 버튼 클릭 시 모달 띄우기
    document.querySelector(".menu-item-card16").addEventListener("click", function() {
        openModal("western16");
    });
    // western17 버튼 클릭 시 모달 띄우기
    document.querySelector(".menu-item-card17").addEventListener("click", function() {
        openModal("western17");
    });
    // western18 버튼 클릭 시 모달 띄우기
    document.querySelector(".menu-item-card18").addEventListener("click", function() {
        openModal("western18");
    });
    // 모달을 여는 함수
    function openModal(modalId) {
        var modal = document.getElementById(modalId);
        modal.style.display = "block";
    }

    // 모달을 닫는 함수
    window.closeModal = function(modalId) {
        var modal = document.getElementById(modalId);
        modal.style.display = "none";
    };

    // 모달 외부를 클릭했을 때 모달을 닫기
    window.onclick = function(event) {
        if (event.target.classList.contains("modal")) {
            event.target.style.display = "none";
        }
    };
    
    // 장바구니 버튼 클릭 시 이벤트 처리
    document.getElementById('addToCartwestern1').addEventListener('click', function() {
        var quantity = document.getElementById('western1Quantity').value;
        alert('돈까스 ' + quantity + '개가 장바구니에 추가되었습니다.');
        closeModal('western1');
    });
    document.getElementById('addToCartwestern2').addEventListener('click', function() {
        var quantity = document.getElementById('western2Quantity').value;
        alert('가라아게카레 ' + quantity + '개가 장바구니에 추가되었습니다.');
        closeModal('western2');
    });
    document.getElementById('addToCartwestern3').addEventListener('click', function() {
        var quantity = document.getElementById('western3Quantity').value;
        alert('소시지카레 ' + quantity + '개가 장바구니에 추가되었습니다.');
        closeModal('western3');
    });
    document.getElementById('addToCartwestern4').addEventListener('click', function() {
        var quantity = document.getElementById('western4Quantity').value;
        alert('우동+미니돈까스 ' + quantity + '개가 장바구니에 추가되었습니다.');
        closeModal('western4');
    });
    document.getElementById('addToCartwestern5').addEventListener('click', function() {
        var quantity = document.getElementById('western5Quantity').value;
        alert('냉우동+미니돈까스 ' + quantity + '개가 장바구니에 추가되었습니다.');
        closeModal('western5');
    });
    document.getElementById('addToCartwestern6').addEventListener('click', function() {
        var quantity = document.getElementById('western6Quantity').value;
        alert('쫄면+미니돈까스 ' + quantity + '개가 장바구니에 추가되었습니다.');
        closeModal('western6');
    });
    document.getElementById('addToCartwestern7').addEventListener('click', function() {
        var quantity = document.getElementById('western7Quantity').value;
        alert('우동+가라아게(5pc) ' + quantity + '개가 장바구니에 추가되었습니다.');
        closeModal('western7');
    });
    document.getElementById('addToCartwestern8').addEventListener('click', function() {
        var quantity = document.getElementById('western8Quantity').value;
        alert('쫄면+가라아게(5pc) ' + quantity + '개가 장바구니에 추가되었습니다.');
        closeModal('western8');
    });
    document.getElementById('addToCartwestern9').addEventListener('click', function() {
        var quantity = document.getElementById('western9Quantity').value;
        alert('냉우동+가라아게(5pc) ' + quantity + '개가 장바구니에 추가되었습니다.');
        closeModal('western9');
    });
    document.getElementById('addToCartwestern10').addEventListener('click', function() {
        var quantity = document.getElementById('western7Quantity').value;
        alert('일반라면 ' + quantity + '개가 장바구니에 추가되었습니다.');
        closeModal('western7');
    });
    document.getElementById('addToCartwestern11').addEventListener('click', function() {
        var quantity = document.getElementById('western11Quantity').value;
        alert('매운라면 ' + quantity + '개가 장바구니에 추가되었습니다.');
        closeModal('western11');
    });
    document.getElementById('addToCartwestern12').addEventListener('click', function() {
        var quantity = document.getElementById('western12Quantity').value;
        alert('순두부라면 ' + quantity + '개가 장바구니에 추가되었습니다.');
        closeModal('western12');
    });
    document.getElementById('addToCartwestern13').addEventListener('click', function() {
        var quantity = document.getElementById('western13Quantity').value;
        alert('얼큰해장라면 ' + quantity + '개가 장바구니에 추가되었습니다.');
        closeModal('western13');
    });
    document.getElementById('addToCartwestern14').addEventListener('click', function() {
        var quantity = document.getElementById('western14Quantity').value;
        alert('부대라면 ' + quantity + '개가 장바구니에 추가되었습니다.');
        closeModal('western14');
    });
    document.getElementById('addToCartwestern15').addEventListener('click', function() {
        var quantity = document.getElementById('western15Quantity').value;
        alert('우동 ' + quantity + '개가 장바구니에 추가되었습니다.');
        closeModal('western15');
    });
    document.getElementById('addToCartwestern16').addEventListener('click', function() {
        var quantity = document.getElementById('western16Quantity').value;
        alert('냉우동 ' + quantity + '개가 장바구니에 추가되었습니다.');
        closeModal('western16');
    });
    document.getElementById('addToCartwestern17').addEventListener('click', function() {
        var quantity = document.getElementById('western17Quantity').value;
        alert('어묵우동 ' + quantity + '개가 장바구니에 추가되었습니다.');
        closeModal('western17');
    });
    document.getElementById('addToCartwestern18').addEventListener('click', function() {
        var quantity = document.getElementById('western18Quantity').value;
        alert('쫄면 ' + quantity + '개가 장바구니에 추가되었습니다.');
        closeModal('western18');
    });

});