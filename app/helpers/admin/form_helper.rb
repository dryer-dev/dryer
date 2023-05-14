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

      string_attr = @object.attribute_names.find { |attr| object.type_for_attribute(attr).type == :string }

      fields_for :nesting_attributes do |n|
        n.hidden_field :parentable_type, value: @object_name
        n.collection_select :parentable_id,
                            @object.class.all,
                            :id,
                            string_attr.to_sym,
                            prompt: 'Select a parent',
                            selected: @object.nesting.parentable_id
      end
    end
  end
end
