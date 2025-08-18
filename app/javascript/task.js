function initTasks() {
  const addTaskBtn = document.getElementById("add-task");
  const tasksWrapper = document.getElementById("tasks-wrapper");
  const taskForm = document.getElementById("task-form");
  const taskList = document.getElementById("task-list");

  if (addTaskBtn && !addTaskBtn.dataset.bound) {
    addTaskBtn.addEventListener("click", () => {
      const newField = document.createElement("div");
      newField.classList.add("task-field");
      newField.innerHTML = `
      <input type="text" name="tasks[][content]" placeholder="タスク内容">
      <button type="button" class="remove-task">削除</button>
    `;
      if (tasksWrapper) tasksWrapper.appendChild(newField);
    });
    addTaskBtn.dataset.bound = "true";
  }

  if (tasksWrapper && !tasksWrapper.dataset.bound) {
    tasksWrapper.addEventListener("click", (e) => {
      if (e.target.classList.contains("remove-task")) {
        e.target.parentElement.remove();
      }
    });
    tasksWrapper.dataset.bound = "true";
  }

  if (taskForm && !taskForm.dataset.boundSubmit) {
    taskForm.addEventListener("submit", function () {
      alert("頑張りましょう！");
    });
    taskForm.dataset.boundSubmit = "true";
  }

  if (taskList && !taskList.dataset.boundCheckAll) {
    taskList.addEventListener("change", function (e) {
      const target = e.target;
      if (!(target instanceof HTMLInputElement) || target.type !== "checkbox") return;

      const checkboxes = taskList.querySelectorAll('input[type="checkbox"]');
      const allChecked = Array.from(checkboxes).every((cb) => cb.checked);
      if (allChecked) {
        alert(
          "今日のタスクをすべて完了しました。おめでとうございます。"
        );
      }

      if (target.form) target.form.submit();
    });
    taskList.dataset.boundCheckAll = "true";
  }
}

document.addEventListener("turbo:load", initTasks);
document.addEventListener("turbo:render", initTasks);
document.addEventListener("DOMContentLoaded", initTasks);
