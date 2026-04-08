variable "project_name" {
  type    = string
  default = "deplai-smoke-test"
  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.project_name))
    error_message = "project_name must use lowercase letters, numbers, and dashes."
  }
}

variable "environment" {
  type    = string
  default = "dev"
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "environment must be dev, staging, or prod."
  }
}

variable "region" {
  type    = string
  default = "eu-north-1"
}

variable "team" {
  type    = string
  default = "platform-engineering"
}

variable "cost_center" {
  type    = string
  default = "engineering"
}

variable "compute_strategy" {
  type    = string
  default = "ec2"
  validation {
    condition     = contains(["ec2", "s3_cloudfront"], var.compute_strategy)
    error_message = "compute_strategy must be ec2 or s3_cloudfront in the enterprise deterministic renderer."
  }
}

variable "vpc_cidr" {
  type    = string
  default = "10.42.0.0/16"
  validation {
    condition     = can(cidrhost(var.vpc_cidr, 0))
    error_message = "vpc_cidr must be a valid CIDR block."
  }
}

variable "public_subnet_cidrs" {
  type    = list(string)
  default = ["10.42.1.0/24", "10.42.2.0/24"]
}

variable "private_subnet_cidrs" {
  type    = list(string)
  default = ["10.42.11.0/24", "10.42.12.0/24"]
}

variable "use_existing_vpc" {
  type    = bool
  default = false
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
  validation {
    condition     = contains(["t3.micro", "t3.small", "t3.medium"], var.instance_type)
    error_message = "instance_type must be one of the approved low-cost defaults."
  }
}

variable "app_port" {
  type    = number
  default = 8000
}

