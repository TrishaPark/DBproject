const buttonData = [
    { id: 1, label: "버튼 1" },
    { id: 2, label: "버튼 2" },
    { id: 3, label: "버튼 3" },
    { id: 4, label: "버튼 4" },
    { id: 5, label: "버튼 5" },
    { id: 6, label: "버튼 6" },
    { id: 7, label: "버튼 7" },
    { id: 8, label: "버튼 8" },
    { id: 9, label: "버튼 9" },
    { id: 10, label: "버튼 10" },
    { id: 11, label: "버튼 11" },
    { id: 12, label: "버튼 12" },
    { id: 13, label: "버튼 13" },
    { id: 14, label: "버튼 14" },
    { id: 15, label: "버튼 15" },
    { id: 16, label: "버튼 16" },
    { id: 17, label: "버튼 17" },
    { id: 18, label: "버튼 18" }
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