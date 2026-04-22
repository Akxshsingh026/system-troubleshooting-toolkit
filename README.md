# 🛠️ System Troubleshooting Toolkit (PowerShell + Batch)

## 📌 Overview
This project is a **Windows IT Support Automation Toolkit** designed to simplify and speed up common troubleshooting tasks.

It includes:
- A PowerShell script for system-level fixes  
- Batch files to run the script easily with administrator privileges  

---

## 📂 Project Files
domainrun-tool.bat → Batch file to run script as administrator # ONLY FOR DOMAIN USERS
domainsystem_tool.ps1 → Main PowerShell script
run-toolsys.bat  → Batch file to run script as administrator # ONLY FOR WORKGROUP & NORMAL_USER
system_toolkit.ps1  → Main PowerShell script


---

## 🚀 Features

- 🧹 Cleans temporary files  
- 🌐 Flushes DNS cache  
- 🔄 Resets network (IP release/renew)  
- 💽 Performs disk check  
- 🛡️ Runs System File Checker (SFC)  
- ⚡ Easy execution using batch launcher  

---

## ⚙️ How to Use

### 🔹 Method 1 (Recommended – Easy)
1. Right-click on: domainsystem-tool.bat / run-toolsys.bat
2. 2. Click **Run as Administrator**
3. Script will start automatically

---

### 🔹 Method 2 (PowerShell Manual)

1. Open PowerShell as Administrator  
2. Navigate to folder: cd Downloads    # OR WHAT  EVER WHERE EVER YOU SAVE OR DOWNLOAD THAT FILES GO TO THAT LOCATION
3. Run: powershell -ExecutionPolicy Bypass -File domainsystem_tool.ps1 / powershell -ExecutionPolicy Bypass -File system_toolkit.ps1

---
---

## 🎯 Use Case

This toolkit is useful for:
- IT Support Engineers  
- Desktop Support Technicians  
- System Administrators  

Helps fix:
- Slow system performance  
- Network issues  
- Corrupted system files  

---

## 💡 Advantages

- Saves time in troubleshooting  
- Reduces manual repetitive work  
- Easy to use (even for beginners)  
- Works across Windows 7, 8, 10, 11  

---

## ⚠️ Requirements

- Windows OS  
- Administrator privileges  
- PowerShell enabled  

---

## 🔮 Future Improvements

- Add menu-based interface  
- Generate log reports  
- GUI version  
- Advanced network diagnostics  

---

## 👤 Author
**AkashSingh Parmar**  
IT Support Engineer | System Administrator  

---

## 📄 License
Free to use for learning and professional use.