variable "bootstrap_index_html_base64" {
  type      = string
  default   = base64encode("<!DOCTYPE html>\r\n<html lang=\"en\">\r\n<head>\r\n  <meta charset=\"UTF-8\" />\r\n  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\" />\r\n  <title>Neural Atlas | AI Trends + Resources</title>\r\n  <meta name=\"description\" content=\"A bold AI resource hub tracking trends, tools, and what is next.\" />\r\n  <link rel=\"preconnect\" href=\"https://fonts.googleapis.com\" />\r\n  <link rel=\"preconnect\" href=\"https://fonts.gstatic.com\" crossorigin />\r\n  <link href=\"https://fonts.googleapis.com/css2?family=Chakra+Petch:wght@500;700&family=Sora:wght@300;400;600;700&display=swap\" rel=\"stylesheet\" />\r\n  <link rel=\"stylesheet\" href=\"styles.css\" />\r\n</head>\r\n<body>\r\n  <div class=\"aurora aurora-a\"></div>\r\n  <div class=\"aurora aurora-b\"></div>\r\n\r\n  <header class=\"topbar\">\r\n    <div class=\"brand\">Neural Atlas</div>\r\n    <nav>\r\n      <a href=\"#trend-grid\">Trends</a>\r\n      <a href=\"#resource-hub\">Resources</a>\r\n      <a href=\"#signals\">Signals</a>\r\n    </nav>\r\n  </header>\r\n\r\n  <main>\r\n    <section class=\"hero reveal\">\r\n      <p class=\"kicker\">AI OBSERVATORY 2026</p>\r\n      <h1>Where AI resources, trends, and experiments collide.</h1>\r\n      <p class=\"hero-copy\">\r\n        Discover practical tools, track fast-moving shifts, and keep a pulse on what matters in AI right now.\r\n      </p>\r\n      <div class=\"hero-cta\">\r\n        <a class=\"button prime\" href=\"#resource-hub\">Browse Resources</a>\r\n        <a class=\"button ghost\" href=\"#signals\">Read Trend Signals</a>\r\n      </div>\r\n      <div class=\"hero-chip-row\">\r\n        <span>Agents</span>\r\n        <span>Multimodal</span>\r\n        <span>Inference at Scale</span>\r\n        <span>Open Source Models</span>\r\n      </div>\r\n    </section>\r\n\r\n    <section id=\"trend-grid\" class=\"panel reveal\">\r\n      <div class=\"section-head\">\r\n        <h2>Trend Radar</h2>\r\n        <p>Momentum snapshots from teams building with AI across product, infra, and research.</p>\r\n      </div>\r\n      <div class=\"grid trend-grid\">\r\n        <article class=\"card trend-card\">\r\n          <h3>Agentic Workflows</h3>\r\n          <p>Teams are shifting from single prompts to orchestrated task loops with memory + tools.</p>\r\n          <div class=\"meter\"><span style=\"--pct: 88%\"></span></div>\r\n          <small>Momentum: Very High</small>\r\n        </article>\r\n        <article class=\"card trend-card\">\r\n          <h3>Small Models, Big Reach</h3>\r\n          <p>Optimized smaller models are winning on latency, privacy, and edge deployment.</p>\r\n          <div class=\"meter\"><span style=\"--pct: 74%\"></span></div>\r\n          <small>Momentum: High</small>\r\n        </article>\r\n        <article class=\"card trend-card\">\r\n          <h3>Video + Voice Interfaces</h3>\r\n          <p>Natural multimodal UX is becoming expected in support, education, and creator tools.</p>\r\n          <div class=\"meter\"><span style=\"--pct: 81%\"></span></div>\r\n          <small>Momentum: Very High</small>\r\n        </article>\r\n        <article class=\"card trend-card\">\r\n          <h3>AI Governance Ops</h3>\r\n          <p>Policy-aware deployment, red-teaming, and model telemetry are moving into core pipelines.</p>\r\n          <div class=\"meter\"><span style=\"--pct: 67%\"></span></div>\r\n          <small>Momentum: Rising</small>\r\n        </article>\r\n      </div>\r\n    </section>\r\n\r\n    <section id=\"resource-hub\" class=\"panel reveal\">\r\n      <div class=\"section-head\">\r\n        <h2>AI Resource Hub</h2>\r\n        <p>Curated links for builders, researchers, and curious learners.</p>\r\n      </div>\r\n\r\n      <div class=\"resource-controls\">\r\n        <input id=\"resourceSearch\" type=\"search\" placeholder=\"Search resources by name or topic\" aria-label=\"Search AI resources\" />\r\n        <div class=\"chip-group\" id=\"filterChips\">\r\n          <button class=\"chip active\" data-filter=\"all\">All</button>\r\n          <button class=\"chip\" data-filter=\"learning\">Learning</button>\r\n          <button class=\"chip\" data-filter=\"tools\">Tools</button>\r\n          <button class=\"chip\" data-filter=\"research\">Research</button>\r\n          <button class=\"chip\" data-filter=\"community\">Community</button>\r\n        </div>\r\n      </div>\r\n\r\n      <div id=\"resourceList\" class=\"grid resource-grid\"></div>\r\n    </section>\r\n\r\n    <section id=\"signals\" class=\"panel reveal\">\r\n      <div class=\"section-head\">\r\n        <h2>What To Watch Next</h2>\r\n        <p>Signals that could shape AI products over the next 6-12 months.</p>\r\n      </div>\r\n      <div class=\"timeline\">\r\n        <article class=\"signal\">\r\n          <span>Q2</span>\r\n          <h3>Persistent Agent Memory</h3>\r\n          <p>Personalized assistants will retain long-context project state across sessions.</p>\r\n        </article>\r\n        <article class=\"signal\">\r\n          <span>Q3</span>\r\n          <h3>Real-Time Model Routing</h3>\r\n          <p>Apps will route tasks between models dynamically based on cost, quality, and speed.</p>\r\n        </article>\r\n        <article class=\"signal\">\r\n          <span>Q4</span>\r\n          <h3>AI-Native Team Dashboards</h3>\r\n          <p>Operational dashboards will shift from static charts to conversational simulation surfaces.</p>\r\n        </article>\r\n      </div>\r\n    </section>\r\n  </main>\r\n\r\n  <footer class=\"reveal\">\r\n    <p>Neural Atlas was built as a static site for S3 + CloudFront deployment.</p>\r\n    <p id=\"stamp\"></p>\r\n  </footer>\r\n\r\n  <script src=\"script.js\"></script>\r\n</body>\r\n</html>")
  sensitive = true
}

variable "required_secret_names" {
  type    = list(string)
  default = []
}

variable "secrets_manager_prefix" {
  type    = string
  default = "/deplai-smoke-test/dev"
}

variable "enable_postgres" {
  type    = bool
  default = false
}

variable "enable_redis" {
  type    = bool
  default = false
}
