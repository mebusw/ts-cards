//
//  StrategiesViewController.m
//  ts-cards
//
//  Created by  on 12-5-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "StrategiesViewController.h"
#import "TSCard.h"

@interface StrategiesViewController ()

@end

@implementation StrategiesViewController
@synthesize detailItem;
@synthesize lblVP, lblAsia, lblSEAsia, lblDefcon2, lblMidEast, lblEurope, lblCAmerica, lblSAmerica, lblAfrica;

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
    // Update the user interface for the detail item.
    
    if (self.detailItem) {
        TSCard *card = (TSCard*)(self.detailItem);
        DLog(@"%@ %@", card.asia, card.africa);
        [self setBGColor:[UIColor redColor] forField:card.asia onLabel:lblAsia];
        [self setBGColor:[UIColor yellowColor] forField:card.africa onLabel:lblAfrica];
        [self setBGColor:[UIColor purpleColor] forField:card.europe onLabel:lblEurope];
        [self setBGColor:[UIColor orangeColor] forField:card.se_asia onLabel:lblSEAsia];
        [self setBGColor:[UIColor blueColor] forField:card.middle_east onLabel:lblMidEast];
        [self setBGColor:[UIColor greenColor] forField:card.central_america onLabel:lblCAmerica];
        [self setBGColor:[UIColor magentaColor] forField:card.south_america onLabel:lblSAmerica];
        [self setBGColor:[UIColor brownColor] forField:card.vp onLabel:lblVP];
        [self setBGColor:[UIColor cyanColor] forField:card.not_defcon2 onLabel:lblDefcon2];

    }
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
