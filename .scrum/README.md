# Scrum Directory

This directory contains Scrum/Agile project management artifacts.

## Structure

```
.scrum/
├── config.json       # Scrum configuration
├── backlog.json      # Product backlog
├── sprints/          # Sprint data
├── standups/         # Daily standup notes
├── retros/           # Retrospective documents
└── velocity.json     # Velocity tracking
```

## Commands

Use Claude Code slash commands for Scrum management:

```bash
/scrum-backlog list          # List backlog items
/scrum-backlog add "title"   # Add new item
/scrum-sprint start          # Start new sprint
/scrum-standup               # Record standup
/scrum-retro                 # Create retrospective
```

## Configuration

Edit `config.json` to customize:
- Sprint duration
- Priority levels
- Story point scale
- Feature toggles

## Backlog Management

Priority levels:
- **critical**: Must be done immediately
- **high**: Should be done this sprint
- **medium**: Plan for upcoming sprints
- **low**: Nice to have

Story point scale (Fibonacci):
- 1, 2, 3, 5, 8, 13, 21
