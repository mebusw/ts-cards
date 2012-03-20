//
//  DetailViewController.h
//  ts-cards
//
//  Created by mebusw on 12-3-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;


@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property (strong, nonatomic) IBOutlet UILabel *lblNumber;
@property (strong, nonatomic) IBOutlet UILabel *lblEvent;
@property (strong, nonatomic) IBOutlet UILabel *lblOps;
@property (strong, nonatomic) IBOutlet UILabel *lblSide;
@property (strong, nonatomic) IBOutlet UILabel *lblPeriod;

@end
