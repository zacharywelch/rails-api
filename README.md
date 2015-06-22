## Rails API Template

Sample music API using Rails

### Technology Stack

- [rails-api](https://github.com/rails-api/rails-api)
- [jbuilder](https://github.com/rails/jbuilder)
- [responders](https://github.com/plataformatec/responders)
- [rspec](https://github.com/rspec/rspec-rails)
- [factory girl](https://github.com/thoughtbot/factory_girl_rails)

### Data Model

The following domain is used to illustrate key principles and maintain focus on building APIs:

- Artist
- Albums
- Songs

An artist has many albums. An album has many songs.

### Goals

- Conventions
- Layered Architecture (MVC)
- Validations
- Tests
- Generators
- JSON representation
- Routing
- Managing complex queries (scopes)
- Support for different environments
- Logging
- Authentication
- Caching