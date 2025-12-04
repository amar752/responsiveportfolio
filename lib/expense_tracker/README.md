# Expense Tracker App

A Flutter-based expense tracker application with SQLite database storage.

## Features

- **Add Expenses**: Create new expenses with title, amount, category, and date
- **Edit Expenses**: Modify existing expense entries
- **Delete Expenses**: Remove expenses from the database
- **Category Tracking**: Organize expenses by category (Food, Transportation, etc.)
- **Summary Statistics**: View total expenses and breakdown by category
- **Date Selection**: Pick custom dates for expenses
- **Persistent Storage**: All data stored in SQLite database

## Project Structure

```
lib/expense_tracker/
├── models/
│   └── expense.dart           # Expense data model
├── services/
│   └── database_service.dart  # SQLite database operations
├── screens/
│   └── expense_tracker_screen.dart  # Main UI screen
└── widgets/
    ├── add_expense_dialog.dart      # Dialog for adding/editing
    └── expense_list_item.dart       # Individual expense list item
```

## Dependencies

- **sqflite**: SQLite database for Flutter
- **path**: Path manipulation library
- **intl**: Internationalization and localization for date formatting

## Getting Started

1. **Install dependencies**:
   ```bash
   flutter pub get
   ```

2. **Run the app**:
   ```bash
   flutter run -t lib/main_expense_tracker.dart
   ```

## Database Schema

The app uses a single `expenses` table with the following columns:
- `id`: Integer (Primary Key, Auto-increment)
- `title`: Text (Required)
- `amount`: Real (Required)
- `category`: Text (Required)
- `date`: Text (ISO8601 format, Required)
- `description`: Text (Optional)

## Usage

### Adding an Expense
1. Tap the floating action button (+)
2. Fill in the expense details
3. Select a category and date
4. Add optional description
5. Tap "Save"

### Editing an Expense
1. Long press or tap menu on an expense item
2. Select "Edit"
3. Modify the details
4. Tap "Save"

### Deleting an Expense
1. Tap menu on an expense item
2. Select "Delete"
3. Confirm the deletion

### Viewing Statistics
- Total expenses are displayed at the top
- Category breakdown shows spending by category
- All data updates in real-time

## Database Operations

The `DatabaseService` provides the following methods:
- `insertExpense()`: Add a new expense
- `getAllExpenses()`: Retrieve all expenses
- `getExpensesByDateRange()`: Filter by date range
- `getExpensesByCategory()`: Filter by category
- `updateExpense()`: Modify an existing expense
- `deleteExpense()`: Remove an expense
- `getTotalExpenses()`: Get sum of all expenses
- `getTotalByCategory()`: Get category breakdown
