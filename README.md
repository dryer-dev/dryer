# Dryer CMS

I wanted a modern, lightweight, and flexible Rails CMS that was multidomain compatible and developer friendly. 

I built one as the other open source Rails CMS' were already far along a path (that started a long time ago - things have changed) or developing into a paid product. The most suitable one for me, Comfortable Mexican Sofa, hasn't been updated in years.

## Use case 

An individual or organization building client sites that need flexibility and a backend for updating content. Clients could include small to medium sized enterprises that don't operate in the tech sector (the kind of organization that might consider Shopify Plus or other 4 figure annually SAAS products).

The benefit of this over an existing CMS (not exclusive to Rails):

* Develop or add features specific to a client or cluster of client's needs. *i.e. a booking system for a cluster of small hotel websites*
* Start with a blank slate for each site's front end - no bloated libraries or overriding inherited styles/scripts. *But, the ability to easily add librabries to any sites if needed.*

This setup could enable the developer to deliver an efficient, optimized site with no limitation in potential. Should scalabilty become a concern, I foresee it being addressable on a specific site/client basis and the solution would be to migrate them out of the CMS and into a new build of their own.

This CMS uses a block editor - EditorJS [https://editorjs.io/] - for a modern content editing experience with a clean output.

## Framework

This app is built using Rails 7 with a MariaDB database. It was written in Ruby v.3.2.1

## Dependencies

In addtion to the gems bundled with Rails 7, its dependencies include:

* **jsbundling-rails:** Bundle and transpile JavaScript [https://github.com/rails/jsbundling-rails]
* **cssbundling-rails:** Bundle and process CSS [https://github.com/rails/cssbundling-rails]
* **devise:** Flexible authentication solution for Rails with Warden [https://github.com/heartcombo/devise]
* **acts_as_tenant:** Integrates multi-tenancy into a Rails application in a convenient and out-of-your way manner [https://github.com/ErwinM/acts_as_tenant]

Node dependencies:
* **concurrently:** Run multiple commands concurrently [https://github.com/open-cli-tools/concurrently].
* **@editorjs:** Isolated to an admin namespace/workspace [https://editorjs.io/].

## Database

The current architecture in place:

![db schematic](https://github.com/dryer-dev/dryer/blob/main/dryer-db-schematic.png)

Tables:

* **Users:** A standard Devise Users table.
* **Sites:** Sites have specified domain and subdomain. The relationship between Users and Sites hasn't been addressed yet. Pages are tenants of Sites. 
* **Nestings:** Handles heirarchies via a polymorphic association. I went this way over self-joins for reusability and to avoid an SQL anti-pattern. [https://cloud.google.com/bigquery/docs/best-practices-performance-patterns]
* **Pages:** Wepsite pages. Only has a Title attibute at the moment. Pages have many sub-Pages via Nestings. This facilates Page heirarchies like Blog > Posts, Services > Service... A separate Categories table will address the category names of Pages. As Pages are tenants of Sites, anything that relates to Pages is scoped to its Site. Pages have many Sections. *TODO: maybe include SEO related fields like description*
* **Sections:** Sections only have a data attribute. The data attribute stores JSON data from the block editor: EditorJS. Sections can have many sub-Sections via Nestings. This facilates a very flexible layout strucure that can accommodate multi-columns, grids... This nesting is only one level deep but it may be worth looking into the benefit of deeper nesting. *TODO: add attributes for css_classes and rendering layout*


Tables to add:
* **Categories:** Categorize Pages
* **Files:** Attach images, files... to Sections
* **Menus:** Site menus

## Configuration

### Back end

#### Namespaces

An Admin namespace is used to update site content. acts_as_tenantable uses a method to set the current tenant in the Application Controller so the entire Admin namespace is automatically scoped to the domain it resides within.

#### Models

Fairly standard Rails stuff at the moment. Currently missing validations....

Concerns:

* **Nestables:** Defines Active Record assiociations for models with hierarchies implemented via Nestings. Handles defining parents (used by Pages) via the nesting_parent_select method and parentable_id attribute. 
* **StringCleanables:** Contains methods for tidying strings before validation. I wrote this earlier and left it - there are not enough notes and it probably smells. *TODO: document and refactor*

#### Controllers

Standard Rails stuff plus an Admin Controller for the Admin namespace.

#### Views

Using Haml.

Presenting a site depends on the page, sections, and subdomain directories:

* **Pages:** I anticipate these will be universal
* **Sections:** Files included in the views > sections directory are accessible by all domains *- standard section views*. Sections will render structured content based on the JSON data EditorJS saves. Hopefully, this will enable a programatic approach to clean HTML markup.
* **Subdomains:** Views exclusively for the given site (current_tenant). This includes header, footer, and sections. Sites can have their own sections or override a *standard section view* by creating a file with the same name in their respective sections directory.


There are two main layout files:

* **application:** Relies on current_tenant to: retrieve CSS and JS builds and render the header and footer.
* **admin:** Uses the admin CSS and JS builds with the current_tenant header and footer - *a site's admin area will look bespoke to it*.


There are some helpers for the Admin namespace:

* **nesting_parent_select:** A custom form helper that creates a collection_select based on the form object.
* **link_to_add_nested_fields:** this outputs a link tag to create nested attributes via JS. This implementation is based on a method outlined here: [https://stevepolito.design/blog/create-a-nested-form-in-rails-from-scratch/]. Data attribitues are used to pass content to the front end.
* **SitesHelper:** The methods in here will faciliate selecting a layout for a section based on files in views directory. 

### Front end

#### Assets 

Configured using Yarn workspaces reading a packages directory with subdirectories for each domain. When the app precompiles assets it relies on concurrently [https://github.com/open-cli-tools/concurrently] to execute the build scripts for each domain. 

For example, package.json might look like:

```
{
  "private": "true",
  "workspaces": [
    "packages/*"
  ],
  "dependencies": {
    "concurrently": "^8.0.1"
  },
"scripts": {
    "admin": "yarn workspace admin run build --watch",
    "admin:css": "yarn workspace admin run build:css --watch",
    "website_1": "yarn workspace website_1 run build --watch",
    "website_1:css": "yarn workspace website_1 run build:css --watch",
    "website_2": "yarn workspace website_2 run build --watch",
    "website_2:css": "yarn workspace website_2 run build:css --watch",
    "build": "concurrently --kill-others-on-fail \"yarn admin\" \"yarn website_1\"  \"yarn website_2\"",
    "build:css": "concurrently --kill-others-on-fail \"yarn admin:css\" \"yarn website_1:css\"  \"yarn website_2:css\""
  }
}
```

Within each domains directory is the Yarn configuration for that domain including package.json and, in this instance, a webpack configuration file. *TODO: consider dropping Webpack in favour of a faster bundler - esbuild...* 

Each site has it's own application.js file within the javascript > subdomain directory.

#### JS

As a site has its own build, its dependencies are addressed by the compiler. We'll have the ability to share scripts between sites by importing from the parent directory. This could get complicated with each site responsible for its own dependencies so it may be best to only share vanilla JS without any dependencies from the parent directory.

Admin uses the following classes (currently residing in javascript > lib):

* **addFields:** this is taken from Steve Polito's implementation [https://stevepolito.design/blog/create-a-nested-form-in-rails-from-scratch/] but refactored for my NestedFields and EditorInstances.
* **EditorInstances:** I wrote this to link DOM references with an EditorJS class. I figured this encapsulation was a good idea given the amount of EditorJS instances I'm going to have on a page.
* **NestedFields:** I believe this take Polito's implementation up a notch. It's marrying and encapsulating the necessary DOM elements with the JS needed to make nested fields work.

The end result is a modern looking interface for updating content. Looks like this:

![db schematic](https://github.com/dryer-dev/dryer/blob/main/dryer-editing-sections.png)

With the inclusion of EditorJS, I hope that the each sites HTML markup is relatively clean. Personally, I find ActionText and Trix looks dated and results in some ugly markup.

#### Styles

I'm using SCSS and one of it's newer features: placeholders [https://sass-lang.com/documentation/style-rules/placeholder-selectors]. Designing a directory and build process that uses placeholders, enables me to reuse styles between elements and, in this case, sites, without having to resort to classes with classes and classes. It also enabes me to write a mini library to share between sites to optimize workflow. Additionally, this means all the dependent styles are dealt with in the compiler so a site's CSS file only contains CSS it's using. *It should be hard to go beyond a 10kb CSS file for a site* 

The stylesheets directory contains two folders (core and abstracts) to facilitate the sharing of styles between sites. You can also create an abstracts directory within a subdomain directory to share properties with the a site.

## Conclusion

There's much more to do and, importantly, I still need to upload this on a server and ensure the assets are delivered correctly.

