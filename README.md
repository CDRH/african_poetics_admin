# African Poets in the News

This Ruby on Rails app hosts a data entry application for the African Poets in the News project.

Occasionally the data in this application will be published in another application which showcases
not only this information, but also information about Contemporary African Poets. See below for
information about [how to publish](#how-to-publish) the data.

For production, remember to include `RAILS_ENV=production` before the commands.

## Setup

### Prepare database

- `rails db:create`
- `rails db:migrate`
- Date validations on the Event and Person models will need to be temporarily
  disabled for seeding with the current versions of the CSV's used for seeding
- `rails db:seed`
- Re-enable date validations

### Ingest Locations

`rake african_poetics:ingest_location`

### Precompile Assets

Production only

`RAILS_ENV=production RAILS_RELATIVE_URL_ROOT="/admin" rails assets:precompile`

## How to Publish

If you are working on a server, there should be two databases:  the admin database, and a
frontend database. Additionally, there should be a database user with rights to each of them,
as well as a user with read-only permissions to the frontend database. 

Identify the names of the two databases on this server and the user with privileged access to both,
then make sure that the config file located at `lib/tasks/config.sh` looks like:

```bash
DB_FROM="admin_db_name"
DB_TO="frontend_db_name"
USER="user_for_both"
PSWD="user_password"
```
Once configured, run:

```bash
rake african_poetics:publish
```

You may also publish the database and elasticsearch components separately, if desired.

```bash
rake african_poetics:publish_db
rake african_poetics:publish_es
```

You may wish to do this in the case that you need to reindex Elasticsearch but do not wish to update the database, for example if the Elasticsearch index has been accidentally cleared. In that case, to reindex from the frontend DB, add a new environment to this Rails app with the frontend database, then run `ENV=your_env_name rake african_poetics:publish_es` to repopulate Elasticsearch from the appropriate database.

## Clear Elasticsearch

By default, when running the publish script, the Elasticsearch index will be cleared in order to ensure any deletions made in the admin DB will not be present in search results. However, if you would like to manually clear the Elasticsearch index, you may use the following task:

```bash
rake african_poetics:index_clear
```
