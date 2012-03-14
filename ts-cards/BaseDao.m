
#import "BaseDao.h"
#import "AppDelegate.h"

@implementation BaseDao
@synthesize db;

- (id)init {
  if(self = [super init]){
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    db = [appDelegate db];
  }
  return self;
}



@end