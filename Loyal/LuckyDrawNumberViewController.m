//
//  LuckyDrawNumberViewController.m
//  Loyal
//
//  Created by Dias Nurul Arifin on 4/27/14.
//  Copyright (c) 2014 Dias Nurul Arifin. All rights reserved.
//

#import "LuckyDrawNumberViewController.h"
#import "ASIFormDataRequest.h"
#import "LuckyDrawNumberModel.h"
#import "AppDelegate.h"
#import "JASidePanelController.h"
@interface LuckyDrawNumberViewController ()

@end

@implementation LuckyDrawNumberViewController
{
    NSMutableArray *numbers;
    UIAlertView *alert;
    int currPage;
    NSUserDefaults *defaults;
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

    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    JASidePanelController *rootViewController = (JASidePanelController *)delegate.window.rootViewController;
    
    UIViewController *buttonController = self;
    if ([buttonController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)buttonController;
        if ([nav.viewControllers count] > 0) {
            buttonController = [nav.viewControllers objectAtIndex:0];
        }
    }
    buttonController.navigationItem.leftBarButtonItem = [rootViewController leftButtonForCenterPanel];
    
    currPage = 0;
    numbers = [[NSMutableArray alloc] init];
    
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
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"http://apimobile.pendhapa.com/api/PointRandom"] ];
    
    defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *postBody = @{
                               @"Customer_Sequent_No":[defaults stringForKey:@"custSeqNo"],
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
    NSMutableDictionary *allEvents = [NSJSONSerialization
                                      JSONObjectWithData:[request responseData]
                                      options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves
                                      error:nil];
    NSArray *results = [allEvents valueForKey:@"PointRandomList"];
    [alert dismissWithClickedButtonIndex:0 animated:YES];
    if (results.count < 1) {
        UIAlertView *alertWarning = [[UIAlertView alloc]
                                     initWithTitle:nil
                                     message:@"No more data!"
                                     delegate:nil
                                     cancelButtonTitle:@"OK"
                                     otherButtonTitles: nil];
        [alertWarning show];
    } else {
        for (NSDictionary *data in results)
        {
            LuckyDrawNumberModel *number = [LuckyDrawNumberModel new];
            number.number = data[@"random_point"];
            [numbers addObject:number];
        }
        [self.tableView reloadData];
        currPage++;
        [alert dismissWithClickedButtonIndex:0 animated:YES];
    }
    
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
    return [numbers count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == numbers.count && tableView != self.searchDisplayController.searchResultsTableView) {
        return (UITableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:@"LoadMoreCell"];
    }
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = (UITableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    LuckyDrawNumberModel *data = [numbers objectAtIndex:indexPath.row];
    if (data.number != (id)[NSNull null])
        cell.textLabel.text = data.number;
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==numbers.count) {
        [self loadMore];
    }
}

@end
