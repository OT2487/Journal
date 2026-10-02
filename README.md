# Idea Vault — synced version

This version uses Supabase for authentication + cloud storage, so the same journal can be opened on your phone and computer.

## Setup

1. Create a free Supabase project.
2. In Supabase, open **SQL Editor** and run `schema.sql`.
3. In the Supabase project settings, copy the **Project URL** and **Publishable key**.
4. Open `index.html` and replace:
   - `YOUR_SUPABASE_URL`
   - `YOUR_SUPABASE_PUBLISHABLE_KEY`
5. Put `index.html` and `manifest.webmanifest` on a static host.
6. Open the published site, create your account, and use that same account on every device.

GitHub Pages can host the static files. The Supabase JavaScript client is loaded through a CDN in `index.html`.

## Important

The publishable/anon key is designed to be used by the browser. The database is protected by Row Level Security policies in `schema.sql`, which restrict journal rows to the signed-in owner. Never put a Supabase service-role/secret key in this website.

## Phone

Once the site is live, open it in your phone's browser. On supported browsers, use the browser's **Add to Home Screen** option to make it behave more like an app.

## Current features

- Account sign-in/sign-up
- Cloud-synced journal entries
- Search
- Tags
- Mood
- Favorites
- New/edit/delete entries
- Thought prompts
- Responsive phone layout
