//
//  ts_cardsTests.m
//  ts-cardsTests
//
//  Created by mebusw on 12-3-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ts_cardsTests.h"
#import "OCMock/OCMock.h"
#import "MasterViewController.h"


@implementation ts_cardsTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testExample
{
    //STFail(@"Unit tests are not implemented yet in ts-cardsTests");
}

-(void) testOCMockExample {
    MasterViewController *controller = [[MasterViewController alloc] init];
    NSIndexPath *dummyIndexPath = [NSIndexPath indexPathForRow:3 inSection:1];
    id tableViewMock = [OCMockObject mockForClass:[UITableView class]];
    [[tableViewMock expect] deleteRowsAtIndexPaths:[NSArray arrayWithObject:dummyIndexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    // Invoke functionality to be tested
    // If you want to see the test fail you can, for example, change the editing style to UITableViewCellEditingStyleNone. In
    // that case the method in the controller does not make a call to the table view and the mock will raise an exception when
    // verify is called further down.
    
    [controller tableView:tableViewMock commitEditingStyle:UITableViewCellEditingStyleDelete forRowAtIndexPath:dummyIndexPath];
    
    // Verify that expectations were met
    
    [tableViewMock verify];

    
}
@end
