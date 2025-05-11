# TitanOS Technical Challenge

*SENIOR RUBY ON RAILS BACKEND DEVELOPER TECHNICAL TEST*

You are provided with a JSON file that contains information about streaming content.\
Your task is to develop an API, that includes the following features:\
We have six types of contents: Movies, Tv Shows, Seasons, Episodes, Channels and Channel Programs.\
All contents belong to an App and are available or not depending on the country.

Only a name is provided for an App.\
Movies, TvShows, Seasons and Episodes have in common a title, a year and a duration in seconds.\
Seasons and Episodes have a number.

Episodes belong to a Season who themselves belong to a Tv Show.\
Channel programs belong to a Channel.

Example:\
"John Wick" is a movie that is available on Netflix in Spain and on Prime Video in the UK.\
"Modern Family" is a TVShow that is available on RakutenTV in Spain and on Netflix in the UK. Season 2 of this show is only available in the UK.\
"Nickelodeon" is a channel that is available on AMAGI in Spain, and streams "SpongeBob" every day from 13:00 to 15:00.

The API must provide the following endpoints:
- A list of filtered contents depending on each type of content. :country filter is always required. In case no :type filter is received, return all contents for that country.
- A show endpoint for each type of content. In the case of channel programs, provide as well, time watched for that program.
- A list of favorites channel programs for the user, based on time watched.
- A list of favorite apps for the user. The order of the apps are based on the position the user chooses.
- An endpoint to favorite the app and set its position.
- A search that returns all possible types of content based on the query. The search can be done through the title or the year. In the case of an App through its name.

Implement the specs you consider necessary.

## How to setup

The REST API application is created with Ruby 3.3.3 and Rails 7.1.5. I have chosen MySQL as the database because I am familiar with it, but it could be done with another database, and I have used [RuboCop gem](https://github.com/rubocop/rubocop) for code analysis and formatting.

First, you need to add your database configuration in `config/database.yml` file.

Then, run the following commands to create and populate the database:

```
bundle install
rails db:create
rails db:migrate
rails db:seed
```

And finally, run the server:

```
rails server
```

## Data structures

The data models in this application follow the structure of the original JSON schema.

There are 12 models in total, organized into three main categories:
- App-related: `App`, `Availability`
- Content-related: `Movie`, `TvShow`, `Season`, `Episode`, `Channel`, `ChannelProgram`, `Schedule`
- User-related: `User`, `FavoriteApp`, `FavoriteProgram`

## API endpoints

The following table shows the endpoints of the API and their parameters:

| Method | Endpoint                       | Description                                | Parameters                        |
| ------ | ------------------------------ | ------------------------------------------ | --------------------------------- |
| GET    | `/contents`                    | List of contents available in a country    | `country` (required), `type`      |
| GET    | `/contents/:type/:id`          | Show details of a specific content	       | `type`, `id` (path), `user_id`    |
| GET    | `/contents/search`             | Search contents based on the query         | `q` (required)                    |
| GET    | `/users/:id/favorite_programs` | List of favorite channel programs for user | `id` (path)                       |
| GET    | `/users/:id/favorite_apps`     | List of favorite apps for user             | `id` (path)                       |
| POST   | `/users/:id/favorite_apps`     | Create a new favorite app for user         | `id` (path), `app_id`, `position` |

For example, to retrieve the list of movies available in the UK:

```
http://localhost:3000/api/v1/contents?country=gb&type=movies
```

And the response body has the following JSON format:

```json
{
  "data": [
    {
      "id": 1,
      "original_title": "Star Wars: Episode V - The Empire Strikes Back",
      "year": 1980,
      "duration_in_seconds": 7440,
      "type": "movie"
    }
  ]
}
```

Also, I have used [Apipie gem](https://github.com/Apipie/apipie-rails) to describe endpoints and validate parameters. The documentation is available in `/apipie` route.

## Run tests

I have created 20 tests with 60 assertions in total using Minitest, each targeting different workflows for comprehensive validation.

Run all tests with the following command:

```
rails test
```

Also, I have used [SimpleCov gem](https://github.com/simplecov-ruby/simplecov) to gather code coverage data of services and controllers, which shows 100%.

**THANKS FOR READING!!**
