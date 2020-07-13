//
//  Sneaker.h
//  DeadStock
//
//  Created by Pranathi Peri on 7/13/20.
//  Copyright © 2020 Pranathi Peri. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Sneaker : NSObject

// MARK: properties

@property (nonatomic, strong) NSString *sneakerName;
@property (nonatomic, strong) NSURL *stockXURL;
@property (nonatomic, strong) NSString *brand;
@property (nonatomic, strong) NSURL *imageURL;
@property (nonatomic, strong) NSString *ticker;
@property (nonatomic, strong) NSString *colorway;
@property (nonatomic, strong) NSNumber *retailPrice;
@property (nonatomic, strong) NSDate *releaseDate;
@property (nonatomic, strong) NSNumber *volatility;
@property (nonatomic, strong) NSNumber *totalSales;
@property (nonatomic, strong) NSNumber *avgSalePrice;
@property (nonatomic, strong) NSNumber *lastSalePrice;
@property (nonatomic, strong) NSNumber *lastSalePriceIncrease;
@property (nonatomic) BOOL didPriceIncrease;
@property (nonatomic, strong) NSNumber *weekHigh;
@property (nonatomic, strong) NSNumber *weekLow;
@property (nonatomic, strong) NSString *tradeRange;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
+ (NSMutableArray *)sneakersWithArray:(NSArray *)dictionaries;

@end

NS_ASSUME_NONNULL_END
