# African Poets in the News

## Setup

Prepare database

- `rails db:create`
- `rails db:migrate`
- Date validations on the Event and Person models will need to be temporarily
  disabled for seeding with the current versions of the CSV's used for seeding
- `rails db:seed`
- Re-enable date validations

## Ingest Locations

rake african_poetics:ingest_location
