# DBT Users Activity Analysis

## What This Project Does

This project analyzes user activity data from a gaming application using DBT (Data Build Tool) and BigQuery.

### Input Data
- **Source**: BigQuery table `gen-lang-client-0879571644.case2.user_activity`
- **Content**: Daily user activity records with metrics like sessions, matches, revenue, etc.

### Output Data
- **Model**: BigQuery table `gen-lang-client-0879571644.case2.daily_metrics`
- **Content**: Daily aggregated metrics by date, country, and platform

### Key Metrics Calculated
- **DAU**: Daily Active Users
- **Revenue**: IAP revenue, Ad revenue, ARPDAU (Average Revenue Per Daily Active User)
- **Engagement**: Matches started, matches per user, win/loss ratios
- **Technical**: Server errors per user

## How to Use

1. **Setup**: Configure `profiles.yml` with your BigQuery credentials
2. **Run**: Execute `dbt run` to create the daily_metrics table
3. **Visualize**: Connect the daily_metrics table to Tableau Public for dashboards

## Files
- `models/daily_metrics.sql` - Main calculation logic
- `models/sources.yml` - Source table definition
- `models/schema.yml` - Output table documentation
- `tableau_guide.md` - Tableau Public dashboard setup instructions