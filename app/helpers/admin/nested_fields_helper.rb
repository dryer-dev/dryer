# frozen_string_literal: true

# admin namespace
module Admin
  # module for nested fields helpers
  module NestedFieldsHelper
    # Source: https://stevepolito.design/blog/create-a-nested-form-in-rails-from-scratch/
    # This method creates a link with `data-id` `data-fields` attributes.
    # These attributes are used to create new instances of the nested fields through Javascript.
    def link_to_add_nested_fields(name, form, association, options = {})
      # Takes an object and creates a new instance of its associated model
      new_object = form.object.send(association).klass.new
      # Saves the unique ID of the object into a variable.
      # This is needed to ensure the key of the associated array is unique.
      # This makes parsing the content in the `data-fields` attribute easier through Javascript.
      # We could use another method to achive this.
      id = new_object.object_id
      # get the rendered fields from the `nested_fields_for` method.
      fields = nested_fields_for(form, association, new_object, id)
      # This renders a simple link, but passes information into `data` attributes.
      # This info can be named anything we want, but in this case we chose `data-id:` and `data-fields:`.
      # The `id:` is from `new_object.object_id`.
      # The `fields:` are rendered from the `fields` blocks.
      # We use `gsub("\n", "")` to remove anywhite space from the rendered partial.
      # The `id:` value needs to match the value used in `child_index: id`.
      link_to(
        name,
        '#',
        class: "add_fields #{options[:class]}",
        data: {
          id:,
          fields: fields.gsub('\n', '')
        }
      )
    end

    private

    # https://api.rubyonrails.org/ fields_for(record_name, record_object = nil, fields_options = {}, &block)
    # record_name = :addresses
    # record_object = new_object
    # fields_options = { child_index: id }
    # child_index` is used to ensure the key of the associated array is unique,
    # and that it matched the value in the `data-id` attribute.
    # `person[addresses_attributes][child_index_value][_destroy]`
    def nested_fields_for(form, association, new_object, id)
      # the `views_directory` variable is used to render the correct partial.
      views_directory = fields_views_directory(association, form)
      form.fields_for(association, new_object, child_index: id) do |builder|
        # The render function will then look for `views/people/_address_fields.html.erb`
        # The render function also needs to be passed the value of 'builder',
        # because `views/people/_address_fields.html.erb` needs this to render the form tags.
        render("admin/#{views_directory}/fields", f: builder)
      end
    end

    def fields_views_directory(association, form)
      # we can't always use the association name because it is not always the same as the model name.
      # i.e. Nestables creates nested_attributes for 'children'.
      return association.to_s unless association == :children

      # if the association is `children` then we need to use the parent model name.
      form.object.class.name.underscore.pluralize
    end
  end
end
