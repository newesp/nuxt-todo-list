# Change Proposal: Apple-Style UI Redesign

## Why
The original UI had two critical issues:
1. **FOUC (Flash of Unstyled Content)**: Elements appeared unstyled in the top-left corner before CSS loaded
2. **Basic Aesthetics**: The UI lacked visual polish and premium feel

## Goal
Transform the app into a premium, Apple-inspired interface with:
- Smooth loading experience (no FOUC)
- Glassmorphism effects (frosted glass)
- Polished animations and interactions
- Clean, minimal design language

## What Changes

### Core Design System
- **Custom CSS Variables**: Apple color palette, shadows, gradients
- **Glassmorphism Classes**: Reusable glass effects for cards/headers
- **Custom Checkbox**: Animated round checkbox with smooth transitions
- **Smooth Animations**: Spring-based transitions for all interactions

### FOUC Fix
- HTML starts with `opacity: 0`
- `ready` class added on mount triggers fade-in
- Smooth 300ms transition prevents visual flash

### Visual Improvements
- **Gradient Background**: Blue to purple gradient backdrop
- **Frosted Glass Cards**: Backdrop blur with subtle transparency
- **Rounded Corners**: 12-24px radius on all elements
- **Hover Effects**: Lift and shadow on hover
- **Color-Coded Badges**: Due dates with gradient pill badges

## Scope

### Files Modified
- `app/assets/css/main.css` - Complete design system
- `app/app.vue` - FOUC fix
- `app/layouts/default.vue` - Glassmorphism header
- `app/pages/index.vue` - Complete redesign
- `app/pages/login.vue` - Clean Apple login

### Design Tokens
- Apple blue: `#007AFF`
- Gradients: Blue-purple combination
- Shadows: Layered soft shadows
- Blur: 20px backdrop filter

## Status
**Completed** - All UI components redesigned with Apple aesthetics
