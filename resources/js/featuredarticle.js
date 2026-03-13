/* this script took several sessions of bashing my head against the computer */
document.addEventListener("DOMContentLoaded", function () {
  const container = document.getElementById("feat-article-container");
  const pick = window.featuredArticle;

  if (!container || !pick) return;

  function removeInfobox(html) {
    if (!html) return '';
    const openTag = '{' + '%';
    const closeTag = '%' + '}';
    const openVar = '{' + '{';
    const closeVar = '}' + '}';
    const liquidRegex = new RegExp('(' + openTag + '[\\s\\S]*?' + closeTag + '|' + openVar + '[\\s\\S]*?' + closeVar + ')', 'g');
    html = html.replace(liquidRegex, '');
    html = html.replace(/<div[^>]*class=["']?infobox[^>]*>[\s\S]*?<\/div>/gi, '');
    html = html.replace(/^(?:\s*<[^>]+>)+/i, '').trim();
    return html;
  }
  const excerpt = removeInfobox(pick.excerpt);
      if (container) {
            if (excerpt) {
      container.innerHTML = `
        <a style="color:var(--title-color); padding-bottom:10px;" class="mdl-layout-title" href="${pick.url}">${pick.title}</a>
        <p>${excerpt}<a href="${pick.url}">Full article</a>.</p>
      `;
    }}
})