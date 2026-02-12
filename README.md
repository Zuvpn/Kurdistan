# 🟢 KURDISTAN PRO

Multi Profile Linux Service Manager  
Monitoring • Telegram Alerts • Backup • Auto Restart

---

## 🌍 Language / زبان / زمان
- 🇮🇷 فارسی
- 🇬🇧 English
- 🟡 Kurdî

---

============================================================
🇮🇷 فارسی
============================================================

## 📌 معرفی

Kurdistan PRO یک اسکریپت حرفه‌ای مدیریت سرویس در لینوکس است که امکان ساخت چند پروفایل همزمان، مانیتورینگ خودکار، ریستارت هوشمند، نوتیفیکیشن تلگرام و گزارش روزانه سلامت سرویس‌ها را فراهم می‌کند.

---

## ✨ امکانات

✅ ساخت چند پروفایل همزمان  
✅ ساخت سرویس systemd جداگانه برای هر پروفایل  
✅ ریستارت خودکار هنگام Down  
✅ ارسال نوتیفیکیشن تلگرام (فقط یکبار در هر خطا)  
✅ ارسال 20 خط آخر لاگ هنگام خطا  
✅ گزارش روزانه سلامت همه سرویس‌ها (ساعت 9 صبح)  
✅ نمایش Uptime هر سرویس  
✅ بکاپ و ریستور پروفایل‌ها  
✅ پنل گرافیکی با whiptail  
✅ مانیتورینگ خودکار با cron  

---

## 🚀 نصب

### پیش‌نیاز

sudo apt update  
sudo apt install curl whiptail -y  

### نصب مستقیم

curl -fsSL https://raw.githubusercontent.com/Zuvpn/kurdistan/main/kurdistan.sh -o /usr/local/bin/kurdistan  
chmod +x /usr/local/bin/kurdistan  
sudo kurdistan  

---

## 🔔 تنظیم تلگرام

1. ورود به BotFather  
2. اجرای دستور /newbot  
3. دریافت Token  
4. دریافت Chat ID  
5. تنظیم از داخل منوی اسکریپت  

---

============================================================
🇬🇧 English
============================================================

## 📌 Introduction

Kurdistan PRO is a professional Linux service manager supporting:

- Multi-profile management  
- Automatic monitoring  
- Smart auto restart  
- Telegram alerts  
- Daily health reports  

---

## ✨ Features

✅ Multi-profile support  
✅ Dedicated systemd service per profile  
✅ Auto restart on failure  
✅ Telegram alert (only once per incident)  
✅ Sends last 20 log lines on failure  
✅ Daily health report (09:00 AM)  
✅ Service uptime tracking  
✅ Backup & restore  
✅ Whiptail UI  
✅ Cron monitoring  

---

## 🚀 Installation

sudo apt update  
sudo apt install curl whiptail -y  

curl -fsSL https://raw.githubusercontent.com/Zuvpn/kurdistan/main/kurdistan.sh -o /usr/local/bin/kurdistan  
chmod +x /usr/local/bin/kurdistan  
sudo kurdistan  

---

============================================================
🟡 Kurdî
============================================================

## 📌 ناساندن

Kurdistan PRO سکریپتێکی بەهێزی بەڕێوەبردنی خزمەتگوزاریەکانە لە Linux.

---

## ✨ تایبەتمەندیەکان

✅ چەند پروفایل  
✅ systemd بۆ هەر پروفایلێک  
✅ ریستارت خۆکار  
✅ ئاگاداری Telegram (تەنها جارێک)  
✅ ناردنی 20 هێڵی دواهەم لاگ  
✅ ڕاپۆرتی ڕۆژانە  
✅ پیشاندانی Uptime  
✅ Backup و Restore  
✅ پەنجەرەی whiptail  
✅ چاودێری بە cron  

---

## 🚀 دامەزراندن

sudo apt update  
sudo apt install curl whiptail -y  

curl -fsSL https://raw.githubusercontent.com/Zuvpn/kurdistan/main/kurdistan.sh -o /usr/local/bin/kurdistan  
chmod +x /usr/local/bin/kurdistan  
sudo kurdistan  

---

## 👤 Author

GitHub: https://github.com/Zuvpn

## 🛡 License

MIT License
