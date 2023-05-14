# frozen_string_literal: true

# model used to define parent child relationships
# used in other models via the Nestable concern
class Nesting < ApplicationRecord
  belongs_to :parentable,
             inverse_of: :child_nestings,
             polymorphic: true

  belongs_to :childable,
             inverse_of: :nesting,
             polymorphic: true
end
