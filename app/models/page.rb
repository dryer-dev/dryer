# frozen_string_literal: true

# page model represents a page on a site
# they have a title, a slug, SEO meta information, and related sections
class Page < ApplicationRecord
  # store all strings in lowercase without trailing whitespace
  include StringCleanables
  # pages can have many children pages
  # this is to facilitate category heirarchies
  ## i.e. blog posts, services, etc.
  include Nestable
  # pages are scoped to sites
  acts_as_tenant :site
  # they have many sections
  has_many :sections, dependent: :destroy
  accepts_nested_attributes_for :sections,
                                reject_if: :all_blank,
                                allow_destroy: true
  # TODO: do we want to assume that sections without editor_data need to be destroyed?
  ## maybe not, we might want to use an empty section vs a pseudo element
end
