# Sprint Burndown

Track and visualize sprint progress with burndown charts and metrics.

## Instructions

### Burndown Tracking

1. Store burndown data in `.scrum/burndowns/sprint-{n}-burndown.json`
2. Data structure:

```json
{
  "sprint_id": "sprint-{n}",
  "start_date": "YYYY-MM-DD",
  "end_date": "YYYY-MM-DD",
  "total_points": 34,
  "daily_remaining": [
    {"date": "YYYY-MM-DD", "remaining": 34, "completed": 0, "added": 0},
    {"date": "YYYY-MM-DD", "remaining": 31, "completed": 3, "added": 0}
  ],
  "ideal_burndown": [34, 31, 27, 24, 20, 17, 14, 10, 7, 3, 0]
}
```

### Burndown Actions

#### Default - Show current burndown

1. Load current sprint burndown
2. Display ASCII chart
3. Show progress metrics

```
Sprint {n} Burndown
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Points
  34 │●─────────────────────────────────────
  30 │  ●●                          ·······
  25 │      ●●●                ·····
  20 │           ●●        ····
  15 │               ●  ···          Actual: ●
  10 │               ●··             Ideal:  ·
   5 │                ●●
   0 │                     ●─────────────────
     └────────────────────────────────────────
       1  2  3  4  5  6  7  8  9  10  Day

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Day 7 of 10 | Remaining: 5 pts | Target: 10 pts
Status: AHEAD OF SCHEDULE (+5 pts)
```

#### `update` - Record daily progress

1. Calculate remaining points
2. Record completed items
3. Note any scope changes
4. Update burndown data

#### `daily` - Quick daily update

1. Scan completed items since last update
2. Auto-calculate remaining points
3. Check for added scope
4. Update burndown

#### `forecast` - Project completion

1. Calculate current velocity
2. Project completion date
3. Identify risk of incomplete items

```
Sprint Completion Forecast
━━━━━━━━━━━━━━━━━━━━━━━━━━

Current Rate: 4.2 pts/day
Remaining: 12 pts
Days Left: 3

Projected Completion: Day 10 (on target)

Risk Assessment:
  ✓ On track to complete all items
  ! 2 items have dependencies that may delay

Confidence: 85%
```

#### `trend` - Show velocity trend

1. Load historical burndown data
2. Calculate velocity patterns
3. Display trend analysis

```
Velocity Trend (Last 5 Sprints)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Sprint  Planned  Actual  Variance
──────  ───────  ──────  ────────
  1       30       25      -17%
  2       30       28       -7%
  3       32       33       +3%
  4       34       31       -9%
  5       34       34        0%

Trend: ↗ Improving (+4.6% avg improvement)
Recommended Sprint Load: 32-35 points
```

#### `scope` - Track scope changes

1. Display original vs current scope
2. Show added/removed items
3. Calculate scope creep percentage

```
Sprint Scope Analysis
━━━━━━━━━━━━━━━━━━━━━

Original Scope: 34 points (8 items)
Current Scope:  38 points (9 items)
Scope Change:   +4 points (+12%)

Added Items:
  + MONO-010: Hotfix for auth (3 pts) - Day 3
  + MONO-011: Config update (1 pt) - Day 5

Removed Items:
  - None

Impact: Sprint may extend by ~1 day
```

#### `compare {sprint1} {sprint2}` - Compare sprints

1. Load both sprint burndowns
2. Compare patterns
3. Highlight differences

#### `export` - Export burndown data

1. Generate CSV/JSON export
2. Include all metrics
3. Format for external tools

### Burndown Metrics

**Key Indicators:**
- **Burn Rate:** Points completed per day
- **Remaining Work:** Points left in sprint
- **Scope Creep:** Points added after sprint start
- **Variance:** Difference from ideal burndown

**Status Indicators:**
- AHEAD: > 10% ahead of ideal
- ON TRACK: Within 10% of ideal
- AT RISK: 10-25% behind ideal
- BEHIND: > 25% behind ideal

### Integration

- Auto-update from backlog changes
- Link to standup blockers
- Update on item completion
- Feed into velocity calculations

## Arguments

- `$ARGUMENTS` - Optional: `update`, `daily`, `forecast`, `trend`, `scope`, `compare {s1} {s2}`, `export`

## Output

Display sprint burndown visualization and progress metrics.
