document.addEventListener("DOMContentLoaded", () => {
  document.querySelectorAll("button['data-download-orders']").forEach((button) => {
    button.addEventListener("click", (event) => {
      console.log(event.target)
      const userId = event.target.data.id;
      // pollForCsv(userId);
    });
  });
});

const pollForCsv = (userId) => {
  const interval = setInterval(() => {
    fetch(`/users/${userId}/download_ready_csv`)
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
