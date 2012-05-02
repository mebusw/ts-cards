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
@synthesize lblVP, lblAsia, lblSEAsia, lblDefcon2, lblEEurope, lblMidEast, lblWEurope, lblCAmerica, lblSAmerica;

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
//        self.lblNumber.text = STR(@"#%@", card.number);
//        self.lblEvent.text = card.event;
//        self.lblOps.text = I18N(@"%@Ops", card.ops);
//        self.lblSide.text = card.side;
//        self.lblPeriod.text = I18N(@"%@ War", card.period);
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
