# frozen_string_literal: true

class Section < ApplicationRecord
  # section can have many children sections
  # this is to facilitate presentation logic
  ## i.e. multi-column, grid, etc.
  include Nestable
  # sections are scoped to pages
  belongs_to :page,
             optional: true
end
