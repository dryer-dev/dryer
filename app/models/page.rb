# frozen_string_literal: true

# page model represents a page on a site
# they have a title, a slug, SEO meta information, and related sections
class Page < ApplicationRecord
  # store all strings in lowercase without trailing whitespace
  include StringCleanables
  include Nestable
  # pages are scoped to sites
  acts_as_tenant :site
  # they have many sections
  has_many :sections, dependent: :destroy

  accepts_nested_attributes_for :sections,
                                allow_destroy: true
end
