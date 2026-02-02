# 🔔 Mess Out Alarm Feature

## Overview

The Mess Out Alarm feature allows you to set a daily reminder notification that alerts you when it's time to leave the mess. This helps you remember to log your meals before leaving!

## How It Works

### Location
The alarm card is prominently displayed at the **top of the Calendar screen** (first page).

### Features
- ✅ **Daily recurring alarm** - Set once, repeats every day
- ✅ **Custom time** - Choose any time that works for you
- ✅ **Visual indicator** - See at a glance if alarm is active
- ✅ **Test notification** - Test the alarm before setting
- ✅ **Easy toggle** - Turn on/off with a switch

## How to Use

### Setting Up the Alarm

1. **Go to Calendar screen** (first tab)
2. **See the "Mess Out Alarm" card** at the top
3. **Toggle the switch** to ON
4. **Pick your time** in the dialog that appears
5. **Done!** Your daily alarm is set

### Changing the Time

1. **Tap the gear icon** (⚙️) on the alarm card
2. **Select new time** in the picker
3. **Confirm** - Alarm is updated

### Testing the Alarm

After setting a time, you'll see a snackbar with a **TEST** button:
- Tap "TEST" to trigger an immediate notification
- This helps you verify notifications are working

### Turning Off the Alarm

Simply **toggle the switch to OFF** on the alarm card.

## Visual Design

### When Active (ON):
- 🟢 **Green card** with green border
- 🔔 **Green alarm icon**
- **Shows time**: "Daily at 14:00"

### When Inactive (OFF):
- ⚪ **Gray card** with gray border
- ⚫ **Gray alarm icon**
- **Shows status**: "Not set"

## Notification Details

### What You'll See:
```
🍴 Mess Out Time!
Don't forget to log your meal before leaving the mess.
```

### Features:
- 🔊 **Sound** - Plays notification sound
- 📳 **Vibration** - Phone vibrates
- 🔔 **Badge** - Shows notification badge
- 📱 **Full screen** - Important notification (Android)

## Default Settings

- **Default time**: 2:00 PM (14:00)
- **Status**: OFF (you need to enable it)
- **Frequency**: Daily (repeats every day)

## Platform-Specific Notes

### Android
- ✅ Full support with all features
- ✅ Works even when app is closed
- ✅ Survives device restart
- ⚠️ Requires notification permission (auto-requested)

### iOS
- ✅ Full support with all features
- ✅ Works even when app is closed
- ⚠️ Requires notification permission (auto-requested)

### Web/Windows
- ⚠️ Limited support (browser-based notifications)
- ℹ️ Best experience on Android/iOS

## Technical Details

### Storage
- Alarm settings are saved in **Hive local storage**
- Persists across app restarts
- Syncs with your other app settings

### Scheduling
- Uses **timezone-aware scheduling**
- Set for **Pakistan timezone (Asia/Karachi)**
- Repeats daily at the exact time

### Permissions
The app will automatically request:
- 📱 **Notification permission** (Android 13+)
- ⏰ **Exact alarm permission** (Android 12+)

## Common Use Cases

### Scenario 1: Daily Lunch Reminder
```
Time: 1:30 PM
Use: Get reminded 30 minutes before lunch ends
Action: Log your lunch meal before leaving
```

### Scenario 2: Dinner Reminder
```
Time: 8:00 PM
Use: Reminder to log dinner
Action: Open app and log your meal
```

### Scenario 3: Breakfast Reminder
```
Time: 9:00 AM
Use: Morning reminder to log breakfast
Action: Quick log before classes
```

## Troubleshooting

### Alarm not ringing?

**Check 1: Is it enabled?**
- Look at the alarm card
- Should be green with switch ON

**Check 2: Notification permissions**
- Go to phone Settings > Apps > Meal Logging App
- Enable notifications

**Check 3: Battery optimization**
- Some phones disable background alarms
- Disable battery optimization for this app

**Check 4: Test it**
- Tap the gear icon
- Set time to 1 minute from now
- Wait and see if it rings

### Can't set time?

- Make sure the switch is ON first
- Or tap the gear icon directly

### Notifications not showing?

**Android:**
- Settings > Apps > Meal Logging App > Notifications
- Enable all notification types

**iOS:**
- Settings > Notifications > Meal Logging App
- Enable "Allow Notifications"

## Tips & Best Practices

### ⏰ **Set Strategic Times**
Choose times when you typically leave the mess:
- Before lunch ends
- Before dinner ends
- After breakfast

### 🔄 **Test First**
Always use the TEST button after setting a time to verify it works.

### 📱 **Keep App Updated**
Update the app to get alarm improvements and bug fixes.

### 🔋 **Battery Settings**
Disable battery optimization for this app to ensure alarms work reliably.

### 🔕 **Do Not Disturb**
On some phones, DND mode may silence alarms. Configure DND to allow app notifications.

## Privacy & Security

- ✅ **Local only** - No data sent to servers
- ✅ **No tracking** - No analytics on alarm usage
- ✅ **Private** - Alarm data stays on your device
- ✅ **Secure** - Stored in encrypted Hive database

## Future Enhancements

Potential features for future versions:
- 🔔 Multiple alarms (breakfast, lunch, dinner)
- 📅 Weekend vs weekday schedules
- 🔇 Smart silence (auto-off on holidays)
- 📝 Custom alarm messages
- 🎵 Custom alarm sounds
- ⏰ Snooze functionality

## FAQ

**Q: Will the alarm work when the app is closed?**  
A: Yes! It's a system-level notification that works even when the app is closed.

**Q: Does it drain battery?**  
A: No, scheduled notifications are battery efficient.

**Q: Can I set multiple alarms?**  
A: Currently one daily alarm. Multiple alarms coming in future updates.

**Q: What if I miss the notification?**  
A: It stays in your notification tray until you clear it.

**Q: Can I change the message?**  
A: Not yet, but custom messages are planned for a future update.

**Q: Will it work offline?**  
A: Yes! The alarm is scheduled locally and works offline.

**Q: Does it sync across devices?**  
A: No, this is a local-first app. Each device has its own alarm settings.

---

## Quick Reference Card

| Action | How To |
|--------|--------|
| **Enable alarm** | Toggle switch ON |
| **Set time** | Tap gear icon ⚙️ |
| **Test alarm** | Tap TEST in snackbar |
| **Disable alarm** | Toggle switch OFF |
| **Check status** | Look at card color (green=on) |

---

**Enjoy your mess out reminders!** 🍴🔔

*Set it once, never forget to log your meals again!*
