//
//  SneakerDetailsViewController.m
//  DeadStock
//
//  Created by Pranathi Peri on 7/17/20.
//  Copyright © 2020 Pranathi Peri. All rights reserved.
//

#import "SneakerDetailsViewController.h"

@interface SneakerDetailsViewController ()

@end

@implementation SneakerDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.sneakerImage.layer.cornerRadius = 6;
    self.sneakerNameLabel.text = self.sneaker[@"sneakerName"];
    NSData * imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:self.sneaker[@"imageURL"]]];
    self.sneakerImage.image = [UIImage imageWithData: imageData];
    self.tickerLabel.text = self.sneaker[@"ticker"];
    self.lastSaleLabel.text = self.sneaker[@"lastSalePrice"];
    
    if ([self.sneaker[@"didPriceIncrease"] boolValue] == YES) {
        self.priceIncreaseLabel.text = [NSString stringWithFormat:@"+%@", self.sneaker[@"lastSalePriceIncrease"]];
        self.volatilityLabel.textColor = [UIColor systemGreenColor];
    } else if ([self.sneaker[@"didPriceIncrease"] boolValue] == NO) {
        self.priceIncreaseLabel.text = [NSString stringWithFormat:@"-%@", self.sneaker[@"lastSalePriceIncrease"]];
        self.priceIncreaseLabel.textColor = [UIColor redColor];
        self.lastSaleButton.selected = YES;
        [self.lastSaleButton setTintColor:[UIColor redColor]];
        self.volatilityLabel.textColor = [UIColor redColor];
    }
    
    self.colorwayLabel.text = self.sneaker[@"colorway"];
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    self.dateLabel.text = [dateFormatter stringFromDate:self.sneaker[@"releaseDate"]];
    NSLog(@"%@", self.sneaker[@"retailPrice"]);
    self.priceLabel.text = self.sneaker[@"retailPrice"];
    self.highLabel.text = self.sneaker[@"weekHigh"];
    self.lowLabel.text = self.sneaker[@"weekLow"];
    self.rangeLabel.text = self.sneaker[@"tradeRange"];
    self.volatilityLabel.text = self.sneaker[@"volatility"];
    
    self.view1.layer.cornerRadius = 3;
    self.view2.layer.cornerRadius = 3;
    self.view3.layer.cornerRadius = 3;
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
