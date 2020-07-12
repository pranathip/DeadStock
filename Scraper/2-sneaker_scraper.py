

import codecs
import requests
import json
import time
import os
import random

from bs4 import BeautifulSoup
from requests.exceptions import ConnectionError, ChunkedEncodingError

#BRANDS = ['nike','jordan','adidas','other']
BRANDS = ['retro-jordans']

#load overall.json as global DATA
with open('part2.json') as file:
    DATA = json.load(file)
    newData = dict()

def tsplit(string, delimiters):
    """Behaves str.split but supports multiple delimiters."""
    delimiters = tuple(delimiters)
    stack = [string,]
    for delimiter in delimiters:
        for i, substring in enumerate(stack):
            substack = substring.split(delimiter)
            stack.pop(i)
            for j, _substring in enumerate(substack):
                stack.insert(i+j, _substring)     
    return stack

def brand_dict(brand):
    return_dict = {}
    _dict = DATA[brand]
    for key,value in _dict.items():
        type     = key
        sneakers = _dict[key]
        for key,value in sneakers.items():
            return_dict[key] = {
                'url': _dict[type][key]['href'],
                'img': _dict[type][key]['src'],
                'type': type,
                'brand': brand
            }
    return return_dict

def sneaker_scraper():
    #iterate through each brand
    for brand in BRANDS:
        _dict         = brand_dict(brand)
        urls, err     = [], ['{}'.format(brand)]
        sneaker_dict  = {}
        attribute_counter = 0
        while len(_dict) > 0:
            for key,value in list(_dict.items()):
                #track error count and shoes remaining
                print ('\nError Count [{}]'.format(attribute_counter))
                print ('Remaining: '+str(len(_dict))+'\n')
                try: 
                    #extract url from dictionary
                    url = _dict[key]['url']
                    _type = _dict[key]['type'].replace('-',' ')
                    #create product container
                    headers = {"User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:66.0) Gecko/20100101 Firefox/66.0", "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8", "Accept-Language": "en-US,en;q=0.5", "Accept-Encoding": "gzip, deflate", "DNT": "1", "Connection": "close", "Upgrade-Insecure-Requests": "1"}
                    shoe_html      = requests.get(url, headers=headers).content
                    shoe_soup      = BeautifulSoup(shoe_html, 'html.parser')
                    shoe_container = shoe_soup.find("div", {"class": "product-view"})
                    header_stat    = shoe_container.find_all('div', {'class': 'header-stat'})
                    ticker         = header_stat[1].get_text().strip().split(' ')[1]
                    #get info about the last sale
                    last_sale_stat = shoe_container.find_all('div', {'class' : 'mobile-last-sale'})
                    last_sale = last_sale_stat[0].get_text().strip('Last Sale')
                    if '+' in last_sale:
                        last_sale_price = last_sale.split("+")[0]
                        last_sale_price_increase = last_sale.split("+")[1].split("(")[0]
                        last_sale_price_percent_increase = last_sale.split("+")[1].split("(")[1].strip(")")
                        print(last_sale_price_increase)
                        print(last_sale_price_percent_increase)
                        price_increase = True
                    elif '-' in last_sale:
                        last_sale_price = last_sale.split("-")[0]
                        last_sale_price_increase = last_sale.split("-")[1].split("(")[0]
                        last_sale_price_percent_increase = last_sale.split("-")[1].split("(")[1].strip(")")
                        price_increase = False
                    #check type of product info
                    product_info = shoe_container.find_all('div', {'class': 'detail'})
                    colorway     = '--'
                    retail_price = '--'
                    release_date = '--'
                    for info in product_info:
                        #check for style & pass
                        if info.get_text().split(' ')[0] == 'Style':
                            pass
                        elif info.get_text().split(' ')[0] == 'Colorway':
                            colorway = info.get_text().replace('Colorway ','').strip()
                        elif info.get_text().split(' ')[0] == 'Retail':
                            retail_price = info.get_text().split(' ')[2].strip()
                        elif info.get_text().split(' ')[0] == 'Release':
                            release_date = info.get_text().split(' ')[2].strip()
                    #extract sales information
                    twelve_month_historical = shoe_container.find('div', {'class': 'gauges'}).get_text().strip()
                    twelve_data    = tsplit(twelve_month_historical,('# of Sales','Price Premium(Over Original Retail Price)','Average Sale Price'))
                    total_sales    = twelve_data[1]
                    price_premium  = twelve_data[2]
                    avg_sale_price = twelve_data[3]
                    """MARKET INFO"""
                    market_summary = shoe_container.find('div', {'class': 'product-market-summary'}).get_text().strip()
                    market_data    = tsplit(market_summary,('52 Week High ',' | Low ','Trade Range (12 Mos.)','Volatility'))
                    high           = market_data[1]
                    low            = market_data[2]
                    trade_range    = market_data[3]
                    volatility     = market_data[4]
                    #account for unique identifiers
                    if _type == 'footwear':
                        _type = 'other'
                    if brand == 'jordan':
                        check = _dict[key]['type'].split('-')[-1]
                        if check.isdigit():
                            _type = check
                    #return scraped sneaker information as dictionary object
                    data = { 
                            "url" : url,
                            "brand": brand,
                            "type": _type,
                            "image" : _dict[key]['img'],
                            "ticker" : ticker,
                            "colorway" : colorway,
                            "retail_price" : retail_price,
                            "release_date" : release_date,
                            "volatility" : volatility,
                            "total_sales" : total_sales,
                            "avg_sale_price" : avg_sale_price,
                            "last_sale_price" : last_sale_price,
                            "last_sale_price_increase" : last_sale_price_increase,
                            "last_sale_price_percent_increase" : last_sale_price_percent_increase,
                            "did_price_increase" : price_increase,
                            "high" : high,
                            "low" : low,
                            "trade_range" : trade_range
                        }
                    #seed into main dictionary
                    sneaker_dict[key] = data
                    time.sleep(1/(random.randint(1,100)*10000))
                    print ('Extracted: '+key)
                    _dict.pop(key)
                #account for errors
                except AttributeError as e:
                    attribute_counter += 1
                    print ('Attribute Error [{}]: '.format(attribute_counter))
                    print (e)
                    #if sneaker is invalid pop the error from the dictionary
                    if attribute_counter > 100:
                        print ('Problem: '+ key)
                        err.append(['a',key,url])
                        _dict.pop(key)
                        attribute_counter = 0
                    pass
                except ConnectionError as e:
                    print (e)
                    err.append(['c',key,url])
                    pass
                except ChunkedEncodingError as e:
                    print (e)
                    err.append(['c',key,url])
                    pass
        #write as individual json file
        #with open('{}.json'.format(brand), 'w') as f:
            #json.dump(sneaker_dict, f, indent=4)
            #f.close()
    #append all missing objects into one json file
    #newData = sneaker_dict
    imageurls = []
    print(newData)
    for key,value in list(sneaker_dict.items()):
        #print("key: \n" + key)
        #print("value's image value: " + value["image"])
        imageurls.append(key)
        shoename = value["image"]
        newData[shoename] = value

    i = 0;
    for key,value in list(newData.items()):
        value["image"] = imageurls[i]
        i+=1

    #print(imageurls)
    #print(json.dumps(newData, sort_keys = True, indent = 4))
    #print(newData)
    #write as individual json file
    with open('{}-part2.json'.format(brand), 'w') as f:
        json.dump(newData, f, indent=4)
        f.close()

    with open('missing.json', 'a') as f:
        json.dump(err, f, indent=4)
        f.close()
    #completed process
    print ("Done querying.")

"""def reformat():
    for key,value in sneaker_dict.items():
        #print(value["image"])
        newData[value["image"]] = value

        for k,v in newData.items():
            v["image"] = key

    #write as individual json file
        with open('{}.json'.format(brand), 'w') as f:
            json.dump(newData, f, indent=4)
            f.close()

    print("DONE REFORMATTING DICT")
"""
 
if __name__ == "__main__":
    sneaker_scraper()