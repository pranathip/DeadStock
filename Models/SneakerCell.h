//
//  SneakerCell.h
//  DeadStock
//
//  Created by Pranathi Peri on 7/10/20.
//  Copyright © 2020 Pranathi Peri. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SneakerCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *tickerLabel;
@property (weak, nonatomic) IBOutlet UIImageView *sneakerPicture;
@property (weak, nonatomic) IBOutlet UIButton *priceIndicator;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@end

NS_ASSUME_NONNULL_END
