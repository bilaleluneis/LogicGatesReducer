//
//  LogicGatesSolverAppDelegate.m
//  LogicGatesSolver
//
//  Created by Bilal El Uneis on 3/16/10.
//

#import "LogicGatesReducerAppDelegate.h"
#import "LogicGatesSolverViewController.h"
#import "TruthTableModel.h"

@implementation LogicGatesReducerAppDelegate

@synthesize window;
@synthesize viewController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
	// init the initial table view with only 2 inputs
	truthTableArray = [[NSMutableArray alloc] initWithCapacity:4];
	for (int i =0; i < 4; i++) {
		TruthTableModel *truthTableModel = [[TruthTableModel alloc]init];
		[truthTableModel insertBinaryCell:i:2];
		[truthTableArray addObject:truthTableModel];
	}
	// Override point for customization after app launch 
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
	return YES;
}

-(NSMutableArray*) getTruthTable{
	return truthTableArray;
}
-(void) setTruthTable:(NSMutableArray*)array{
	truthTableArray = [[NSMutableArray alloc] initWithCapacity:1];
	for (int i=0; i<[array count]; i++) {
		[truthTableArray addObject:[array objectAtIndex:i]];
	}
}

@end
