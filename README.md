# iHero ActiveAdmin and API Application

It provides ActiveAdmin web app and API for iOS iHero(Kiprosh Rewards) app.


# Dependencies

### MacOS (Mojave or above)

| Program Name   | Version Number  | Install / Download                          | Details                       |
| -------------- | --------------- | --------------------------------------------| ----------------------------- |
| Ruby           | 2.7.1           |
| Rails          | 6.1.3           |
| PostgreSQL     | 11.x.x           | https://www.postgresql.org/download/macosx/ | Database                      |
| Yarn           | 1.15.2          |

# Setup application on local

1. Install gems

```
bundle
```

2. Create the database, load the schema, and initialize it with the seed data.

```
rails db:setup
```

3. Start the application

```
rails s
```

# Documentation

- API documentation is available online at https://ihero-api.herokuapp.com/api/docs
