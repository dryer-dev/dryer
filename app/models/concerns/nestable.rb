# frozen_string_literal: true

# creates parent child relations in a model
# through a polymorphic table for nestings
# chosen over self-joins
# for reusability and to avoid an SQL anti-pattern
## https://cloud.google.com/bigquery/docs/best-practices-performance-patterns
module Nestable
  extend ActiveSupport::Concern

  included do
    # parent in relationship
    has_many :child_nestings,
             as: :parentable,
             class_name: 'Nesting',
             dependent: :destroy
    has_many :children,
             through: :child_nestings,
             source: :childable,
             source_type: name
    # child in relationship
    has_one :nesting,
            as: :childable,
            class_name: 'Nesting',
            dependent: :destroy
    has_one :parent,
            through: :nesting,
            source: :parentable,
            source_type: name

    accepts_nested_attributes_for :nesting,
                                  allow_destroy: true
  end
end
