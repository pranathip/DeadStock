//
//  Sneaker.m
//  DeadStock
//
//  Created by Pranathi Peri on 7/15/20.
//  Copyright © 2020 Pranathi Peri. All rights reserved.
//

#import "Sneaker.h"

@implementation Sneaker

@dynamic sneakerName;
@dynamic stockXURL;
@dynamic brand;
@dynamic imageURL;
@dynamic ticker;
@dynamic colorway;
@dynamic retailPrice;
@dynamic releaseDate;
@dynamic volatility;
@dynamic totalSales;
@dynamic avgSalePrice;
@dynamic lastSalePrice;
@dynamic lastSalePriceIncrease;
@dynamic didPriceIncrease;
@dynamic weekHigh;
@dynamic weekLow;
@dynamic tradeRange;

+ (nonnull NSString *)parseClassName {
    return @"Sneaker";
}

+ (void) postSneakerToParse: (Sneaker *)sneaker withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    //Sneaker *sneak = [Sneaker new];
    //sneak = sneaker;
    [sneaker saveInBackgroundWithBlock: completion];
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super initWithClassName:@"Sneaker"];
    if (self) {
        
        self.sneakerName = dictionary[@"name"];
        //self.stockXURL = [NSURL URLWithString:dictionary[@"url"]];
        self.stockXURL = dictionary[@"url"];
        self.brand = dictionary[@"brand"];
        //self.imageURL = [NSURL URLWithString:dictionary[@"image"]];
        self.imageURL = dictionary[@"image"];
        self.ticker = dictionary[@"ticker"];
        self.colorway = dictionary[@"colorway"];
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc]init];
        self.retailPrice = [numberFormatter numberFromString:[dictionary[@"retailPrice"] stringByReplacingOccurrencesOfString:@"$" withString:@""]];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"MM/dd/yyyy";
        self.releaseDate = [dateFormatter dateFromString:dictionary[@"release_date"]];
        self.volatility = [numberFormatter numberFromString:[dictionary[@"volatility"] stringByReplacingOccurrencesOfString:@"%" withString:@""]];
        self.totalSales = [numberFormatter numberFromString:dictionary[@"total_sales"]];
        self.avgSalePrice = [numberFormatter numberFromString:dictionary[@"avg_sale_price"]];;
        self.lastSalePrice = [numberFormatter numberFromString:dictionary[@"last_sale_price"]];;
        self.lastSalePriceIncrease = [numberFormatter numberFromString:dictionary[@"last_sale_price_increase"]];;
        self.didPriceIncrease = [dictionary[@"did_price_increase"] boolValue];
        self.weekHigh = [numberFormatter numberFromString:[dictionary[@"high"] stringByReplacingOccurrencesOfString:@"$" withString:@""]];
        self.weekLow = [numberFormatter numberFromString:[dictionary[@"low"] stringByReplacingOccurrencesOfString:@"$" withString:@""]];
        self.tradeRange = dictionary[@"trade_range"];
        
    }
    return self;
}

+ (NSMutableArray *)sneakersWithArray:(NSArray *)dictionaries{
    NSMutableArray *sneakers = [NSMutableArray array];
    for (NSDictionary *dictionary in dictionaries) {
        Sneaker *sneaker = [[Sneaker alloc] initWithDictionary:dictionary];
        [sneakers addObject:sneaker];
    }
    return sneakers;
}


@end
