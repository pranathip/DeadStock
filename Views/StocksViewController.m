//
//  StocksViewController.m
//  DeadStock
//
//  Created by Pranathi Peri on 7/9/20.
//  Copyright © 2020 Pranathi Peri. All rights reserved.
//

#import "StocksViewController.h"
#import "SneakerCell.h"

@interface StocksViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) NSArray *sneakers;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation StocksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    self.sneakers = [NSArray arrayWithObjects: @"sneaker 1", @"sneaker 2", @"sneaker 3", @"sneaker 4", @"sneaker 5", @"sneaker 6", nil];
    
    // Configuring size of CollectionView
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 10;
    CGFloat postersPerLine = 2;
    CGFloat itemWidth = (self.collectionView.frame.size.width - (layout.minimumInteritemSpacing + 28)* (postersPerLine - 1)) / postersPerLine;
    CGFloat itemHeight = itemWidth;
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    SneakerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SneakerCell" forIndexPath:indexPath];
    
    // Cell formatting
    cell.layer.borderColor = [[UIColor systemGray2Color] CGColor];
    cell.layer.borderWidth = 1;
    cell.layer.cornerRadius = 4;
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.sneakers.count;
}

@end
