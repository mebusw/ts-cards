//
//  DetailVCTest.m
//  ts-cards
//
//  Created by  on 12-3-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DetailVCTest.h"
#import "DetailViewController.h"
#import "OCMock/OCMock.h"
#import "TSCard.h"


@implementation DetailVCTest

- (void)setUp {
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown {
    // Tear-down code here.
    
    [super tearDown];
}

- (void)test_configureView {
    DetailViewController *controller = [[DetailViewController alloc] init];
    
//    NSIndexPath *dummyIndexPath = [NSIndexPath indexPathForRow:3 inSection:1];
//    id tableViewMock = [OCMockObject mockForClass:[UITableView class]];
//    [[tableViewMock expect] dequeueReusableCellWithIdentifier:@"Cell"];
    
    [controller viewDidLoad];
    
//    [tableViewMock verify];
    STAssertNil(controller.detailItem, @"");
}
@end
