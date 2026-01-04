# iOS Shortcut Setup for gym-gate

This guide walks you through creating an iOS Shortcut that syncs your **Exercise Minutes** from Apple Health to your Mac. Exercise Minutes tracks elevated heart rate activity - so casual walking won't count, but gym sessions, runs, and intense workouts will.

---

## Prerequisites

Before starting, verify you have Exercise Minutes data:

1. Open **Health** app on iPhone
2. Tap **Browse** (bottom tab)
3. Tap **Activity**
4. Tap **Exercise Minutes**
5. You should see data here (if you have an Apple Watch or log workouts)

If no data exists, you'll need to:
- Use an Apple Watch, OR
- Manually start workouts in the **Fitness** app, OR
- Use a third-party app that syncs to Health (Strava, Nike Run Club, etc.)

---

## Part 1: Create the Shortcut (Step-by-Step)

### Step 1: Create New Shortcut

1. Open **Shortcuts** app on your iPhone
2. Tap **+** (top right corner)
3. Tap the name at the top ("New Shortcut")
4. Rename to: **Gym Gate Sync**
5. Tap **Done**

---

### Step 2: Add "Find Health Samples" Action

1. Tap **Add Action** (or tap the search bar at bottom)
2. Type: **Find Health Samples**
3. Tap **Find Health Samples** to add it

You'll see:
```
Find [Health Samples] where [All] of the following are true
```

4. Tap the blue **Health Samples** text
5. Scroll through the list and tap **Exercise Minutes**

Now configure the filters:

6. Tap **Add Filter** (or tap below "All of the following are true")
7. You'll see a new filter row. Tap it to configure:
   - First field: tap and select **Start Date**
   - Second field: tap and select **is**
   - Third field: tap and select **today**

Your action should now read:
```
Find [Exercise Minutes] where [All] of the following are true
  [Start Date] [is] [today]
```

---

### Step 3: Add "Calculate Statistics" Action

1. Tap **+** below the Find Health Samples action
2. Search for: **Calculate Statistics**
3. Tap to add it

Configure:

4. It should show: `Calculate [Average] of [Health Samples]`
5. Tap **Average** and change to **Sum**
6. Make sure the input shows **Health Samples** (should be automatic)

Your action reads:
```
Calculate [Sum] of [Health Samples]
```

---

### Step 4: Add "If" Action (Minimum Threshold)

We only want to count as "worked out" if you have at least 15 minutes of exercise.

1. Tap **+**
2. Search for: **If**
3. Tap to add it

Configure:

4. You'll see: `If [Calculation Result] [Condition]`
5. Tap **Condition** and select **is greater than**
6. A number field appears - tap it and type: **15**

Your action reads:
```
If [Calculation Result] [is greater than] [15]
```

You'll also see "Otherwise" and "End If" blocks appear automatically.

---

### Step 5: Add "Date" Action (Inside the If block)

We need to get today's date in the right format.

1. Tap **+** right after the "If" line (BEFORE "Otherwise")
2. Search for: **Date**
3. Tap the simple **Date** action (not "Format Date")

Configure:

4. Tap **Current Date** and keep it as is
5. Now tap **+** again (still inside the If block)
6. Search for: **Format Date**
7. Tap to add it

Configure the Format Date:

8. Make sure input is **Date** (from previous action)
9. Tap **Date Format** and select **Custom**
10. In the custom format field, type exactly: **yyyy-MM-dd**

This gives us dates like: 2025-01-04

---

### Step 6: Add "Text" Action (Create the log entry)

1. Tap **+** (still inside the If block, after Format Date)
2. Search for: **Text**
3. Tap to add it

Now build the text content:

4. Tap inside the text field
5. From the variables above the keyboard, tap **Formatted Date**
6. Type: **|Exercise|**
7. Tap **Calculation Result** from the variables
8. Type: ** min**

Your text should look like:
```
[Formatted Date]|Exercise|[Calculation Result] min
```

When run, this produces: `2025-01-04|Exercise|32 min`

---

### Step 7: Add "Save File" Action

1. Tap **+** (still inside the If block)
2. Search for: **Save File**
3. Tap to add it

Configure:

4. **Service:** Make sure it says **iCloud Drive** (tap to change if needed)
5. **Ask Where to Save:** Tap the toggle to turn it **OFF**
6. A **Destination Path** field appears. Tap it and type exactly:
   ```
   /Shortcuts/gym-gate/workouts.txt
   ```
7. **Overwrite If File Exists:** Tap to turn **ON**

---

### Step 8: Add "Otherwise" Notification (Optional but helpful)

This shows a notification if you haven't exercised enough.

1. Tap inside the **Otherwise** section
2. Tap **+**
3. Search for: **Show Notification**
4. Tap to add it

Configure:

5. Tap the text field and type:
   ```
   Only [Calculation Result] exercise minutes today. Need 15+ to unlock commits!
   ```
   (Insert Calculation Result from variables)

---

### Step 9: Verify Complete Shortcut Structure

Your shortcut should look like this:

```
┌─────────────────────────────────────────────────────────────┐
│ Find [Exercise Minutes] where                               │
│   [Start Date] [is] [today]                                 │
├─────────────────────────────────────────────────────────────┤
│ Calculate [Sum] of [Health Samples]                         │
├─────────────────────────────────────────────────────────────┤
│ If [Calculation Result] [is greater than] [15]              │
│   ┌─────────────────────────────────────────────────────┐   │
│   │ Date [Current Date]                                 │   │
│   ├─────────────────────────────────────────────────────┤   │
│   │ Format [Date] as [Custom: yyyy-MM-dd]               │   │
│   ├─────────────────────────────────────────────────────┤   │
│   │ Text:                                               │   │
│   │ [Formatted Date]|Exercise|[Calculation Result] min  │   │
│   ├─────────────────────────────────────────────────────┤   │
│   │ Save [Text] to /Shortcuts/gym-gate/workouts.txt     │   │
│   └─────────────────────────────────────────────────────┘   │
│ Otherwise                                                   │
│   ┌─────────────────────────────────────────────────────┐   │
│   │ Show Notification: "Only X exercise minutes..."     │   │
│   └─────────────────────────────────────────────────────┘   │
│ End If                                                      │
└─────────────────────────────────────────────────────────────┘
```

