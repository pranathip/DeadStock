# DeadStock

### Interactive Prototype
https://user-images.githubusercontent.com/23707420/202054202-22e86d8b-367e-446b-85ff-24fa5929e49c.mov

## Wireframes
<img src="https://github.com/pranathip/DeadStock/blob/master/Digital_Wireframe.png?raw=true" width=600>
<img src="https://github.com/pranathip/DeadStock/blob/master/Mockup.png?raw=true" width=600>


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
