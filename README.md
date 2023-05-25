# DRYER CMS

I wanted a modern, lightweight, and flexible Rails CMS that was multisite compatible and developer friendly. 

The use case being an individual or organization building client sites that need flexibility and a backend for updating content. Clients could include small to medium sized enterprises that don't operate in the tech sector (the kind of organization that might consider Shopify Plus or other 4 figure annually SAAS products).

The benefit of this over an existing CMS:

* Develop or add features specific to a client or cluster of client's needs. *i.e. a booking system for a cluster of small hotel websites*
* start with a blank slate for each site's front end - no bloated libraries or overriding inherited styles/scripts. *But, the ability to easily add librabries to any sites if needed.*

This setup could enable the developer to deliver an efficient, optimized site with no limitation in potential. Should scalabilty become a concern, I foresee it being addressable on a specific site/client basis and the solution would be to migrate them out of the CMS and into a new build of their own.

## Framework

This app is built using Rails 7 in Ruby v.3.2.1. 

In addtion to the gems bundled with Rails 7, its dependencies include:

* **jsbundling-rails** bundle and transpile JavaScript [https://github.com/rails/jsbundling-rails]
* **cssbundling-rails** bundle and process CSS [https://github.com/rails/cssbundling-rails]
* **devise** flexible authentication solution for Rails with Warden
* **acts_as_tenant** integrates multi-tenancy into a Rails application in a convenient and out-of-your way manner


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
