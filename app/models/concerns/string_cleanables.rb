# frozen_string_literal: true

# clean a string before validation
# you can specify which attributes to clean by passing a hash to the string_cleanables method
module StringCleanables
  extend ActiveSupport::Concern

  included do
    before_validation :clean_strings
  end

  class_methods do
    attr_reader :stringclean_opts

    private

    # specify which attributes to clean
    # using a hash with :only or :except keys
    # this is optional
    def string_cleanables(opts = {})
      @stringclean_opts = opts
    end
  end

  private

  def cleaner(string)
    # what we, currently, consider cleaning
    # strip and downcase string
    string.strip! || string
    string.downcase! || string
  end

  def clean_strings
    # loop through string attributes and clean them
    string_cleanables.each { |attr| cleaner(send(attr)) }
  end

  def string_attributes
    # get model's string attributes via type_for_attribute
    # and return them as an array of symbols
    attribute_names.select { |attr| type_for_attribute(attr).type == :string }
                   .map(&:to_sym)
  end

  def string_cleanables
    # get all string attributes for cleaning
    cleanables = string_attributes
    stringclean_opts = self.class.stringclean_opts
    # if stringclean_opts are present, filter cleanables
    if stringclean_opts.present?
      cleanables.select! { |attr| stringclean_opts[:only].include?(attr) } if stringclean_opts[:only]
      cleanables.reject! { |attr| stringclean_opts[:except].include?(attr) } if stringclean_opts[:except]
    end
    cleanables
  end
end
