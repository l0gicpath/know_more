# Small Knowledge Base

This is a small Knowledge Base that will contain help articles divided by topics.


## Setup

To get started, a few configurations have to be set.

### Database

First is the database, you'll find a database configuration example called [database.yml.example](config/database.yml.example) in the `config`
directory. Copy it to `database.yml` and modify it to include the database settings needed.

The database used is postgresql, a server should be up and running on your machine before attempting to run this.

Next step is to create the database tables and run migrations:

```shell
$ bundle exec rails db:create
$ bundle exec rails db:migrate
```

### Translation Services

Second thing is the configuration of the translation services. The implementation lives in [lib/translator.rb](lib/translator.rb). This includes
a Microsoft Translation Service integration, simple but does the job well.

Currently the default service is set to `:google` however there is no Google implementation as of yet, 
so in [config/initializers/translations.rb](config/initializers/translations.rb) we are loading the translation services configuration of which
an example exists [config/translation_services.yml.example](config/translation_services.yml.example) and we are setting the service used to `:microsoft`

**Important** `config/translation_services.yml` is expected to be there, otherwise the application will not boot.

#### Google Integration

Google cloud translation API client is a bit special. It requires an environment variable to be set pointing at a creds json file, which
a sample of it lives in [config/google-auth.json.example](config/google-auth.json.example). This **must be replaced** with one downloaded from
Google developers console.

The environment variable part is already handled by the implementation, so all you need is to point at the right file.

## Features

- Users can list Articles, credit, edit and update them as well as delete them
- Article content can contain HTML formatting elements
