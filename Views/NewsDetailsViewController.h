//
//  NewsDetailsViewController.h
//  DeadStock
//
//  Created by Pranathi Peri on 7/17/20.
//  Copyright © 2020 Pranathi Peri. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewsDetailsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *newsImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UITextView *bodyText;

@property (strong, nonatomic) NSDictionary *article;

@end

NS_ASSUME_NONNULL_END
