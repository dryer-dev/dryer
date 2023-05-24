module Admin::FormHelper
  class ActionView::Helpers::FormBuilder
    # http://stackoverflow.com/a/2625727/1935918
    include ActionView::Helpers::TagHelper
    include ActionView::Helpers::FormTagHelper
    include ActionView::Helpers::FormOptionsHelper
    include ActionView::Helpers::CaptureHelper
    include ActionView::Helpers::AssetTagHelper

    # instance variable inherited from Rails
    ## @object - the model object specified by the form
    ## @object_name - the class name of the object
    ## @template - I think its an instance of the ActionView, you can possibly bypass all the includes I added by calling methods on the template. Haven't tried that yet.
    ## @options - options passed to the FormBuilder when its created by the form_for call

    def nesting_parent_select
      # find the first string attribute
      # to use as the display value
      string_attr = @object.attribute_names.find { |attr| object.type_for_attribute(attr).type == :string }
      # find the parentable_id if it exists
      parentable_id = @object&.nesting&.parentable_id
      # include a blank option if there is a parentable_id
      # to allow for un-nesting
      blank = parentable_id.present?
      # find all the options for the select
      # excluding the current object
      options = @object.class.where.not(id: @object.id)
      # create the select using `collection_select`
      collection_select :parentable_id,
                        options,
                        :id,
                        string_attr.to_sym,
                        include_blank: blank,
                        prompt: 'Select a parent',
                        selected: parentable_id
    end
  end
end
