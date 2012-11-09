#import "VAppDelegate.h"
#import "FeedViewController.h"

@implementation VAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    FeedViewController *controller = [[FeedViewController alloc] init];
    [self.window setRootViewController:controller];
    
    [self.window makeKeyAndVisible];
    return YES;
}
@end
