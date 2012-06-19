# Smithy

Smith is an Inversion of Control (IoC) container for Ruby. It's based on an
example given in Jim Weirich's
[Dependency Injection: Vitally Important or Totally Irrelevant][ditalk]
talk at O'REILLY OSCON 2005. He called the example matzdi\_constructor so,
presumably, Matz was involved as well.

[ditalk]:http://onestepback.org/articles/depinj/

## Installation

Add this line to your application's Gemfile:

    gem 'smithy'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install smithy

## Usage

    require "rubygems/setup"

    require "logger"
    require "smithy"

    class LoggingErrorReporter
      def initialize(logger)
        @logger = logger
      end

      def report(error)
        @logger.error("badness: #{error}")
      end
    end

    container = Smithy::Container.new
    container.register(:logger, Logger.new($stdout)) # you can register literal objects
    container.register(:error_reporter, LoggingErrorReporter, :logger) # you can also register classes

    container.instance(:error_reporter).report("no more coffee")

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

