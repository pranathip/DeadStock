//
//  StocksViewController.h
//  DeadStock
//
//  Created by Pranathi Peri on 7/9/20.
//  Copyright © 2020 Pranathi Peri. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface StocksViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editButton;

@end

NS_ASSUME_NONNULL_END