---

### Step 10: Test the Shortcut

1. Tap the **Play** button (▶️) at the bottom
2. First run will ask for **Health permissions** → Tap **Allow**
3. First run will ask for **File permissions** → Tap **Allow**

**Check the result:**

4. Open **Files** app on your iPhone
5. Navigate to: **iCloud Drive → Shortcuts → gym-gate**
6. You should see **workouts.txt**
7. Tap to open it - you should see something like:
   ```
   2025-01-04|Exercise|32 min
   ```

If you see the file with today's date, **success!** 🎉

---

## Part 2: Set Up Automation

Now let's make it run automatically.

### Option A: Run Every Few Hours (Recommended)

1. Open **Shortcuts** app
2. Tap **Automation** (bottom tab)
3. Tap **+** (top right)
4. Tap **Time of Day**

Configure:

5. Tap **Time** and set to **12:00 PM** (noon)
6. Tap **Repeat** and select **Daily**
7. Tap **Next** (top right)

Add the action:

8. Tap **New Blank Automation** (or search bar)
9. Search for: **Run Shortcut**
10. Tap to add it
11. Tap **Shortcut** and select **Gym Gate Sync**
12. Tap **Next**

Finish:

13. **IMPORTANT:** Toggle OFF **Ask Before Running**
14. Tap **Done**

**Repeat** to create another automation at **6:00 PM** and **9:00 PM** to catch evening workouts.

---

### Option B: Run When You Open a Specific App

1. **Automation** → **+** → **App**
2. Select an app you open after workouts (like Music, or a podcast app)
3. Choose **Is Opened**
4. Add action: **Run Shortcut** → **Gym Gate Sync**
5. Toggle OFF **Ask Before Running**

---

### Option C: Run From Control Center (Manual)

1. Go to **Settings → Control Center**
2. Scroll down and add **Shortcuts**
3. Now you can swipe down and tap Shortcuts to run Gym Gate Sync anytime

---

## Part 3: Link to Your Mac

On your Mac, open Terminal and run:

```bash
gym-gate link-icloud
```

Or manually:

```bash
mkdir -p ~/.config/gym-gate

# Create symlink to iCloud file
ln -sf "$HOME/Library/Mobile Documents/com~apple~CloudDocs/Shortcuts/gym-gate/workouts.txt" \
       "$HOME/.config/gym-gate/workouts.txt"
```

**Verify it works:**

```bash
cat ~/.config/gym-gate/workouts.txt
```

You should see your workout data!

---

## Part 4: Configure gym-gate Threshold

By default, gym-gate requires **15 minutes** of exercise to count. To change this:

```bash
# Set to 20 minutes
gym-gate set-threshold 20

# Set to 30 minutes (hardcore mode)
gym-gate set-threshold 30

# Check current threshold
gym-gate status
```

---

## Troubleshooting

### "No Health Samples found"

- Open Health app → Browse → Activity → Exercise Minutes
- Make sure you have data for today
- Check that Shortcuts has Health permissions:
  - Settings → Health → Data Access & Devices → Shortcuts → Enable

### Shortcut asks for permission every time

- Settings → Shortcuts
- Scroll down and enable **Private Sharing**
- Also try: Settings → Shortcuts → Advanced → **Allow Running Scripts**

### File not syncing to Mac

1. Check iCloud Drive is enabled:
   - iPhone: Settings → [Your Name] → iCloud → iCloud Drive (ON)
   - Mac: System Settings → Apple ID → iCloud → iCloud Drive (ON)

2. Force iCloud refresh on Mac:
   ```bash
   killall bird
   ```

3. Check the file exists:
   ```bash
   ls -la "$HOME/Library/Mobile Documents/com~apple~CloudDocs/Shortcuts/gym-gate/"
   ```

### Automation not running

- Settings → Shortcuts → Advanced
- Enable **Allow Running Scripts**
- Enable **Allow Sharing Large Amounts of Data**
- Make sure **Ask Before Running** is OFF in the automation

### "gym-gate: command not found"

Make sure you installed it:
```bash
# Check if it exists
which gym-gate

# If not, add to PATH
export PATH="$HOME/.local/bin:$PATH"

# Or copy to system bin
sudo cp gym-gate /usr/local/bin/
```

---

## Quick Reference

### Shortcut Summary
```
Find Exercise Minutes (today)
    → Calculate Sum
    → If Sum > 15 minutes
        → Save to iCloud: /Shortcuts/gym-gate/workouts.txt
    → Otherwise
        → Show "not enough exercise" notification
```

### File Format
```
2025-01-04|Exercise|32 min
2025-01-03|Exercise|45 min
2025-01-02|Exercise|28 min
```

### gym-gate Commands
```bash
gym-gate install        # Set up global git hook
gym-gate status         # Check today's status
gym-gate sync           # Check iCloud sync status
gym-gate log "workout"  # Manual override
gym-gate bypass         # Skip for 1 hour
gym-gate set-threshold 20  # Change minimum minutes
```

---

## Privacy Note

All your data stays on your devices:
- iPhone (HealthKit) → iCloud Drive → Mac

Nothing is sent to external servers. The file only contains:
- Date
- "Exercise" label
- Duration in minutes

No heart rate, GPS, or other sensitive health data is included.
