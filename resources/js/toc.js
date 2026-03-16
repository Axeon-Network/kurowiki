const toc = document.getElementById("table-of-contents");
const headings = document.querySelectorAll("#pagecontent h1, #pagecontent h2, #pagecontent h3");

let currentH1 = null;
let currentH2 = null;

headings.forEach(h => {
  const li = document.createElement("li");
  const a = document.createElement("a");

  a.href = "#" + h.id;
  a.textContent = h.textContent;
  li.appendChild(a);

  if (h.tagName === "H1") {
    toc.appendChild(li);
    currentH1 = li;
    currentH2 = noll;
  }
  else if (h.tagName === "H2" && currentH1) {
    let ol = currentH1.querySelector("ol") || currentH1.appendChild(document.createElement("ol"));
    ol.appendChild(li);
    currentH2 = li;
  }
  else if (h.tagName === "H3" && currentH2) {
    let ol = currentH2.querySelector("ol") || currentH2.appendChild(document.createElement("ol"));
    ol.appendChild(li);
  }
});