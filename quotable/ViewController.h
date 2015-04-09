//
//  ViewController.h
//  quotable
//
//  Created by Erika Johnson on 2/25/15.
//  Copyright (c) 2015 Erika Marie Johnson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuotesModel.h"

@interface ViewController : UIViewController

@property (strong, nonatomic) QuotesModel *quotes;
@property (nonatomic) BOOL execBegin;
@property (weak, nonatomic) IBOutlet UILabel *quoteLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *favoriteLabel;

@end

