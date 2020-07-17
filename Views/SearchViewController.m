//
//  SearchViewController.m
//  DeadStock
//
//  Created by Pranathi Peri on 7/13/20.
//  Copyright © 2020 Pranathi Peri. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchViewSneakerCell.h"
#import "Sneaker.h"

@interface SearchViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (nonatomic, strong) NSArray *sneakers;
@property (nonatomic, strong) NSArray *filteredData;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic, strong) Sneaker *selectedSneaker;


@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.searchBar.delegate = self;
    [self fetchSneakers];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    SearchViewSneakerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchCell"];
    Sneaker *sneaker = self.filteredData[indexPath.row];
    cell.sneakerNameLabel.text = sneaker.sneakerName;
    cell.sneakerColorwayLabel.text = sneaker.colorway;
    NSData * imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:sneaker.imageURL]];
    cell.sneakerPicture.image = [UIImage imageWithData: imageData];
    return cell;
}

- (void)fetchSneakers {
    NSArray *arr = [self JSONFromFile];
    self.sneakers = [Sneaker sneakersWithArray:arr];
    self.filteredData = self.sneakers;
}

- (NSArray *)JSONFromFile {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Directions" ofType:@"geojson"];
    //NSLog(@"%@", path);
    NSData *data = [NSData dataWithContentsOfFile:path];
    //NSLog(@"%@", data);
    NSError *readerror;
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&readerror];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.filteredData.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedSneaker = self.filteredData[indexPath.row];
    //NSLog(@"%@", self.selectedSneaker.sneakerName);
    [self.delegate didAddToDashboard:self.selectedSneaker];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    if (searchText.length != 0) {
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat: @"sneakerName contains[c] %@", searchText];
        self.filteredData = [self.sneakers filteredArrayUsingPredicate:predicate];

        NSLog(@"%lu", [self.filteredData count]);
        
    }
    else {
        self.filteredData = self.sneakers;
    }
    
    [self.tableView reloadData];
 
}

@end
