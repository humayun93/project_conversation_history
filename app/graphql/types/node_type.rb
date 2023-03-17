# frozen_string_literal: true

module Types
  # GraphQL type for a node.
  module NodeType
    include Types::BaseInterface
    # Add the `id` field
    include GraphQL::Types::Relay::NodeBehaviors
  end
end
