# README

Sprint Spades: A simple planning poker tool using Hotwire and Rails.

## Non Production Setup

To setup Sprint Spades on your local machine, follow the steps below:

* Install Ruby
  * ```brew install rbenv```
  * ```rbenv init```
  * ```ls -a ~```
  * ```rbenv install 3.1.2```

* Set up rails
  * ```gem install bundler```
  * ``` gem install rails -v 7.1.3```
* Install Redis
  * ```brew install redis```
  * ```brew services start redis```
* Clone the repo
* Set up your environment variables
  * ```rails credentials:edit```
  * Add the following
    * ```secret_key_base: <your secret key>```
    * ```google:```
      * ```client_id: <your google client id>```
      * ```client_secret: <your google client secret>```
* Setup using bundler or bin/setup
  * ```bundle install```
  * ```bin/setup```
