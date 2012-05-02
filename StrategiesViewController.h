//
//  StrategiesViewController.h
//  ts-cards
//
//  Created by  on 12-5-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StrategiesViewController : UIViewController


@property (strong, nonatomic) id detailItem;


@property (strong, nonatomic) IBOutlet UILabel *lblAsia;
@property (strong, nonatomic) IBOutlet UILabel *lblAfrica;
@property (strong, nonatomic) IBOutlet UILabel *lblSEAsia;
@property (strong, nonatomic) IBOutlet UILabel *lblMidEast;
@property (strong, nonatomic) IBOutlet UILabel *lblEurope;
@property (strong, nonatomic) IBOutlet UILabel *lblCAmerica;
@property (strong, nonatomic) IBOutlet UILabel *lblSAmerica;
@property (strong, nonatomic) IBOutlet UILabel *lblDefcon2;
@property (strong, nonatomic) IBOutlet UILabel *lblVP;

@end
