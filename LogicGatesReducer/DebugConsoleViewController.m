//
//  DebugConsoleViewController.m
//  LogicGatesSolver
//
//  Created by Bilal El Uneis on 4/22/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DebugConsoleViewController.h"
#import "Quine_McCluskey.h"
#import "LogicGatesReducerAppDelegate.h"


@implementation DebugConsoleViewController

@synthesize debugConsole;
@synthesize returnButton;

-(id)init{
	//NSMutableArray *tmp = del.truthTableArray;
	//[test createTabularTable:tmp];
	//[test displayTabularTable];
	self = [super init];
	
	return self;
}

-(void) viewDidLoad{
	qmc = [[Quine_McCluskey alloc]init];
	del = (LogicGatesReducerAppDelegate*) [[UIApplication sharedApplication] delegate];
	[qmc createTabularTable:[del getTruthTable]];
	NSMutableString *debugStatment = [[NSMutableString alloc] initWithString:[qmc displayTabularTable]];
	
	[debugConsole setText:debugStatment];
	[qmc reduceViaQMC];
	[qmc finalMinimization];
	[debugStatment appendString:[qmc displayKmap]];
	//[debugStatment appendString:[qmc displayTabularTable]];
	[debugConsole setText:debugStatment];

}

-(IBAction) return_from_console{
	//[qmc release];
	[self dismissModalViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


@end
