//
//  VoucherViewController.m
//  Loyal
//
//  Created by Dias Nurul Arifin on 4/20/14.
//  Copyright (c) 2014 Dias Nurul Arifin. All rights reserved.
//

#import "VoucherViewController.h"
#import "ASIFormDataRequest.h"
#import "VoucherModel.h"
#import "VoucherCell.h"
#import "VoucherDetailViewController.h"
@interface VoucherViewController ()

@end

@implementation VoucherViewController
{
    NSMutableArray *vouchers;
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
    vouchers = [[NSMutableArray alloc] init];
    
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
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"http://apimobile.pendhapa.com/api/Voucher"] ];
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
    NSArray *results = [allEvents valueForKey:@"VoucherList"];
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
            VoucherModel *voucher = [VoucherModel new];
            voucher.name = data[@"pro_description"];
            voucher.qty = data[@"pro_qty"];
            if (data[@"pro_picture"] != (id)[NSNull null]){
                voucher.image = [self dataFromBase64EncodedString:data[@"pro_picture"]];
            }
            voucher.point = data[@"pro_point"];
            voucher.price = data[@"pro_prices"];
            [vouchers addObject:voucher];
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
    return [vouchers count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == vouchers.count && tableView != self.searchDisplayController.searchResultsTableView) {
        return (VoucherCell *)[self.tableView dequeueReusableCellWithIdentifier:@"LoadMoreCell"];
    }
    
    static NSString *CellIdentifier = @"Cell";
    VoucherCell *cell = (VoucherCell *)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[VoucherCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    VoucherModel *data = [vouchers objectAtIndex:indexPath.row];
    if (data.name != (id)[NSNull null])
        cell.nameLabel.text = data.name;
    if (data.qty != (id)[NSNull null])
        cell.qtyLabel.text = [NSString stringWithFormat:@"Quantity : %@", data.qty];
    if (data.point != (id)[NSNull null])
        cell.pointLabel.text = [NSString stringWithFormat:@"Point : %@", data.point];
    if (data.price != (id)[NSNull null]){
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setNumberStyle: NSNumberFormatterDecimalStyle];
        NSString *numberAsString = [numberFormatter stringFromNumber:data.price];
        cell.priceLabel.text = [NSString stringWithFormat:@"Price : Rp.%@", numberAsString];
    }
    [cell.imageView setImage:[UIImage imageWithData:data.image]];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==vouchers.count) {
        return 42;
    }else{
        return 92;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==vouchers.count) {
        [self loadMore];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        VoucherDetailViewController *destViewController = segue.destinationViewController;
        destViewController.data = [vouchers objectAtIndex:indexPath.row];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
