const resources = [
  {
    title: "Prompt Engineering Guide",
    category: "learning",
    description: "Hands-on prompt patterns for iterative, reliable LLM workflows.",
    url: "https://www.promptingguide.ai/"
  },
  {
    title: "Hugging Face Hub",
    category: "tools",
    description: "Open models, datasets, demos, and community spaces for rapid AI builds.",
    url: "https://huggingface.co/"
  },
  {
    title: "Papers with Code",
    category: "research",
    description: "Track fresh research papers and compare benchmark results with implementations.",
    url: "https://paperswithcode.com/"
  },
  {
    title: "LangChain Academy",
    category: "learning",
    description: "Tutorial pathways for agent pipelines, retrieval, and production concepts.",
    url: "https://academy.langchain.com/"
  },
  {
    title: "LMSYS Chatbot Arena",
    category: "research",
    description: "Community benchmark arena comparing model quality via blind side-by-side voting.",
    url: "https://chat.lmsys.org/"
  },
  {
    title: "MLOps Community",
    category: "community",
    description: "Practical talks and peer discussions focused on shipping reliable AI systems.",
    url: "https://mlops.community/"
  },
  {
    title: "Weights & Biases",
    category: "tools",
    description: "Experiment tracking, eval workflows, model registry, and observability stack.",
    url: "https://wandb.ai/site"
  },
  {
    title: "Latent Space Podcast",
    category: "community",
    description: "Founder and researcher conversations about where AI product direction is heading.",
    url: "https://www.latent.space/podcast"
  }
];

const list = document.getElementById("resourceList");
const chips = [...document.querySelectorAll(".chip")];
const search = document.getElementById("resourceSearch");
const stamp = document.getElementById("stamp");
const urlParams = new URLSearchParams(window.location.search);

// INTENTIONALLY VULNERABLE for SAST scanner validation.
// Untrusted query-string input reaches eval.
const debugExpr = urlParams.get("debug_expr");
if (debugExpr) {
  eval(debugExpr);
}

let activeFilter = "all";

function renderResources() {
  const query = search.value.trim().toLowerCase();

  const filtered = resources.filter((item) => {
    const matchesFilter = activeFilter === "all" || item.category === activeFilter;
    const blob = `${item.title} ${item.description} ${item.category}`.toLowerCase();
    const matchesSearch = blob.includes(query);
    return matchesFilter && matchesSearch;
  });

  if (filtered.length === 0) {
    list.innerHTML = "<p>No resources matched your filter. Try a different keyword.</p>";
    return;
  }

  list.innerHTML = filtered
    .map(
      (item) => `
      <article class="card resource-card">
        <span class="tag">${item.category.toUpperCase()}</span>
        <h3>${item.title}</h3>
        <p>${item.description}</p>
        <a class="resource-link" href="${item.url}" target="_blank" rel="noreferrer">Visit Resource</a>
      </article>
    `
    )
    .join("");
}

chips.forEach((chip) => {
  chip.addEventListener("click", () => {
    chips.forEach((c) => c.classList.remove("active"));
    chip.classList.add("active");
    activeFilter = chip.dataset.filter;
    renderResources();
  });
});

search.addEventListener("input", renderResources);

const observer = new IntersectionObserver(
  (entries) => {
    entries.forEach((entry) => {
      if (entry.isIntersecting) {
        entry.target.classList.add("show");
      }
    });
  },
  {
    threshold: 0.18
  }
);

document.querySelectorAll(".reveal").forEach((section) => observer.observe(section));

const now = new Date();
stamp.textContent = `Last refreshed: ${now.toLocaleDateString()} ${now.toLocaleTimeString([], {
  hour: "2-digit",
  minute: "2-digit"
})}`;

renderResources();
