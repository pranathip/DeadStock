//
//  SearchViewSneakerCell.h
//  DeadStock
//
//  Created by Pranathi Peri on 7/13/20.
//  Copyright © 2020 Pranathi Peri. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SearchViewSneakerCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *sneakerPicture;
@property (weak, nonatomic) IBOutlet UILabel *sneakerNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *sneakerColorwayLabel;

@end

NS_ASSUME_NONNULL_END
