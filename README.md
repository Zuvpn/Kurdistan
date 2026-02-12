# 🟢 KURDISTAN PRO

Multi Profile Linux Service Manager  
Monitoring • Telegram Alerts • Backup • Auto Restart

---

## 🌍 Language / زبان / زمان
- 🇮🇷 فارسی
- 🇬🇧 English
- 🟡 Kurdî

---

# 🇮🇷 فارسی

## معرفی
Kurdistan PRO یک اسکریپت حرفه‌ای مدیریت سرویس در لینوکس است.

### امکانات
- ساخت چند پروفایل همزمان
- ساخت سرویس systemd جداگانه
- ریستارت خودکار هنگام Down
- ارسال نوتیفیکیشن تلگرام (فقط یکبار)
- ارسال 20 خط آخر لاگ
- گزارش روزانه سلامت
- نمایش Uptime
- بکاپ و ریستور
- پنل whiptail
- مانیتورینگ با cron

### نصب
sudo apt update  
sudo apt install curl whiptail -y  

curl -fsSL https://raw.githubusercontent.com/Zuvpn/kurdistan/main/kurdistan.sh -o /usr/local/bin/kurdistan  
chmod +x /usr/local/bin/kurdistan  
sudo kurdistan  

---

# 🇬🇧 English

## Introduction
Kurdistan PRO is a Linux service manager.

### Features
- Multi profiles
- systemd service per profile
- Auto restart
- Telegram alert (once per incident)
- Sends last 20 log lines
- Daily health report
- Uptime tracking
- Backup & restore
- Whiptail UI
- Cron monitoring

### Installation
sudo apt update  
sudo apt install curl whiptail -y  

curl -fsSL https://raw.githubusercontent.com/Zuvpn/kurdistan/main/kurdistan.sh -o /usr/local/bin/kurdistan  
chmod +x /usr/local/bin/kurdistan  
sudo kurdistan  

---

# 🟡 Kurdî

## ناساندن
Kurdistan PRO سکریپتێکی بەڕێوەبردنی خزمەتگوزاریەکانە.

### تایبەتمەندیەکان
- چەند پروفایل
- systemd بۆ هەر پروفایلێک
- ریستارت خۆکار
- ئاگاداری Telegram
- ڕاپۆرتی ڕۆژانە
- Uptime
- Backup
- چاودێری cron

### دامەزراندن
sudo apt update  
sudo apt install curl whiptail -y  

curl -fsSL https://raw.githubusercontent.com/Zuvpn/kurdistan/main/kurdistan.sh -o /usr/local/bin/kurdistan  
chmod +x /usr/local/bin/kurdistan  
sudo kurdistan  

---

MIT License  
GitHub: https://github.com/Zuvpn
