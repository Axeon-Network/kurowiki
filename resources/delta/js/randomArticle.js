/* 'I'm Feeling Lucky' deltari edition */
async function loadRandomArticle() {
    const res = await fetch("./resources/index.json");
    const articles = await res.json();
    if (!articles?.length) {
        alert("No articles found");
        return;
    }

    const article = articles[Math.floor(Math.random() * articles.length)];
    window.location.href = "/kurowiki" + article;
}
