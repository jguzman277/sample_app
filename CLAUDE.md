# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Rails 8.0.2 application with PostgreSQL, Devise authentication, and Hotwire (Turbo + Stimulus). The app uses Tailwind CSS for styling and implements a post/comment system with custom notification functionality.

## Development Setup & Commands

### Initial Setup
```bash
bin/setup                # Run initial setup (installs dependencies, sets up DB)
```

### Running the Application
```bash
bin/dev                  # Start all development services (Rails server, JS build, CSS watch)
bin/rails server         # Run Rails server only
```

### Database
```bash
bin/rails db:create      # Create database
bin/rails db:migrate     # Run migrations
bin/rails db:seed        # Seed database with Faker data
bin/rails db:reset       # Drop, create, migrate, and seed database
```

### Testing (RSpec)
```bash
bundle exec rspec                              # Run all tests
bundle exec rspec spec/models/post_spec.rb     # Run specific test file
bundle exec rspec spec/models/post_spec.rb:10  # Run specific test at line 10
```

### Linting & Security
```bash
bin/rubocop              # Run Ruby linter (Omakase style)
bin/brakeman             # Run security vulnerability scanner
```

### Asset Building
```bash
yarn build               # Build JavaScript once
yarn build --watch       # Build JavaScript in watch mode
bin/rails tailwindcss:watch    # Watch and rebuild Tailwind CSS
```

## Architecture & Key Patterns

### Data Model
- **User**: Devise-authenticated users with first_name, last_name, admin, and active fields
- **Post**: User-generated posts (belongs_to :user)
- **Comment**: Comments on posts (belongs_to :post, belongs_to :user)
- Custom notification system using comment fields (notification_sent, notification_read) instead of Noticed gem

### Authentication & Authorization
- **Devise** handles user authentication
- **CanCanCan** provides authorization (ability.rb is currently stubbed out)
- ApplicationController permits first_name, last_name, admin, active for sign_up and account_update

### Notification System
The app implements a custom notification system for comments:
- Comments track notification state via `notification_sent` and `notification_read` boolean fields
- ApplicationController#set_notifications runs before every action for signed-in users, loading unread notifications
- User model methods:
  - `unread_comment_notifications_count` - count of unread notifications
  - `unread_comment_notifications` - query unread notifications
  - `mark_all_comment_notifications_as_read!` - mark all as read
  - `clear_all_comment_notifications!` - reset notification flags
- Comment routes include member/collection actions for notification management

### Frontend Stack
- **Hotwire**: Turbo for SPA-like navigation, Stimulus for JavaScript controllers
- **Stimulus Controllers** in app/javascript/controllers/:
  - navbar_controller.js - Navigation bar interactions
  - dropdown_controller.js - Dropdown menus
  - notifications_controller.js - Notification UI management
- **Action Cable**: WebSocket support configured (channels in app/javascript/channels/)
- **Import Maps**: JavaScript dependencies managed via importmap.rb (not webpack/esbuild for app code)
- **Tailwind CSS**: Utility-first CSS framework with custom configuration

### Background Jobs
- **Sidekiq** is configured for background job processing
- **Solid Queue** provides database-backed Active Job adapter

### Pagination
- **Pagy** gem handles pagination (included in ApplicationController via Pagy::Backend)

### Admin Interface
- **Madmin** provides admin UI (routes defined in madmin.rb draw file)

### Forms
- **SimpleForm** with Tailwind styling (simple_form-tailwind gem)

## Important Files & Locations

### Configuration
- `Procfile.dev` - Development processes (web, js, css)
- `config/routes.rb` - Nested comment routes under posts, notification management routes
- `config/importmap.rb` - JavaScript import map configuration
- `.env` files - Environment variables (dotenv-rails in development/test)

### Models
- `app/models/user.rb` - Custom notification methods (lines 14-34)
- `app/models/comment.rb` - Notification scopes and methods
- `app/models/ability.rb` - CanCanCan authorization (currently empty)

### Controllers
- `app/controllers/application_controller.rb` - Sets @notifications and @unread_count before actions

### Testing
- RSpec with FactoryBot and Faker for test data
- Capybara + Selenium for system tests
- Test files in spec/ follow Rails conventions (models, requests, features, etc.)

## Common Patterns

### Adding New Migrations
```bash
bin/rails generate migration MigrationName
bin/rails db:migrate
```

### Adding New Models
```bash
bin/rails generate model ModelName field:type
# Review migration, then run:
bin/rails db:migrate
```

### Working with Stimulus Controllers
Controllers auto-load from app/javascript/controllers/ via stimulus-loading.js. Use data-controller attribute in views to connect.

### Notification Pattern
When adding new notifiable features, follow the Comment model pattern:
1. Add notification_sent and notification_read boolean fields
2. Create scopes for filtering notifications
3. Add user methods to query/manage notifications
4. Update ApplicationController#set_notifications if needed

## Key Dependencies
- Rails 8.0.2
- PostgreSQL (pg gem)
- Devise 4.9 (authentication)
- CanCanCan (authorization)
- Hotwire (turbo-rails, stimulus-rails)
- Tailwind CSS (tailwindcss-rails 4.3)
- Pagy 9.4 (pagination)
- SimpleForm 5.3 with Tailwind
- RSpec Rails 6.1 (testing)
- FactoryBot & Faker (test data)
- Sidekiq (background jobs)
- Madmin (admin interface)
