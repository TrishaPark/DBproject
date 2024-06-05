document.addEventListener("DOMContentLoaded", function() {
    // cubbab1 버튼 클릭 시 모달 띄우기
    document.querySelector(".menu-item-card1").addEventListener("click", function() {
        openModal("cubbab1");
    });

    // cubbab2 버튼 클릭 시 모달 띄우기
    document.querySelector(".menu-item-card2").addEventListener("click", function() {
        openModal("cubbab2");
    });
	// cubbab3 버튼 클릭 시 모달 띄우기
    document.querySelector(".menu-item-card3").addEventListener("click", function() {
        openModal("cubbab3");
    });

    // cubbab4 버튼 클릭 시 모달 띄우기
    document.querySelector(".menu-item-card4").addEventListener("click", function() {
        openModal("cubbab4");
    });
    // cubbab5 버튼 클릭 시 모달 띄우기
    document.querySelector(".menu-item-card5").addEventListener("click", function() {
        openModal("cubbab5");
    });

    // cubbab6 버튼 클릭 시 모달 띄우기
    document.querySelector(".menu-item-card6").addEventListener("click", function() {
        openModal("cubbab6");
    });
    // cubbab7 버튼 클릭 시 모달 띄우기
    document.querySelector(".menu-item-card7").addEventListener("click", function() {
        openModal("cubbab7");
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
    document.getElementById('addToCartcubbab1').addEventListener('click', function() {
        var quantity = document.getElementById('cubbab1Quantity').value;
        alert('비건야채컵밥 ' + quantity + '개가 장바구니에 추가되었습니다.');
        closeModal('cubbab1');
    });
    document.getElementById('addToCartcubbab2').addEventListener('click', function() {
        var quantity = document.getElementById('cubbab2Quantity').value;
        alert('참치마요컵밥 ' + quantity + '개가 장바구니에 추가되었습니다.');
        closeModal('cubbab2');
    });
    document.getElementById('addToCartcubbab3').addEventListener('click', function() {
        var quantity = document.getElementById('cubbab3Quantity').value;
        alert('참치김치컵밥 ' + quantity + '개가 장바구니에 추가되었습니다.');
        closeModal('cubbab3');
    });
    document.getElementById('addToCartcubbab4').addEventListener('click', function() {
        var quantity = document.getElementById('cubbab4Quantity').value;
        alert('순두부컵밥 ' + quantity + '개가 장바구니에 추가되었습니다.');
        closeModal('cubbab4');
    });
    document.getElementById('addToCartcubbab5').addEventListener('click', function() {
        var quantity = document.getElementById('cubbab5Quantity').value;
        alert('제육컵밥 ' + quantity + '개가 장바구니에 추가되었습니다.');
        closeModal('cubbab5');
    });
    document.getElementById('addToCartcubbab6').addEventListener('click', function() {
        var quantity = document.getElementById('cubbab6Quantity').value;
        alert('치킨마요덮밥 ' + quantity + '개가 장바구니에 추가되었습니다.');
        closeModal('cubbab6');
    });
    document.getElementById('addToCartcubbab7').addEventListener('click', function() {
        var quantity = document.getElementById('cubbab7Quantity').value;
        alert('스팸마요덮밥 ' + quantity + '개가 장바구니에 추가되었습니다.');
        closeModal('cubbab7');
    });

});