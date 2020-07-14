//
//  StocksViewController.m
//  DeadStock
//
//  Created by Pranathi Peri on 7/9/20.
//  Copyright © 2020 Pranathi Peri. All rights reserved.
//

#import "StocksViewController.h"
#import "SneakerCell.h"
#import "NilCell.h"
@import Parse;

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
    
    // Sneakers array initialization
    PFUser *currentUser = [PFUser currentUser];
    self.sneakers = [NSArray new];
    self.sneakers = currentUser[@"sneakers"];
    if (self.sneakers.count == 0) {
        self.sneakers = [NSArray arrayWithObject:@"nil"];
        NSLog(@"%lu", self.sneakers.count);
    }
    
    // Configuring size of CollectionView
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 10;
    CGFloat postersPerLine = 2;
    CGFloat itemWidth = (self.collectionView.frame.size.width - (layout.minimumInteritemSpacing + 28)* (postersPerLine - 1)) / postersPerLine;
    CGFloat itemHeight = itemWidth;
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
    
    // Date
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMMM dd"];
    self.dateLabel.text = [dateFormatter stringFromDate:[NSDate date]];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
/*- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UICollectionViewCell *tappedCell = sender;
    if ([tappedCell isKindOfClass:[NilCell class]]) {
        [self performSegueWithIdentifier:@"searchSegue" sender:nil];
    }
    
}*/


- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    if ([self.sneakers[indexPath.row] isEqual:@"nil"]) {
        NilCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NilCell" forIndexPath:indexPath];
        // Cell formatting
        cell.layer.borderColor = [[UIColor systemGray2Color] CGColor];
        cell.layer.borderWidth = 1;
        cell.layer.cornerRadius = 4;
        return cell;
    }
    else {
        SneakerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SneakerCell" forIndexPath:indexPath];
        // Cell formatting
        cell.layer.borderColor = [[UIColor systemGray2Color] CGColor];
        cell.layer.borderWidth = 1;
        cell.layer.cornerRadius = 4;
        return cell;
    }

}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.sneakers.count;
}

@end
