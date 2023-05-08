# frozen_string_literal: true

class Page < ApplicationRecord
  acts_as_tenant :site
  has_many :sections, dependent: :destroy

  accepts_nested_attributes_for :sections,
                                allow_destroy: true


  def downcase_fields
    self.name.downcase!
  end
end
