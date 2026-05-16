# Enterprise Infrastructure Automation & Security Orchestration Toolkit

## 🚀 Overview
This repository serves as a centralized portfolio of production-ready automation scripts, infrastructure workarounds, and AI-driven Security Orchestration, Automation, and Response (SOAR) workflows. 

Designed for hybrid environments, these tools focus on moving enterprise operations from reactive firefighting to proactive, automated system health management and threat intelligence.

---

## 🛠️ Repository Architecture

### 1. Security Orchestration & AI Analytics (`/n8n-workflows`)
* **AI-Driven Web Log Analyst (`ExamineWebRequest.json`):** * **Description:** A continuous 30-minute automated loop that polls Elasticsearch/Kibana APIs for anomalies.
    * **Technical Stack:** n8n, Elasticsearch (ELK), LangChain, Google Gemini API, Microsoft Teams Webhooks.
    * **Core Logic:** Filters for response metrics $\ge 400$, drops internal IP blocks dynamically, processes arrays using clean JavaScript mapping, and leverages an LLM reasoning engine to deliver structured threat briefs (IOCs and endpoints) directly to communication channels.

### 2. Proactive Infrastructure Monitoring (`/powershell-monitoring`)
* **System Resource Watchdog (`Monitor-RAM.ps1`):**
    * **Description:** A lightweight background daemon designed to prevent performance bottlenecks on critical Windows servers.
    * **Technical Stack:** PowerShell v5.1+, CIM Instances (`Win32_OperatingSystem`), Windows Task Scheduler.
    * **Core Logic:** Calculates accurate mathematical memory consumption percentages. If resources cross an 80% threshold, it programmatically targets and extracts the top 3 processes sorting by `WorkingSet` size, writing anomalies to a persistent audit log.

### 3. Legacy Patches & Deployment Configurations (`/deployment-patches`)
* **OS Feature Update Regression Patch (`SID-Override-Patch.bat`):**
    * **Description:** An emergency deployment script built to resolve widespread SMB and RDP dropouts resulting from duplicate Security Identifiers (SIDs) reacting to Windows Cumulative Updates.
    * **Technical Stack:** Windows Command Script (Batch), Windows Registry Interface.
    * **Core Logic:** Bypasses enforcement policies instantly using localized `FeatureManagement\Overrides` registry manipulation to minimize client downtime while migrating infrastructure to an authorized Sysprep deployment model.

---

## 📖 Deployment & Best Practices

### Running the n8n Workflows
1. Install or host an instance of **n8n**.
2. Create a new canvas, click anywhere on the grid, and paste the contents of `ExamineWebRequest.json`.
3. Configure your HTTP Request nodes with your internal corporate endpoints:
   - Replace `"Your ELK URL"` with your private cluster address.
   - Replace `"Your Webhook URL"` with your secure Teams incoming webhook connector.
4. Supply your Google Gemini API credentials via the native LangChain chat model node.

### Automating the PowerShell Watchdog
To ensure the monitoring infrastructure operates silently without user interaction, configure **Windows Task Scheduler** via an elevated shell or GUI using the following baseline parameters:
* **Security Context:** Execute under the `NT AUTHORITY\SYSTEM` account.
* **Privileges:** Toggle "Run with highest privileges" to bypass UAC prompts.
* **Trigger:** Repeat task every `60 minutes` (or `15 minutes` for high-availability production nodes) with a duration of `Indefinitely`.
* **Action Path:** `powershell.exe`
* **Arguments:** `-ExecutionPolicy Bypass -WindowStyle Hidden -File "C:\YourSafePath\Monitor-RAM.ps1"`

---

## 🔒 Security & Compliance Assurance
* **Credential Masking:** All shared configurations have been explicitly sanitized. Absolutely no static API tokens, private cryptographic keys, webhooks, or explicit corporate network paths are preserved within this repository.
* **Data Minimization:** AI prompts and search filters are strategically architected to minimize data ingestion costs and avoid transmitting sensitive or protected employee records externally.

## 🤝 Contribution & Engagement
This toolkit is maintained to foster community progress within systems engineering and modern SecOps. If you identify structural flaws or optimizations (such as upgrading legacy text parsing models to structured JSON schemas inside the LLM chains), feel free to open an issue or submit a pull request.
