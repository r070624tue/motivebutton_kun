document.addEventListener("DOMContentLoaded", () => {
  const addTaskBtn = document.getElementById("add-task");
  const tasksWrapper = document.getElementById("tasks-wrapper");

  // 入力欄追加
  addTaskBtn.addEventListener("click", () => {
    const newField = document.createElement("div");
    newField.classList.add("task-field");
    newField.innerHTML = `
      <input type="text" name="tasks[][content]" placeholder="タスク内容">
      <button type="button" class="remove-task">削除</button>
    `;
    tasksWrapper.appendChild(newField);
  });

  // 削除ボタン処理
  tasksWrapper.addEventListener("click", (e) => {
    if (e.target.classList.contains("remove-task")) {
      e.target.parentElement.remove();
    }
  });
});
