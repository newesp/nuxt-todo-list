# Project Context

## Overview
A Todo Application built with Nuxt.js, Supabase, and Tailwind CSS (via Nuxt UI).
The goal is to create a premium, aesthetically pleasing, and functional todo app.

## Tech Stack
- **Framework**: Nuxt.js (Vue 3)
- **UI Library**: Nuxt UI (Tailwind CSS based)
- **Backend/Database**: Supabase
- **State Management**: Nuxt useState / Pinia (if needed)
- **Language**: TypeScript

## Conventions
- Use Composition API with `<script setup lang="ts">`.
- Use `useSupabaseClient` for database interactions.
- Follow Nuxt directory structure (pages, components, server, etc.).
- Use "Rich Aesthetics" as per user request (vibrant colors, smooth animations).

## Architecture
- **Frontend**: Nuxt.js SSR/CSR.
- **Auth**: Supabase Auth (Email/Password).
- **Database**: Postgres (Supabase).
- **RLS**: Row Level Security must be enabled for all tables.
