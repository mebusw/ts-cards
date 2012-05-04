//
//  StrategiesViewController.m
//  ts-cards
//
//  Created by  on 12-5-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "StrategiesViewController.h"
#import "TSCard.h"
#import "constants.h"

@interface StrategiesViewController ()

@end

@implementation StrategiesViewController
@synthesize detailItem;
@synthesize lblVP, lblAsia, lblSEAsia, lblDefcon2, lblMidEast, lblEurope, lblCAmerica, lblSAmerica, lblAfrica;
@synthesize lblReminder;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}


- (void)configureView
{
    bool isFullVersion = [[NSUserDefaults standardUserDefaults] boolForKey:kFullVersionUnlocked];
    
    if (isFullVersion && self.detailItem) {
        TSCard *card = (TSCard*)(self.detailItem);
        DLog(@"%@ %@", card.asia, card.africa);
        [self setBGColor:[UIColor redColor] forField:card.asia onLabel:lblAsia];
        [self setBGColor:[UIColor redColor] forField:card.africa onLabel:lblAfrica];
        [self setBGColor:[UIColor redColor] forField:card.europe onLabel:lblEurope];
        [self setBGColor:[UIColor redColor] forField:card.se_asia onLabel:lblSEAsia];
        [self setBGColor:[UIColor redColor] forField:card.middle_east onLabel:lblMidEast];
        [self setBGColor:[UIColor redColor] forField:card.central_america onLabel:lblCAmerica];
        [self setBGColor:[UIColor redColor] forField:card.south_america onLabel:lblSAmerica];
        [self setBGColor:[UIColor redColor] forField:card.vp onLabel:lblVP];
        [self setBGColor:[UIColor redColor] forField:card.not_defcon2 onLabel:lblDefcon2];
    }
    
    lblReminder.hidden = isFullVersion;
}

-(void) setBGColor:(UIColor*)color forField:(NSString*)field onLabel:(UILabel*) label {
    if (field) {
        label.backgroundColor = color;
    }
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)setDetailItem:(id)newDetailItem {
    detailItem = newDetailItem;
}


@end
