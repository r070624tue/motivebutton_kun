function initTasks() {
  const addTaskBtn = document.getElementById("add-task");
  const tasksWrapper = document.getElementById("tasks-wrapper");

  if (!addTaskBtn || !tasksWrapper) return;

  if (!addTaskBtn.dataset.bound) {
    addTaskBtn.addEventListener("click", () => {
      const newField = document.createElement("div");
      newField.classList.add("task-field");
      newField.innerHTML = `
      <input type="text" name="tasks[][content]" placeholder="タスク内容">
      <button type="button" class="remove-task">削除</button>
    `;
      tasksWrapper.appendChild(newField);
    });
    addTaskBtn.dataset.bound = "true";
  }

  if (!tasksWrapper.dataset.bound) {
    tasksWrapper.addEventListener("click", (e) => {
      if (e.target.classList.contains("remove-task")) {
        e.target.parentElement.remove();
      }
    });
    tasksWrapper.dataset.bound = "true";
  }
}

document.addEventListener("turbo:load", initTasks);
document.addEventListener("turbo:render", initTasks);
document.addEventListener("DOMContentLoaded", initTasks);
