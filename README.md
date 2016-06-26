# lita-votma

We are extremely busy people, so we don't have the time to see the same cat picture over and over again. `lita-votma` helps you avoid wasting your time with cat pictures you've already seen.

## Installation

Add lita-votma to your Lita instance's Gemfile:

``` ruby
gem 'lita-votma'
```

## Usage

The plugin automatically warns about posting the same content multiple times (regardless of channels). Lita must be present in the room/channel.
If you'd like to use the plugin, simply include it in your gemfile. You can customize the messages with the configuration options explained in the [Configuration section](#configuration).

## Configuration

`lita-votma` exposes the following configuration options:

| Option name         | Description                                        | Required |
|---------------------|----------------------------------------------------|----------|
| votma_once_msg      | Message to display for URLs posted twice           | No       |
| votma_manytimes_msg | Message to display for URLs posted more than twice | No       |

The following placeholders can be used in the messages:

| Placeholder             | Description                                             |
|-------------------------|---------------------------------------------------------|
| sender                  | User posting the URL                                    |
| first_poster            | User first posting the URL                              |
| first_posted_at         | Timestamp of first posting                              |
| first_posted_in_channel | The channel where the URL was posted for the first time |
| last_poster             | Last user posting the URL                               |
| last_posted_at          | Timestamp of last post                                  |
| last_posted_in_channel  | The channel where the URL was posted last time          |
| times_posted            | Overall URL post counter                                |

These should be used in the following syntax: `%{sender}`

## Contribution

Contributions are welcome.

## Why 'votma'

TODO

