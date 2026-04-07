# PassiveReconX

PassiveReconX is a lightweight Bash-based passive reconnaissance tool that gathers intelligence about a target domain using multiple open-source data sources.

---

## 🔍 Features

- Passive subdomain enumeration
- Multi-source data collection:
  - crt.sh (Certificate Transparency logs)
  - Hackertarget API
- Supports both domain and full URL input
- Automatic HTTP → HTTPS fallback
- IP address resolution
- HTTP header extraction
- Clean, deduplicated output
- Structured recon report generation
- Subdomain count included

---

## 📸 Screenshots

### ▶️ Tool Execution
![Run](screenshots/run.png)

### 📄 Generated Report
![Report](screenshots/report.png)

---

## ⚙️ Requirements

Make sure the following tools are installed:

- bash
- curl
- dig

---

## 🚀 Usage

### 1. Clone the repository

```bash
git clone https://github.com/thenullroot/passivereconx.git
cd passivereconx
```

### 2. Make script executable

```bash
chmod +x passiverecon.sh
```

### 3. Run the tool

#### Using domain:
```bash
./passiverecon.sh example.com
```

#### Using full URL:
```bash
./passiverecon.sh https://example.com
```

---

## 📄 Output

### Subdomains file:
```
subdomains_<target>.txt
```

### Full report:
```
report_<target>.txt
```

---

## 📌 Example Output

```
===================================
      PassiveReconX REPORT
===================================

TARGET: example.com
IP: 104.x.x.x
TOTAL SUBDOMAINS: 5

========== SUBDOMAINS ==========
dev.example.com
m.example.com
products.example.com
support.example.com
www.example.com

========== HTTP HEADERS ==========
HTTP/1.1 200 OK
Server: cloudflare
Content-Type: text/html
```

---

## ⚠️ Disclaimer

This tool is intended for educational purposes and authorized security testing only.  
Do not use this tool against targets without proper permission.

---

## 🛠️ Future Improvements

- Shodan integration
- Censys integration
- ASN and IP intelligence
- Subdomain takeover detection
- Output formatting improvements

---

## ⭐ Contributing

Feel free to fork the repository and submit pull requests.

---

## 📜 License

This project is open-source and available under the MIT License.
