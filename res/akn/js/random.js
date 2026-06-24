// "I'm Feeling Lucky", Akane edition
async function loadRandomArticle() {
    const res = await fetch("./res/index.json");
    const articles = await res.json();
    if (!articles?.length) {
        alert("No articles found");
        error('No articles (or at least articles with a url attribute) were found in the index file ') + res + ('.\nPlease check your index file, then debug the issue.');
        return;
    }

    const article = articles[Math.floor(Math.random() * articles.length)];
    
    // the newer index file has the title, url, snippet and isTitleItalic.
    // if we use the raw file, its going to return [object Object], so
    // we make it use the url attribute instead of just "article".
    window.location.href = article.url;
}