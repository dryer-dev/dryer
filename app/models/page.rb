# frozen_string_literal: true

# Page model represents a page on a site
# They have a title, a slug, SEO meta information, and related sections
class Page < ApplicationRecord
  # Store all strings in lowercase without trailing whitespace
  include StringCleanables
  # Pages are scoped to sites
  acts_as_tenant :site
  # They have many sections
  has_many :sections, dependent: :destroy

  accepts_nested_attributes_for :sections,
                                allow_destroy: true
end
