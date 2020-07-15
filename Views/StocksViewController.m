//
//  StocksViewController.m
//  DeadStock
//
//  Created by Pranathi Peri on 7/9/20.
//  Copyright © 2020 Pranathi Peri. All rights reserved.
//

#import "StocksViewController.h"
#import "SearchViewController.h"
#import "SneakerCell.h"
#import "NilCell.h"
#import "Sneaker.h"
@import Parse;

@interface StocksViewController () <SearchViewControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate>
@property (strong, nonatomic) NSMutableArray *sneakers;
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
    NSArray *sneakersTemp = [NSArray new];
    //self.sneakers = [NSArray new];
    sneakersTemp = currentUser[@"sneakers"];
    self.sneakers = [NSMutableArray arrayWithArray:sneakersTemp];
    if (self.sneakers.count == 0) {
        [self.sneakers addObject:@"nil"];
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
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UINavigationController *navigationController = [segue destinationViewController];
    SearchViewController *searchController = (SearchViewController*)navigationController;
    searchController.delegate = self;
}


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
        Sneaker *sneaker = self.sneakers[indexPath.row];
        [sneaker fetchIfNeededInBackgroundWithBlock:^(PFObject * _Nullable sneaker, NSError * _Nullable error) {
            if (sneaker) {
                       // Cell formatting
                       cell.layer.borderColor = [[UIColor systemGray2Color] CGColor];
                       cell.layer.borderWidth = 1;
                       cell.layer.cornerRadius = 4;
                       
                       cell.tickerLabel.text = sneaker[@"ticker"];
                       cell.priceLabel.text = sneaker[@"lastSalePrice"];
                       NSData * imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:sneaker[@"imageURL"]]];
                       cell.sneakerPicture.image = [UIImage imageWithData: imageData];
                       if (sneaker[@"didPriceIncrease"] == NO) {
                           cell.priceIndicator.selected = YES;
                           [cell.priceIndicator setTintColor:[UIColor redColor]];
                       }
            } else {
                NSLog(@"😫😫😫 Error getting sneakers: %@", error.localizedDescription);
            }
        }];
        return cell;
    }

}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.sneakers.count;
}


- (void)didAddToDashboard:(nonnull Sneaker *)sneaker {
    [self.sneakers insertObject:sneaker atIndex:0];
    PFUser *currentUser = [PFUser currentUser];
    [Sneaker postSneakerToParse:sneaker withCompletion:^(BOOL succeeded, NSError *_Nullable error) {
        if (error) {
            NSLog(@"Error posting: %@", error.localizedDescription);
        } else {
            NSLog(@"Successfully posted sneaker!");
        }
    }];
    currentUser[@"sneakers"] = [NSArray arrayWithArray:self.sneakers];
    [currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"Sneakers array updated");
        } else {
            NSLog(@"Error updating sneakers array: %@", error.localizedDescription);
        }
    }];
    [self.collectionView reloadData];
    //NSLog(@"%lu", self.sneakers.count);
}

@end
