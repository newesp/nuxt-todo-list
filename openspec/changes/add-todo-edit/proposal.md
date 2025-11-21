# Change Proposal: Add Todo Inline Edit

## Why
Users need the ability to correct mistakes or update todo information after creation. Without edit functionality, users must delete and recreate todos, which is inefficient and loses completion status.

## Goal
Enable inline editing of todo titles and due dates with a smooth, intuitive user experience using click-to-edit interaction.

## What Changes
- Add click-to-edit functionality for todo titles
- Add click-to-edit functionality for due dates
- Implement save/cancel/delete actions for edits
- Add validation for empty titles

## Scope
- UI changes in `app/pages/index.vue`
- No database schema changes (using existing update RLS policies)
- Click interaction: click text to edit, no separate edit button needed

## Risks
- None. Using existing database update functionality and RLS policies.
- Edit state is properly isolated per todo item.
