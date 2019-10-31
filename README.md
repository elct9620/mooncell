Mooncell
===

The **Mooncell** is a Domain-Driven Design online game server framework inspired by [Hanami.rb](https://hanamirb.org/).

An online game usually includes one or more servers but it is hard to share the codebase and support multiple protocols.

Mooncell split game logic to `libs` and allow shared with other projects, and allow the developer to implement behaviors inside `apps` between servers.

## Concept

Currently, Mooncell still under design. Below is the core concept to implement servers with it.

### Structure

This is a Map server implements a move command.

```
├── Gemfile
├── Gemfile.lock
├── apps
│   └── map
│       ├── application.rb
│       ├── commands
│       │   └── move.rb
│       ├── config
│       │   └── routes.rb
│       └── responds
│           └── move.rb
└── config
    └── environment.rb
```

### Environment

It defines the shared environment and servers to loaded.

```ruby
# frozen_string_literal: true

require 'mooncell/protocol/websocket'

require_relative '../apps/map/application'

Mooncell.configure do
  protocol :websocket

  app Map::Application
end
```

### Routes

It defines the command available on the server.

```ruby
# frozen_string_literal: true

command 'move', 'Map::Commands::Move'
```

### Command

Process the command received from the client.

```ruby
# frozen_string_literal: true

module Map
  module Commands
    class Move
      include Mooncell::Command

      # Fake Model
      Player = Struct.new(:id, :x, :y)

      # Expose to respond
      expose :player

      def call(params)
        @player = Player.new(params['id'], params['x'], params['y'])
      end
    end
  end
end
```

### Respond

Return the process result to client.

```ruby
# frozen_string_literal: true

module Map
  module Responds
    class Move
      include Mooncell::Respond

      # Broadcast to all clients
      broadcast true

      def call(*)
        { id: player.id, x: player.x, y: player.y }
      end
    end
  end
end
```

## Installation

> TODO

## Usage

> TODO

## Development

> TODO

## Roadmap

The first target is to design the architecture to support TCP/WebSocket protocol and allow use JSON or customize serializer.

* [ ] Naming
* [ ] Project Generator

> TBD

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/elct9620/mooncell. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Code of Conduct

Everyone interacting in the Mooncell project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/elct9620/mooncell/blob/master/CODE_OF_CONDUCT.md).
