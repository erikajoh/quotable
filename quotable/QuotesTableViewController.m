//
//  QuotesTableViewController.m
//  quotable
//
//  Created by Erika Johnson on 3/19/15.
//  Copyright (c) 2015 Erika Marie Johnson. All rights reserved.
//

#import "QuotesTableViewController.h"

@interface QuotesTableViewController ()

@end

@implementation QuotesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.quotes = [QuotesModel sharedModel];
        
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
     self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.quotes numberOfQuotes];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    // Configure the cell...
    
    static NSString *CellIdentifier = @"QuoteCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSDictionary *quote = [self.quotes quoteAtIndex:indexPath.row];
    NSString *quoteText = [quote valueForKey:@"quote"];
    NSString *authorText = [quote valueForKey:@"author"];
//    NSString *cellText = [[[quoteText stringByAppendingString:@" ("] stringByAppendingString:authorText] stringByAppendingString:@")"];
    [cell.textLabel setNumberOfLines:5]; // unlimited number of lines
    [cell.textLabel setLineBreakMode:UILineBreakModeWordWrap];
    cell.textLabel.text = quoteText;
    cell.detailTextLabel.text = authorText;
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete from the model
        [self.quotes removeQuoteAtIndex:indexPath.row];
        
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    InputViewController *inputVC = segue.destinationViewController;
    inputVC.completionHandler = ^(NSString *quote, NSString *author) {
        if (quote != nil && author != nil) {
            NSUInteger index = [self.quotes numberOfQuotes];
            [self.quotes insertQuote:quote author:author atIndex:index];
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    };
}


@end
