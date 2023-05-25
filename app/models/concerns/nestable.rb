# frozen_string_literal: true

# creates parent child relations in a model
# through a polymorphic table for nestings
# chosen over self-joins
# for reusability and to avoid an SQL anti-pattern
## https://cloud.google.com/bigquery/docs/best-practices-performance-patterns
module Nestable
  extend ActiveSupport::Concern
  # parentable_id is used in forms to set the parent
  # it is whitelisted in the controller
  # and used here to create, update, or destroy the nesting through an after_save callback
  attr_accessor :parentable_id

  included do
    # parent in relationship
    has_many :child_nestings,
             as: :parentable,
             class_name: 'Nesting',
             dependent: :destroy
    has_many :children,
             through: :child_nestings,
             source: :childable,
             source_type: name # returns class name as a string
             
    # child in relationship
    has_one :nesting,
            as: :childable,
            class_name: 'Nesting',
            dependent: :destroy
    has_one :parent,
            through: :nesting,
            source: :parentable,
            source_type: name # returns class name as a string

    accepts_nested_attributes_for :child_nestings,
                                  reject_if: :all_blank,
                                  allow_destroy: true
    accepts_nested_attributes_for :children,
                                  reject_if: :all_blank,
                                  allow_destroy: true
    after_save :handle_parent
  end

  private

  def handle_parent
    return update_nesting if nesting.present?

    return create_nesting if parentable_id.present?
  end

  def create_nesting
    Nesting.create(
      parentable_id:,
      parentable_type: self.class.name,
      childable_type: self.class.name,
      childable_id: id
    )
  end

  def update_nesting
    return nesting.destroy if parentable_id.blank?

    nesting.update(parentable_id:)
  end
end
