//
//  BasicViewController.m
//  Loyal
//
//  Created by Dias Nurul Arifin on 4/19/14.
//  Copyright (c) 2014 Dias Nurul Arifin. All rights reserved.
//

#import "BasicViewController.h"
#import "ASIFormDataRequest.h"
#import "DefaultCell.h"
#import "DefaultModel.h"
#import "DetailViewController.h"
@interface BasicViewController ()

@end

@implementation BasicViewController
{
    NSMutableArray *promotionTenants;
    UIAlertView *alert;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
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
                                    @"PageNo":[NSNumber numberWithInt:1],
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
    NSMutableDictionary *allCourses = [NSJSONSerialization
                                       JSONObjectWithData:[request responseData]
                                       options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves
                                       error:nil];
    NSArray *results = [allCourses valueForKey:@"PromotionTenantList"];
    promotionTenants = [[NSMutableArray alloc] init];
    for (NSDictionary *data in results)
    {
        DefaultModel *promotionTenant = [DefaultModel new];
        promotionTenant.name = data[@"tent_desc"];
        promotionTenant.desc = data[@"prom_desc"];
        promotionTenant.image = [self dataFromBase64EncodedString:data[@"tent_image"]];
        promotionTenant.location = @"-";
        promotionTenant.payment = @"-";
        promotionTenant.promoStart = data[@"prom_pstart"];
        promotionTenant.promoEnd = data[@"prom_pend"];
        [promotionTenants addObject:promotionTenant];
    }
    [self.tableView reloadData];
    [alert dismissWithClickedButtonIndex:0 animated:YES];
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
    
    return promotionTenants.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DefaultCell *cell = (DefaultCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
	DefaultModel *data = [promotionTenants objectAtIndex:indexPath.row];
	cell.nameLabel.text = data.name;
	cell.descLabel.text = data.desc;
    [cell.imageView setImage:[UIImage imageWithData:data.image]];
    return cell;
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        DetailViewController *destViewController = segue.destinationViewController;
        destViewController.data = [promotionTenants objectAtIndex:indexPath.row];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
