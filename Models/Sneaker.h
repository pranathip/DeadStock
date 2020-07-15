//
//  Sneaker.h
//  DeadStock
//
//  Created by Pranathi Peri on 7/15/20.
//  Copyright © 2020 Pranathi Peri. All rights reserved.
//

#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@interface Sneaker : PFObject

// MARK: properties

@property (nonatomic, strong) NSString *sneakerName;
@property (nonatomic, strong) NSString *stockXURL;
@property (nonatomic, strong) NSString *brand;
@property (nonatomic, strong) NSString *imageURL;
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
+ (void) postSneakerToParse: (Sneaker *)sneaker withCompletion: (PFBooleanResultBlock  _Nullable)completion;
+ (nonnull NSString *)parseClassName;

@end

NS_ASSUME_NONNULL_END
