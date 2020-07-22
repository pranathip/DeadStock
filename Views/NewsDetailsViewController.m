//
//  NewsDetailsViewController.m
//  DeadStock
//
//  Created by Pranathi Peri on 7/17/20.
//  Copyright © 2020 Pranathi Peri. All rights reserved.
//

#import "NewsDetailsViewController.h"

@interface NewsDetailsViewController ()

@end

@implementation NewsDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSData * imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:self.article[@"urlToImage"]]];
    self.newsImage.image = [UIImage imageWithData: imageData];
    self.titleLabel.text = self.article[@"title"];
    self.authorLabel.text = [NSString stringWithFormat:@"By %@, %@", self.article[@"author"], self.article[@"source"][@"name"]];
    self.bodyText.text = self.article[@"description"];
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
