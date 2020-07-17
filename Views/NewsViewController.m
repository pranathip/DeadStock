//
//  NewsViewController.m
//  DeadStock
//
//  Created by Pranathi Peri on 7/17/20.
//  Copyright © 2020 Pranathi Peri. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsCell.h"

@interface NewsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *news;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self fetchNews];
}

- (void) fetchNews {
    
    NSURL *url = [NSURL URLWithString:@"https://newsapi.org/v2/everything?domains=sneakernews.com&apiKey=26551cec2b2b40fba05f7f5b56c32a61"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
           if (error != nil) {
               NSLog(@"%@", [error localizedDescription]);
           }
           else {
               NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
               
               // TODO: Get the array of news
               // TODO: Store the movies in a property to use elsewhere
               // TODO: Reload your table view data
               NSLog(@"%@", dataDictionary);
               self.news = dataDictionary[@"articles"];
               [self.tableView reloadData];
           }
       }];
    [task resume];
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
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsCell" forIndexPath:indexPath];
    NSDictionary *article = self.news[indexPath.row];
    cell.titleLabel.text = article[@"title"];
    cell.descriptionLabel.text = article[@"description"];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.news.count;
}

@end
