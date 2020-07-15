//
//  SearchViewController.h
//  DeadStock
//
//  Created by Pranathi Peri on 7/13/20.
//  Copyright © 2020 Pranathi Peri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Sneaker.h"

NS_ASSUME_NONNULL_BEGIN

@protocol SearchViewControllerDelegate

- (void)didAddToDashboard:(Sneaker *)sneaker;

@end

@interface SearchViewController : UIViewController

@property (nonatomic, weak) id<SearchViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
