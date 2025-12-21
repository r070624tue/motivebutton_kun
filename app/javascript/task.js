function initTasks() {
  const addTaskBtn = document.getElementById("add-task");
  const tasksWrapper = document.getElementById("tasks-wrapper");
  const taskList = document.getElementById("task-list");
  const adviceResultElement = document.getElementById('adviceResult');
  const taskShowElement = document.querySelector('.task-show');

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

  if (adviceResultElement && taskShowElement && !taskShowElement.dataset.adviceLoaded) {
    taskShowElement.dataset.adviceLoaded = 'true';
    const date = taskShowElement.dataset.date;
    const hasAdvice = taskShowElement.dataset.hasAdvice === 'true';

    // 既存のアドバイスがある場合はAPI呼び出しをスキップ
    if (!hasAdvice) {
      adviceResultElement.textContent = 'AIがアドバイスを考えています...';

      (async () => {
        try {
          const response = await fetch('/advices', {
            method: 'POST',
            headers: {
              'Content-Type': 'application/json',
              'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content,
            },
            body: JSON.stringify({ date: date }),
          });

          if (!response.ok) {
            throw new Error('サーバーからの応答が正常ではありません。');
          }
          
          const data = await response.json();
          adviceResultElement.textContent = data.advice;

        } catch (error) {
          console.error('エラー:', error);
          adviceResultElement.textContent = 'エラーが発生しました。もう一度試してください。';
        }
      })();
    }
  }

  if (taskForm && !taskForm.dataset.boundSubmit) {
    taskForm.addEventListener("submit", function () {
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
