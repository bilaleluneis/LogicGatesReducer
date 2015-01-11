//
//  GatesDiagramViewController.m
//  LogicGatesSolver
//
//  Created by Bilal El Uneis on 3/23/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GatesDiagramViewController.h"
#import "GatesDiagramView.h"


@implementation GatesDiagramViewController

@synthesize scrollView;


- (void)loadView {
    [ super loadView ];
	[scrollView setScrollEnabled:YES];
	[scrollView setBounces:YES];
	//scrollView.maximumZoomScale = 2.0;
	//scrollView.minimumZoomScale = 0.25;
	scrollView.delegate = self;
	//NEED TO GET BACK TO THIS FOR PROPER WAY TO SCROLL AND NOT HAVE BUNCH OF EMPTY SPACE
	[scrollView setContentSize:CGSizeMake(320, 1000)];
	gatesView = [[GatesDiagramView alloc] initWithFrame:CGRectMake(0, 0, 320, 1000)];
	//scrollView.contentSize = gatesView.frame.size;
	[scrollView addSubview:gatesView];
	//[gatesView release];
	//self.view = scrollView;
	//[gatesView release];//maybe
}

- (UIView *) viewForZoomingInScrollView:(UIScrollView *)scrollView{
	return gatesView;
}

- (IBAction) done{
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
