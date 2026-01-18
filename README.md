# Reportly

**Automated Engineering Reports for Agencies & Freelancers**

Reportly turns your code activity into professional status reports in seconds. It connects to your repositories, analyzes your work, and uses AI to write clean, client-ready summaries—saving you hours of manual reporting every week.

## Key Features

- **Automated Commit Tracking**: Fetches activity directly from GitHub so you never miss a detail.
- **Smart Grouping**: Automatically organizes work into clear categories like Features, Fixes, etc.
- **AI Summarization**: Uses AI to summarize technical commit messages into a readable narrative for individuals.
- **Multi-Client Management**: Manage separate profiles, repositories, and reporting schedules for every client.
- **Review & Edit**: Preview reports, view raw commits, and make tweaks before sending.
- **Delivery Channels**: Email reports directly to your team or clients with a single click.

## Tech Stack

**Frontend (Mobile App)**
- **Flutter**: Cross-platform UI toolkit.
- **GetX**: State management and routing.
- **Animations**: Custom splash screens and UI transitions.

**Backend (Server)**
- **Serverpod**: Dart-based server framework.
- **PostgreSQL**: Database for storing companies, reports, and logs.
- **Globe.dev**: Deployment platform.

**Integrations**
- **GitHub API**: For fetching repository activity.
- **Groq AI**: For generating report summaries.
- **SMTP(Gmail)**: For reliable email delivery.
- **ClickUp** (Coming Soon): For task updates.
