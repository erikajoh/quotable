//
//  FavoritesTableViewController.h
//  quotable
//
//  Created by Erika Johnson on 4/8/15.
//  Copyright (c) 2015 Erika Marie Johnson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "InputViewController.h"

@interface FavoritesTableViewController : UITableViewController

@property (strong, nonatomic) QuotesModel *quotes;

@end
