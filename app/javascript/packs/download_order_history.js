document.addEventListener("DOMContentLoaded", () => {
  document.querySelectorAll('[data-download-orders]').forEach((button) => {
    button.addEventListener("click", (event) => {
      pollForCsv(event.target.dataset.id);
    });
  });
});

const pollForCsv = (userId) => {
  const interval = setInterval(() => {
    fetch(`/users/${userId}/download_order_history`)
      .then(response => {
        if (response.ok) {
          clearInterval(interval);
          return response.blob();
        } else {
          throw new Error('CSV not ready yet');
        }
      })
      .then(blob => {
        const url = window.URL.createObjectURL(blob);
        const a = document.createElement('a');
        a.href = url;
        a.download = `user_${userId}_orders.csv`;
        document.body.appendChild(a);
        a.click();
        a.remove();
      })
      .catch(error => console.log(error));
  }, 5000);
}