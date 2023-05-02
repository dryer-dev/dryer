# frozen_string_literal: true

class Page < ApplicationRecord
  acts_as_tenant :site
  has_many :sections, dependent: :destroy


  def downcase_fields
    self.name.downcase!
  end
end
