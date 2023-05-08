# frozen_string_literal: true

# include this concern in your model to strip and downcase string attributes before validation
module StringCleaner
  extend ActiveSupport::Concern

  included do
    before_validation :clean_strings
  end

  class_methods do
    attr_reader :stringclean_opts

    private

    def string_cleanables(opts = {})
      @stringclean_opts = opts
    end
  end

  def clean_string(string)
    string.strip! || string
    string.downcase! || string
  end

  def clean_strings
    string_cleanables.each { |attr| clean_string(send(attr)) }
  end

  def string_attributes
    attribute_names.select { |attr| type_for_attribute(attr).type == :string }
  end

  def string_cleanables
    cleanables = string_attributes

    if self.class.stringclean_opts.present?
      stringclean_opts = self.class.stringclean_opts
      cleanables.select { |attr| stringclean_opts[:only].include?(attr) } if stringclean_opts[:only]
      cleanables.reject { |attr| stringclean_opts[:except].include?(attr) } if stringclean_opts[:except]
    end
    cleanables
  end
end
