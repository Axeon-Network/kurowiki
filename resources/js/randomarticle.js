document.addEventListener("DOMContentLoaded", () => {
  const btn = document.getElementById("random-article");
  if (!btn) return;

  btn.addEventListener("click", async () => {
    const res = await fetch("/articles.json");
    const articles = await res.json();
    if (!articles?.length) {
      alert("No articles found");
      return;
    }
    const article = articles[Math.floor(Math.random() * articles.length)];
    window.location.href = article;
  });
});