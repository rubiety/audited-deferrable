# audited-deferrable

Extension to the audited gem to deferred writing of audits via Resque, but with modular architecture to support adding other providers such as sidekiq and delayed job (pull requests, please!)

NOTE: This currently only works with Resque v1, not Resque v2 which is a different API. I'd gladly accept pull requests supporting both.

## Usage:

In Gemfile:

    gem "audited-activerecord", "~> 3.0.0"
    gem "resque", "~> 1.24"
    gem "audited-deferrable", "~> 0.1.0"

In an initializer (config/initializers/audited.rb):

    Audited.defer_with = :resque

After this, all of your audits will be written to the resque queue, and to completely them you'll need to run a resque worker:

    $ QUEUE=audited rake environment resque:work

## Configuration

By default, the resque queue is set to :audited, but can be changed:

    Audited::Deferrable::Resque.queue = :custom_queue

## Custom Handlers

If you want to write a handler for sidekiq or delayed job, please fork the project and implement as a subclass of Audited::Deferrable::Base, then send a pull request so all can use.

A completely custom handler can be implemented outside of the gem by subclassing Audited::Deferrable::Base, then setting that class to defer_with directly:

  class Audited::Deferrable::CustomProvider < Audited::Deferrable::Base
    ...
  end

  Audited.defer_with = Audited::Deferrable::CustomProvider


