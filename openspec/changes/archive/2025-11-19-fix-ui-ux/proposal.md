# Change Proposal: Fix UI/UX Issues

## Why
The user reported that the "Todo AI" header text is obscured and the todo input button is non-functional. Screenshots show layout misalignment and potential z-index issues.

## Goal
Fix the header visibility and ensure the todo input form is styled correctly and functional.

## What Changes
- Adjust `app/layouts/default.vue` header styling for better contrast and visibility.
- Fix `app/pages/index.vue` input form layout (flexbox/positioning) to ensure the button is clickable and aligned.
- Remove or adjust the blur effect if it's blocking interactions.
