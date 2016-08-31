//
//  EventViewController.m
//  Loyal
//
//  Created by Dias Nurul Arifin on 4/20/14.
//  Copyright (c) 2014 Dias Nurul Arifin. All rights reserved.
//

#import "EventViewController.h"
#import "ASIFormDataRequest.h"
#import "EventModel.h"
#import "DefaultCell.h"
#import "EventDetailViewController.h"
@interface EventViewController ()

@end

@implementation EventViewController
{
    NSMutableArray *events;
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
    events = [[NSMutableArray alloc] init];
    
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
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"http://apimobile.pendhapa.com/api/Event"] ];
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
    NSMutableDictionary *allEvents = [NSJSONSerialization
                                      JSONObjectWithData:[request responseData]
                                      options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves
                                      error:nil];
    NSArray *results = [allEvents valueForKey:@"EventList"];
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
            EventModel *event = [EventModel new];
            event.name = data[@"event_desc"];
            event.desc = data[@"event_vanue"];
            if (data[@"event_picture"] != (id)[NSNull null]){
                event.image = [self dataFromBase64EncodedString:data[@"event_picture"]];
            }
            event.eventFromDate = data[@"event_frdate"];
            event.eventToDate = data[@"event_todate"];
            event.eventFromTime = data[@"event_frtime"];
            event.eventToTime = data[@"event_totime"];
            event.synopsis = data[@"event_synopsis"];
            [events addObject:event];
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
    return [events count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == events.count && tableView != self.searchDisplayController.searchResultsTableView) {
        return (DefaultCell *)[self.tableView dequeueReusableCellWithIdentifier:@"LoadMoreCell"];
    }
    
    static NSString *CellIdentifier = @"Cell";
    DefaultCell *cell = (DefaultCell *)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[DefaultCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    EventModel *data = [events objectAtIndex:indexPath.row];
    if (data.desc != (id)[NSNull null])
        cell.descLabel.text = data.desc;
    if (data.name != (id)[NSNull null])
        cell.nameLabel.text = data.name;
    [cell.imageView setImage:[UIImage imageWithData:data.image]];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==events.count) {
        return 42;
    }else{
        return 69;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==events.count) {
        [self loadMore];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        EventDetailViewController *destViewController = segue.destinationViewController;
        destViewController.data = [events objectAtIndex:indexPath.row];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
