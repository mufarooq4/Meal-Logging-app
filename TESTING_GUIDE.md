# Testing Guide

## Manual Testing Checklist

### 1. Calendar Screen Tests

#### Test 1: Log a Breakfast
- [ ] Tap on today's date
- [ ] Select "Breakfast" (Blue option)
- [ ] Verify the date turns blue
- [ ] Tap the same date again
- [ ] Verify "Remove Log" option appears

#### Test 2: Change Meal Type
- [ ] Tap a blue (breakfast) date
- [ ] Select "Full Day Mess" (Orange)
- [ ] Verify the date changes from blue to orange

#### Test 3: Multiple Dates
- [ ] Log meals for 5 different dates
- [ ] Verify each date shows the correct color
- [ ] Verify colors persist after app restart

#### Test 4: Remove Log
- [ ] Tap a logged date
- [ ] Select "Remove Log"
- [ ] Verify the date returns to normal (no color)

### 2. Statistics Screen Tests

#### Test 1: View Current Month
- [ ] Go to Statistics tab
- [ ] Verify "Total Bill" shows correct calculation
- [ ] Verify meal counts are accurate

#### Test 2: Month Navigation
- [ ] Tap left arrow to go to previous month
- [ ] Verify month name updates
- [ ] Verify statistics show data for that month
- [ ] Tap right arrow to return

#### Test 3: Empty Month
- [ ] Navigate to a future month with no data
- [ ] Verify all counts show 0
- [ ] Verify total bill shows Rs. 0.00

#### Test 4: Monthly Summary
- [ ] Log 3 different meals in current month
- [ ] Go to Statistics
- [ ] Verify "Total Days Logged" = 3
- [ ] Verify "Average Cost Per Day" is correct

#### Test 5: All-Time Bill
- [ ] Log meals across multiple months
- [ ] Verify "Cumulative All-Time Bill" shows total

#### Test 6: Clear Month Data
- [ ] Select a month with data
- [ ] Tap "Clear Month Data"
- [ ] Confirm deletion in dialog
- [ ] Verify all data for that month is deleted
- [ ] Verify other months are unaffected

### 3. Settings Screen Tests

#### Test 1: View Default Prices
- [ ] Go to Settings tab
- [ ] Verify default prices are displayed:
  - Breakfast: Rs. 50.00
  - Lunch + Dinner: Rs. 100.00
  - Full Day: Rs. 150.00

#### Test 2: Update Prices
- [ ] Change Breakfast to Rs. 75.00
- [ ] Tap "Save Prices"
- [ ] Verify success message appears
- [ ] Go to Statistics
- [ ] Verify calculations use new price

#### Test 3: Invalid Input
- [ ] Enter "abc" in a price field
- [ ] Tap "Save Prices"
- [ ] Verify error message appears

#### Test 4: Negative Price
- [ ] Enter "-50" in a field
- [ ] Tap "Save Prices"
- [ ] Verify error message appears

### 4. Theme Toggle Tests

#### Test 1: Switch to Dark Mode
- [ ] Tap moon icon in app bar
- [ ] Verify app switches to dark theme
- [ ] Verify all screens look good in dark mode

#### Test 2: Theme Persistence
- [ ] Switch to dark mode
- [ ] Close and restart app
- [ ] Verify app opens in dark mode

#### Test 3: Toggle Multiple Times
- [ ] Switch theme 3-4 times quickly
- [ ] Verify no crashes or glitches

### 5. Navigation Tests

#### Test 1: Bottom Navigation
- [ ] Tap each tab in bottom navigation
- [ ] Verify correct screen loads
- [ ] Verify active tab is highlighted

#### Test 2: Back Navigation
- [ ] Open meal selection sheet
- [ ] Tap outside or back button
- [ ] Verify sheet closes
- [ ] Verify no data is lost

### 6. Data Persistence Tests

#### Test 1: App Restart
- [ ] Log 5 meals
- [ ] Set custom prices
- [ ] Switch to dark mode
- [ ] Close app completely
- [ ] Reopen app
- [ ] Verify all data persists

#### Test 2: Date Range
- [ ] Log meals from 3 months ago to today
- [ ] Navigate through months in Statistics
- [ ] Verify all data is accessible

### 7. Edge Cases

#### Test 1: Today's Date
- [ ] Log a meal for today
- [ ] Verify today's highlight still works

#### Test 2: Past Date
- [ ] Log a meal for 1 year ago
- [ ] Navigate to that month
- [ ] Verify data appears correctly

#### Test 3: Rapid Tapping
- [ ] Tap multiple dates rapidly
- [ ] Verify no crashes
- [ ] Verify all selections work

#### Test 4: Large Numbers
- [ ] Set price to Rs. 99999.99
- [ ] Log 30 meals in a month
- [ ] Verify calculations are correct
- [ ] Verify UI doesn't break

## Performance Tests

### Test 1: Startup Time
- [ ] Close app completely
- [ ] Time how long it takes to open
- [ ] Should be < 3 seconds

### Test 2: Calendar Rendering
- [ ] Log meals for entire month (30 dates)
- [ ] Switch between months
- [ ] Should be smooth, no lag

### Test 3: Statistics Calculation
- [ ] Log 100+ meals across 6 months
- [ ] Open Statistics screen
- [ ] Should calculate instantly

## Visual Tests

### Test 1: Color Consistency
- [ ] Verify all blues match (Breakfast)
- [ ] Verify all greens match (Lunch+Dinner)
- [ ] Verify all oranges match (Full Day)

### Test 2: Layout on Different Screens
If possible, test on:
- [ ] Small phone (< 5 inches)
- [ ] Normal phone (5-6 inches)
- [ ] Large phone (> 6 inches)
- [ ] Tablet

### Test 3: Orientation
- [ ] Rotate device to landscape
- [ ] Verify UI adapts properly
- [ ] Verify no data loss

## Bug Reporting

If you find a bug, note:
1. Steps to reproduce
2. Expected behavior
3. Actual behavior
4. Device/emulator info
5. Screenshot if possible

## Test Results Template

```
Date: ___________
Tester: ___________
Device: ___________

Calendar Tests: ☐ Pass ☐ Fail
Statistics Tests: ☐ Pass ☐ Fail
Settings Tests: ☐ Pass ☐ Fail
Theme Toggle: ☐ Pass ☐ Fail
Navigation: ☐ Pass ☐ Fail
Data Persistence: ☐ Pass ☐ Fail
Edge Cases: ☐ Pass ☐ Fail

Issues Found:
-
-
-

Notes:


```

## Automated Testing (Future)

For future enhancements, consider adding:
- Unit tests for providers
- Widget tests for screens
- Integration tests for full flows
- Golden tests for UI consistency
