# DRYER CMS

I wanted a modern, lightweight, and flexible Rails CMS that was multidomain compatible and developer friendly. 

I built one as the other open source Rails CMS' were already far along a path (that started a long time ago - things have changed) or developing into a paid product. The most suitable one for me, Comfortable Mexican Sofa, hasn't been updated in years.


## Use case 

An individual or organization building client sites that need flexibility and a backend for updating content. Clients could include small to medium sized enterprises that don't operate in the tech sector (the kind of organization that might consider Shopify Plus or other 4 figure annually SAAS products).

The benefit of this over an existing CMS (non Rails):

* Develop or add features specific to a client or cluster of client's needs. *i.e. a booking system for a cluster of small hotel websites*
* Start with a blank slate for each site's front end - no bloated libraries or overriding inherited styles/scripts. *But, the ability to easily add librabries to any sites if needed.*

This setup could enable the developer to deliver an efficient, optimized site with no limitation in potential. Should scalabilty become a concern, I foresee it being addressable on a specific site/client basis and the solution would be to migrate them out of the CMS and into a new build of their own.

## Framework

This app is built using Rails 7 with a MariaDB database. It was written in Ruby v.3.2.1

## Dependencies

In addtion to the gems bundled with Rails 7, its dependencies include:

* **jsbundling-rails** bundle and transpile JavaScript [https://github.com/rails/jsbundling-rails]
* **cssbundling-rails** bundle and process CSS [https://github.com/rails/cssbundling-rails]
* **devise** flexible authentication solution for Rails with Warden
* **acts_as_tenant** integrates multi-tenancy into a Rails application in a convenient and out-of-your way manner

Yarn dependencies:
* concurrently

## Database

The app relies on the following architecture:

![alt text](https://github.com/[dryer-dev]/[dryer]/dryer-db-schematic.png?raw=true)


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
