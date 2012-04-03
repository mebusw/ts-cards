//
//  DetailViewController.m
//  ts-cards
//
//  Created by mebusw on 12-3-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"
#import "TSCard.h"
#import <iAd/iAd.h>

@interface DetailViewController ()
- (void)configureView;
@end

@implementation DetailViewController

@synthesize detailItem = _detailItem;

@synthesize lblTitle, lblNumber, lblEvent, lblOps, lblSide, lblPeriod;

ADBannerView *adView;


#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    [self addAdView];
}


- (void)configureView
{
    // Update the user interface for the detail item.
    
    if (self.detailItem) {
        
        TSCard *card = (TSCard*)(self.detailItem);
        self.lblTitle.text = card.title;
        self.lblNumber.text = STR(@"#%@", card.number);
        self.lblEvent.text = card.event;
        self.lblOps.text = STR(NSLocalizedString(@"%@Ops", nil), card.ops);
        self.lblSide.text = card.side;
        self.lblPeriod.text = STR(NSLocalizedString(@"%@ War", nil), card.period);
    }
}

-(void) addAdView {
    adView = [[ADBannerView alloc] initWithFrame:CGRectZero];
    adView.delegate = (id)self;
    CGSize size = self.view.frame.size;
    adView.center = CGPointMake(size.width / 2, size.height);
    [self.view addSubview:adView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    DLog(@"");

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - iAD Delegate Function

- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave
{
	DLog(@"ad: bannerViewActionShouldBegin");
    
	return YES;
}

-(void) bannerViewActionDidFinish:(ADBannerView *)banner
{
	DLog(@"ad: bannerViewActionDidFinish");
    
}

-(void) bannerViewDidLoadAd:(ADBannerView *)banner
{
	DLog(@"ad: bannerViewDidLoadAd");
	
    [UIView beginAnimations:@"animateAdBannerOn" context:NULL];
    // banner is invisible now and moved out of the screen on 50 px
    [UIView setAnimationDuration:1.0];
    CGSize size = self.view.frame.size;
    adView.center = CGPointMake(size.width / 2, size.height - 25);
    adView.hidden = NO;
    [UIView commitAnimations];
    
	
}

-(void) bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
	DLog(@"ad: bannerView error:%@", error);
	
    [UIView beginAnimations:@"animateAdBannerOff" context:NULL];
    // banner is visible and we move it out of the screen, due to connection issue
    adView.hidden = YES;
    [UIView commitAnimations];
    
}


@end
