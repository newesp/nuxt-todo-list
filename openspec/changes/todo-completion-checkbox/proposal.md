# Change Proposal: Todo Completion Checkbox

## Why
Users need a visual way to mark todos as complete or incomplete. This is a core feature of any todo application.

## Goal
Provide a checkbox to toggle todo completion state with visual feedback (strikethrough text).

## What Changes
- Add checkbox component for each todo item
- Implement toggle functionality to update completion status
- Add strikethrough styling for completed todos
- Update database when completion status changes

## Scope
- UI: Checkbox component in todo list
- Logic: `toggleTodo()` function to update database
- Styling: Strikethrough and color changes for completed items
- Database: Uses existing `completed` boolean field in todos table

## Status
**Already Implemented** - This feature was part of the initial implementation.

## Implementation Details

### UI Components
- `UCheckbox` component with rounded style
- Binds to `todo.completed` via v-model
- Triggers `toggleTodo()` on change

### Styling
- Completed todos: Gray text with strikethrough
- Uses: `text-gray-400 line-through decoration-2 decoration-primary-500/50`
- Smooth transition animation

### Database
- Updates `completed` field in todos table
- Protected by RLS policies
- Optimistic UI update (v-model handles immediate feedback)
