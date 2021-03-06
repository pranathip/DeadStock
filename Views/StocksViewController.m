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
#import "SneakerDetailsViewController.h"
#define degreesToRadians(x) (M_PI * (x) / 180.0)
#define kAnimationRotateDeg 0.5
#define kAnimationTranslateX 1.0
#define kAnimationTranslateY 1.0
@import Parse;
@import UICountingLabel;

@interface StocksViewController () <SearchViewControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate>
@property (strong, nonatomic) NSMutableArray *sneakers;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) BOOL shouldDelete;
@property (nonatomic) BOOL shouldAnimate;
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
    
    // BOOL inits
    self.shouldDelete = NO;
    self.shouldAnimate = YES;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UICollectionViewCell *tappedCell = sender;
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:tappedCell];
    Sneaker *sneaker = self.sneakers[indexPath.row];
    
    if ([segue.identifier isEqualToString:@"detailsSegue"]) {
        SneakerDetailsViewController *detailsViewController = [segue destinationViewController];
        detailsViewController.sneaker = sneaker;
        
    } else if ([segue.identifier isEqualToString:@"searchSegue"]) {
        UINavigationController *navigationController = [segue destinationViewController];
        SearchViewController *searchController = (SearchViewController*)navigationController;
        searchController.delegate = self;
    }
}


- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    if ([self.sneakers[indexPath.row] isEqual:@"nil"]) {
        NilCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NilCell" forIndexPath:indexPath];
        // Cell formatting
        //cell.layer.borderColor = [[UIColor systemGray2Color] CGColor];
        //cell.layer.borderWidth = 2;
        cell.layer.cornerRadius = 4;
        
        return cell;
    }
    else {
        SneakerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SneakerCell" forIndexPath:indexPath];
        Sneaker *sneaker = self.sneakers[indexPath.row];
        [sneaker fetchIfNeededInBackgroundWithBlock:^(PFObject * _Nullable sneaker, NSError * _Nullable error) {
            if (sneaker) {
                // Cell formatting
                //cell.layer.borderColor = [[UIColor systemGray2Color] CGColor];
                //cell.layer.borderWidth = 2;
                cell.layer.cornerRadius = 4;
                if (self.shouldDelete == YES) {
                    cell.deleteButton.alpha = 1;
                    cell.deleteButton.tag = indexPath.row;
                    [cell.deleteButton addTarget:self action:@selector(didTapDelete:) forControlEvents:UIControlEventTouchUpInside];
                    [self startJiggling:cell];
                } else if (self.shouldDelete == NO) {
                    cell.deleteButton.alpha = 0;
                    cell.deleteButton.tag = indexPath.row;
                }
                cell.layer.shadowColor = [UIColor blackColor].CGColor;
                cell.layer.shadowOffset = CGSizeMake(0, 3.0f);
                cell.layer.shadowRadius = 2.0f;
                cell.layer.shadowOpacity = 0.2f;
                cell.layer.masksToBounds = NO;
                cell.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:cell.bounds cornerRadius:cell.contentView.layer.cornerRadius].CGPath;
                cell.tickerLabel.text = sneaker[@"ticker"];
                // Counting animation
                NSString *lastSalePrice = [sneaker[@"lastSalePrice"]
                stringByReplacingOccurrencesOfString:@"$" withString:@""];
                lastSalePrice = [lastSalePrice
                stringByReplacingOccurrencesOfString:@"," withString:@""];
                int lastSalePriceInt = [lastSalePrice intValue];
                cell.priceLabel.format = @"$%d";
                cell.priceLabel.method = UILabelCountingMethodEaseInOut;
                if (self.shouldAnimate) {
                    [cell.priceLabel countFromZeroTo:lastSalePriceInt];
                    self.shouldAnimate = NO;
                } else {
                    cell.priceLabel.text = [sneaker[@"lastSalePrice"] stringByReplacingOccurrencesOfString:@"," withString:@""];
                }
                NSData * imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:sneaker[@"imageURL"]]];
                cell.sneakerPicture.image = [UIImage imageWithData: imageData];
                if ([sneaker[@"didPriceIncrease"] boolValue] == NO) {
                    //NSLog(@"down");
                    cell.priceIndicator.selected = YES;
                    [cell.priceIndicator setTintColor:[UIColor redColor]];
                } else if ([sneaker[@"didPriceIncrease"] boolValue] == YES) {
                    cell.priceIndicator.selected = NO;
                    [cell.priceIndicator setTintColor:[UIColor systemGreenColor]];
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

- (IBAction)editButtonTapped:(id)sender {
    if ([self.editButton.title isEqual:@"Edit"]) {
        self.shouldDelete = YES;
        [self.editButton setTitle:@"Cancel"];
        [self.collectionView reloadItemsAtIndexPaths:self.collectionView.indexPathsForVisibleItems];
    } else if ([self.editButton.title isEqual:@"Cancel"]) {
        self.shouldDelete = NO;
        [self.editButton setTitle:@"Edit"];
        [self.collectionView reloadItemsAtIndexPaths:self.collectionView.indexPathsForVisibleItems];
    }
}

-(void)didTapDelete:(UIButton*)sender {
    NSLog(@"%lu", sender.tag);
    PFUser *currentUser = [PFUser currentUser];
    PFQuery *query = [PFQuery queryWithClassName:@"Sneaker"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *sneaks, NSError *error) {
        if (error) {
            NSLog(@"Error deleting sneaker from parse: %@", error.localizedDescription);
        } else {
            for (Sneaker *s in sneaks) {
                if ([s isEqual:self.sneakers[sender.tag]])
                    NSLog(@"deleted");
                    [s deleteInBackground];
            }
            NSLog(@"Sneaker deleted from parse");
        }
    }];
    [self.sneakers removeObjectAtIndex:sender.tag];
    currentUser[@"sneakers"] = self.sneakers;
    [currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"Sneakers array updated");
        } else {
            NSLog(@"Error updating sneakers array: %@", error.localizedDescription);
        }
    }];
    [self.collectionView reloadData];
}

- (void) startJiggling:(UICollectionViewCell*)cell {
    CGPoint position = cell.center;

    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(position.x, position.y)];
    [path addLineToPoint:CGPointMake(position.x-10, position.y)];
    [path addLineToPoint:CGPointMake(position.x+10, position.y)];
    [path addLineToPoint:CGPointMake(position.x-10, position.y)];
    [path addLineToPoint:CGPointMake(position.x+10, position.y)];
    [path addLineToPoint:CGPointMake(position.x, position.y)];

    CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    positionAnimation.path = path.CGPath;
    positionAnimation.duration = 0.5f;
    positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];

    [CATransaction begin];
    [cell.layer addAnimation:positionAnimation forKey:nil];
    [CATransaction commit];
}
@end
