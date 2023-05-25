# frozen_string_literal: true

# model used to define parent child relationships
# used in other models via the Nestable concern
class Nesting < ApplicationRecord
  belongs_to :parentable,
             polymorphic: true

  belongs_to :childable,
             polymorphic: true

  validates_associated :handle_children

  def handle_children
    puts '__________________________________________________________________NESTIN!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
    puts parentable.inspect
    puts childable.inspect
    puts attributes.inspect
  end
end
