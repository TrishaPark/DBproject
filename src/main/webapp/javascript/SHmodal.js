document.addEventListener("DOMContentLoaded", function () {
// 한식 버튼 클릭 시 모달 띄우기
    document.querySelector(".SHmenu1").addEventListener("click", function () {
        openModal("koreanMealModal");
    });

// 양식 버튼 클릭 시 모달 띄우기
    document.querySelector(".SHmenu2").addEventListener("click", function () {
        openModal("westernMealModal");
    });

// 모달을 여는 함수
    function openModal(modalId) {
        var modal = document.getElementById(modalId);
        modal.style.display = "block";
    }

// 모달을 닫는 함수
    window.closeModal = function (modalId) {
        var modal = document.getElementById(modalId);
        modal.style.display = "none";
    };

// 모달 외부를 클릭했을 때 모달을 닫기
    window.onclick = function (event) {
        if (event.target.classList.contains("modal")) {
            event.target.style.display = "none";
        }
    };

// 장바구니 버튼 클릭 시 이벤트 처리
    document.getElementById('addToCartKorean').addEventListener('click', function () {
        var quantity = document.getElementById('koreanQuantity').value;
        alert('한식 식권 ' + quantity + '장이 장바구니에 추가되었습니다.');
        closeModal('koreanMealModal');
    });

    document.getElementById('addToCartWestern').addEventListener('click', function () {
        var quantity = document.getElementById('westernQuantity').value;
        alert('양식 식권 ' + quantity + '장이 장바구니에 추가되었습니다.');
        closeModal('westernMealModal');
    });
});