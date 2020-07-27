# DeadStock

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
DeadStock is a convenient way to see how the sneaker market is doing, track its history, and help investors/buyers alike plan their next sale/purchase. After a user creates their profile among various other features, they can customize their dashboard to display data for specific sneaker styles and brands of interest. 

### App Evaluation
- **Category:** Business/Lifestyle
- **Mobile:** The mobile interface of the app allows users to conveniently track sneaker trends and data at their finger tips.
- **Story:** Allows users to keep track of trends and recent drops/sneaker news with a simple, straight-forward interface. Think - Apple's stocks app for sneakers.
- **Market:** Anyone who is a sneakerhead, interested in the trends/data behind the sneaker market, or wants to buy coveted colorways could enjoy this app.
- **Habit:** Users could open this app regularly to keep tabs on a specific shoe's price increases/decreases, especially if they're looking to make a purchase or are deciding whether or not they should hold/sell stock. Sneaker prices can fluctuate daily depending on major drops, pop culture, or other social phenomena.
- **Scope:** I believe the scope of this app is quite doable, with an ample amount of "required" stories that still make the app appealing for its purpose. The main challenge will be to find a good way to integrate all the trends/data I wish to display about each sneaker.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* User can log in
* User can create a new profile
* User can view their profile and add a profile picture, bio, and various other interests
* User can search for and add sneakers to dashboard
* User can view the details of a sneaker by tapping on its profile
* User can view top stories from popular sneaker news websites.

**Optional Nice-to-have Stories**

* User can view news from sources like Complex and SneakerNews 
* User can keep track of their "cops" which will be displayed publically on their profile.
* User can view/set notifications for upcoming drops and be redirected to purchasing websites/raffles where the sneaker can be acquired.

### 2. Screen Archetypes

* Login Screen
   * User can login
* Registration screen
   * User can create a new profile
* Profile Screen
    * User can view their profile and add a profile picture, bio, and various other interests
* Dashboard Screen
   * User can search for and add sneakers to dashboard
* Details Screen
    * User can view the details of a sneaker by tapping on its profile
* News Screen
    * User can add and view top sneaker news articles from popular sources

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Profile
* Dashboard
* News

**Flow Navigation** (Screen to Screen)

* Login Screen
   * Registration Screen
   * Dashboard
* Registration Screen
   * Login Screen
   * Dashboard
* Profile Screen
    * None
* Dashboard
    * Sneaker Details Screen
* Details Screen
    * None
* News Screen
    * News Details Screen

## Wireframes
<img src="https://github.com/pranathip/DeadStock/blob/master/Digital_Wireframe.png?raw=true" width=600>
<img src="https://github.com/pranathip/DeadStock/blob/master/Mockup.png?raw=true" width=600>

### [BONUS] Interactive Prototype

## Schema 
### Models
**Sneaker**
| Property | Type | Description |
| -------- | ---- | ----------- |
| dashboard_author | PFUser pointer | if it's in the database, logs the user who put it on their dashboard |
| wishlist_author | PFUser pointer | if it's in the database, logs the user who put it on their wishlist |
| url | NSURL | URL leading to the sneaker's StockX profile |
| brand | String | brand of sneaker (nike, adidas, air jordan, etc.) |
| type | String | type of shoe (yeezy boost, jordan 1, etc.) |
| name | String | sneaker type + colorway, most common name (Jordan 1 Retro High Fearless UNC Chicago) |
| colorway | String | sneaker colorway (White/University Blue-Varsity Red-Black) |
| volatility | NSNumber | sneaker price change volatility (a percentage) |
| total sales | NSNumber | number of sales made on the sneaker |
| average resell price | NSNumber | they KEY value to take away, the price the sneaker currently sells for on the market |

### Networking
**List of network requests by screen**
* Dashboard Screen
  * (Read/GET) Query all sneakers that user has added to dashboard
  * (Create/POST) Create a new addition to the collectionView dashboard based on user input
  * (Delete) Delete an existing sneaker from the dashboard
  * (Read/GET) Query all sneakers using a search based on key words that user inputs into the search bar
* Profile Screen
  * (Read/GET) Query logged in user object
  * (Update/PUT) Update user profile picture, first/last name, username, email, and/or bio
* News Screen
  * (Read/GET) Query all recent news articles from the news API
* Sneakers Details Screen
  * (Read/GET) Query all information/extended details about the sneaker in question
* News Details Screen
  * (Read/GET) Query all information/extended details about the article in question

**News API (will be used primarily for the wishlist screen, while the scraped StockX data will be used to update the dashboard**
**Base URL - http://newsapi.org/v2**
| HTTP Verb | Endpoint | Description |
| --- | --- | --- |
| `GET` | /everything?q={TOPIC}&from=2020-06-23&sortBy=publishedAt | get all articles about TOPIC from the last month, sorted by recent first |
| `GET` | /top-headlines?country=us&category={TOPIC} | top {TOPIC} headlines in the US right now |
| `GET` | /top-headlines?sources={SOURCE} | top headlines from {SOURCE} |
| `GET` | /everything?domains={DOMAIN} | all articles published at {DOMAIN} |
