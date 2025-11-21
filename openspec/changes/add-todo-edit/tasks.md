# Implementation Tasks: Add Todo Inline Edit

## Completed Tasks

### UI Implementation
- [x] Add click-to-edit for todo title
- [x] Add click-to-edit for due date
- [x] Implement inline edit mode with input fields  
- [x] Add save/cancel buttons
- [x] Add delete button for due date in edit mode
- [x] Style edit mode UI (hover effects, transitions)

### Logic Implementation
- [x] Create edit state management (`editingTodoId`, `editingField`)
- [x] Implement `startEditTitle()` function
- [x] Implement `startEditDueDate()` function
- [x] Implement `saveEdit()` function with database update
- [x] Implement `cancelEdit()` function
- [x] Add validation for empty titles
- [x] Add keyboard shortcuts (Enter to save, Esc to cancel)

### OpenSpec Documentation
- [x] Create change proposal
- [x] Create implementation tasks

## Implementation Details

### User Experience
- **Click to edit**: Users click on todo title or due date to enter edit mode
- **No edit button**: Cleaner UI without extra buttons
- **Visual feedback**: Hover effects show clickable areas
- **Keyboard support**: Enter saves, Escape cancels
- **Chinese UI**: Buttons labeled in Chinese (儲存, 取消, 移除)

### State Management
- `editingTodoId`: Tracks which todo is being edited
- `editingField`: Tracks whether editing 'title' or 'dueDate'
- `editTitle`: Temporary value for title being edited
- `editDueDate`: Temporary value for due date being edited

### Validation
- Empty titles are rejected with error toast
- Due date can be removed (set to null)
- Changes are only saved on explicit save action
