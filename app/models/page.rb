# frozen_string_literal: true

class Page < ApplicationRecord
  acts_as_tenant :account


  def downcase_fields
    self.name.downcase!
  end
end
