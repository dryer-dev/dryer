# Dryer CMS

I wanted a modern, lightweight, and flexible Rails CMS that was multidomain compatible and developer friendly. 

I built one as the other open source Rails CMS' were already far along a path (that started a long time ago - things have changed) or developing into a paid product. The most suitable one for me, Comfortable Mexican Sofa, hasn't been updated in years.

It's called Dryer because I own the domain dryer.dev


## Use case 

An individual or organization building client sites that need flexibility and a backend for updating content. Clients could include small to medium sized enterprises that don't operate in the tech sector (the kind of organization that might consider Shopify Plus or other 4 figure annually SAAS products).

The benefit of this over an existing CMS (non Rails):

* Develop or add features specific to a client or cluster of client's needs. *i.e. a booking system for a cluster of small hotel websites*
* Start with a blank slate for each site's front end - no bloated libraries or overriding inherited styles/scripts. *But, the ability to easily add librabries to any sites if needed.*

This setup could enable the developer to deliver an efficient, optimized site with no limitation in potential. Should scalabilty become a concern, I foresee it being addressable on a specific site/client basis and the solution would be to migrate them out of the CMS and into a new build of their own.

This CMS uses a block editor - EditorJS [https://editorjs.io/] - for a modern content editing experience with a clean output.

## Framework

This app is built using Rails 7 with a MariaDB database. It was written in Ruby v.3.2.1

## Dependencies

In addtion to the gems bundled with Rails 7, its dependencies include:

* **jsbundling-rails:** bundle and transpile JavaScript [https://github.com/rails/jsbundling-rails]
* **cssbundling-rails:** bundle and process CSS [https://github.com/rails/cssbundling-rails]
* **devise:** flexible authentication solution for Rails with Warden [https://github.com/heartcombo/devise]
* **acts_as_tenant:** integrates multi-tenancy into a Rails application in a convenient and out-of-your way manner [https://github.com/ErwinM/acts_as_tenant]

Node dependencies:
* **concurrently**
* **@editorjs** isolated to an admin namespace/workspace.

## Database

The current architecture in place:

![db schematic](https://github.com/dryer-dev/dryer/blob/main/dryer-db-schematic.png)

Tables:

* **Users:** A standard Devise Users table.
* **Sites:** Sites have specified domain and subdomain. The relationship between Users and Sites hasn't been addressed yet. Pages are tenants of Sites. 
* **Nestings:** Handles heirarchies via a polymorphic association. I went this way over self-joins for reusability and to avoid an SQL anti-pattern. [https://cloud.google.com/bigquery/docs/best-practices-performance-patterns]
* **Pages:** Wepsite pages. Only has a Title attibute at the moment. Pages have many *sub-*Pages via Nestings. This facilates Page heirarchies like Blog > Posts, Services > Service... A separate Categories table will address the category names of Pages. As Pages are tenants of Sites, anyhing that relates to Pages is scoped to its Site. Pages have many Sections. *TODO: maybe include SEO related fields like description*
* **Sections:** Sections only have a data attribute. The data attribute stores JSON data from the block editor: EditorJS. Sections can have many *sub-*Sections via Nestings. This facilates a very flexible layout strucute that can accommodate mulit-columns, grids... This nesting is only one level deep but it may be worth looking into the benefit of deeper nesting. *TODO: add a css_classes attribute*


Tables to add:
* **Categories:** Categorize Pages
* **Files:** Attach images, files... to Sections

## Configuration

### Front end

Configured using Yarn workspaces reading a packages directory with subdirectories for each domain. When the app precompiles assets it relies on concurrently to execute the build scripts for each domain. 

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

Within each domains directory is the Yarn configuration for that domain including package.json and, in this instance, a weback configuration file.

This setup enables us to:

* 


## Editing content

![db schematic](https://github.com/dryer-dev/dryer/blob/main/dryer-editing-sections.png)









modern Rails (7) I created this CMS to address the following:

* 

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## Layouts

Html markup for 
