//
//  PromotionViewController.m
//  Loyal
//
//  Created by Dias Nurul Arifin on 4/26/14.
//  Copyright (c) 2014 Dias Nurul Arifin. All rights reserved.
//

#import "PromotionViewController.h"
#import "ASIFormDataRequest.h"
#import "DefaultCell.h"
#import "DefaultModel.h"
#import "DetailViewController.h"
@interface PromotionViewController ()

@end

@implementation PromotionViewController
{
    NSMutableArray *promos;
    NSArray *searchResults;
    UIAlertView *alert;
    int currPage;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    currPage = 0;
    promos = [[NSMutableArray alloc] init];
    
    [self loadMore];

}

- (void)loadMore
{
    alert = [[UIAlertView alloc]
             initWithTitle:@"Loading..."
             message:@"Please wait we're getting your data"
             delegate:nil
             cancelButtonTitle:nil
             otherButtonTitles: nil];
    [alert show];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"http://apimobile.pendhapa.com/api/Promotion"] ];
    NSDictionary *postBody = @{
                               @"Token":@"140101",
                               @"PageNo":[NSNumber numberWithInt:currPage+1],
                               @"PageLength":[NSNumber numberWithInt:10]
                               };
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:postBody
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    [request appendPostData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request setRequestMethod:@"POST"];
    [request setDelegate:self];
    [request startAsynchronous];
    NSLog(@"Yolo Getting Data...");
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSMutableDictionary *allTenans = [NSJSONSerialization
                                      JSONObjectWithData:[request responseData]
                                      options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves
                                      error:nil];
    NSArray *results = [allTenans valueForKey:@"PromotionTenantList"];
    [alert dismissWithClickedButtonIndex:0 animated:YES];
    if (results.count < 1) {
        UIAlertView *alertWarning = [[UIAlertView alloc]
                                     initWithTitle:nil
                                     message:@"No more shit!"
                                     delegate:nil
                                     cancelButtonTitle:@"OK"
                                     otherButtonTitles: nil];
        [alertWarning show];
    } else {
        for (NSDictionary *data in results)
        {
            DefaultModel *promotionTenant = [DefaultModel new];
            promotionTenant.name = data[@"tent_desc"];
            promotionTenant.desc = data[@"prom_desc"];
            NSLog(@"%@", promotionTenant.desc);
            promotionTenant.image = [self dataFromBase64EncodedString:data[@"tent_image"]];
            promotionTenant.location = @"-";
            promotionTenant.payment = @"-";
            promotionTenant.promoStart = data[@"prom_pstart"];
            promotionTenant.promoEnd = data[@"prom_pend"];
            [promos addObject:promotionTenant];
        }
        [self.tableView reloadData];
        currPage++;
        [alert dismissWithClickedButtonIndex:0 animated:YES];
    }
    
}

-(NSData *)dataFromBase64EncodedString:(NSString *)string{
    if (string.length > 0) {
        NSString *data64URLString = [NSString stringWithFormat:@"data:;base64,%@", string];
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:data64URLString]];
        return data;
    }
    return nil;
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    NSLog(@"Yolo Error: %@", error);
    [alert dismissWithClickedButtonIndex:0 animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [searchResults count];
    } else {
        return [promos count] + 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == promos.count && tableView != self.searchDisplayController.searchResultsTableView) {
        return (DefaultCell *)[self.tableView dequeueReusableCellWithIdentifier:@"LoadMoreCell"];
    }
    
    static NSString *CellIdentifier = @"Cell";
    DefaultCell *cell = (DefaultCell *)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[DefaultCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    DefaultModel *data = nil;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        data = [searchResults objectAtIndex:indexPath.row];
    } else {
        data = [promos objectAtIndex:indexPath.row];
    }
    if (data.desc != (id)[NSNull null])
        cell.descLabel.text = data.desc;
    if (data.name != (id)[NSNull null])
        cell.nameLabel.text = data.name;
    [cell.imageView setImage:[UIImage imageWithData:data.image]];
    return cell;
    
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"name contains[cd] %@ OR desc contains[cd] %@", searchText, searchText];
    searchResults = [promos filteredArrayUsingPredicate:resultPredicate];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==promos.count) {
        return 42;
    }else{
        return 69;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==promos.count) {
        [self loadMore];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        DetailViewController *destViewController = segue.destinationViewController;
        destViewController.data = [promos objectAtIndex:indexPath.row];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
