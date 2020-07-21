//
//  SneakerDetailsViewController.h
//  DeadStock
//
//  Created by Pranathi Peri on 7/17/20.
//  Copyright © 2020 Pranathi Peri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Sneaker.h"

NS_ASSUME_NONNULL_BEGIN

@interface SneakerDetailsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *sneakerNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tickerLabel;
@property (weak, nonatomic) IBOutlet UIImageView *sneakerImage;
@property (weak, nonatomic) IBOutlet UILabel *lastSaleLabel;
@property (weak, nonatomic) IBOutlet UIButton *lastSaleButton;
@property (strong, nonatomic) Sneaker *sneaker;
@property (weak, nonatomic) IBOutlet UILabel *priceIncreaseLabel;
@property (weak, nonatomic) IBOutlet UILabel *colorwayLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@end

NS_ASSUME_NONNULL_END
