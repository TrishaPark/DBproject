const buttonData = [
    { id: 1, label: "버튼 1" },
    { id: 2, label: "버튼 2" },
    { id: 3, label: "버튼 3" },
    { id: 4, label: "버튼 4" },
    { id: 5, label: "버튼 5" },
    { id: 6, label: "버튼 6" },
    { id: 7, label: "버튼 7" }
];

// 버튼에 데이터를 표시하는 함수
function displayButtonData() {
    buttonData.forEach(item => {
        const button = document.getElementById(`button${item.id}`);
        if (button) {
            button.textContent = item.label;
        }
    });
}