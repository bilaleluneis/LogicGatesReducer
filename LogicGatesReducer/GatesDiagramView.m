//
//  GatesDiagramView.m
//  LogicGatesSolver
//
//  Created by Bilal El Uneis on 3/23/10.
//  updated 1/18/2015 to use modern style
//

#import "GatesDiagramView.h"
#import "LogicGatesReducerAppDelegate.h"
#import "TruthTableModel.h"


@implementation GatesDiagramView


-(void)drawAndGate:(CGContextRef)con :(int)x :(int)y{
	//draw and gate with no input or output
	CGContextMoveToPoint(con, x, y);
	CGContextAddLineToPoint(con, x+25, y);
	CGContextAddQuadCurveToPoint(con, x+40, y+20, x+25, y+40);
	CGContextMoveToPoint(con, x, y+40);
	CGContextAddLineToPoint(con, x+24, y+40);
	CGContextMoveToPoint(con, x, y);
	CGContextAddLineToPoint(con, x, y+40);
	//[myText drawAtPoint:CGPointMake(0.0,0.0) withFont:[UIFont systemFontOfSize:[UIFont systemFontSize]]];
	// upper input 
	CGContextMoveToPoint(con, x-1, y+10);
	CGContextAddLineToPoint(con, x-10, y+10);
	// lower input
	CGContextMoveToPoint(con, x-1, y+30);
	CGContextAddLineToPoint(con, x-10, y+30);
	//draw output of and gate
	CGContextMoveToPoint(con, x+35, y+20);
	CGContextAddLineToPoint(con, x+60, y+20);
	
}

-(void)createAndGateConnection:(CGContextRef)con :(int)x :(int)y{
	// draw downline from output
	CGContextMoveToPoint(con, x+60, y+20);
	CGContextAddLineToPoint(con, x+60, y+45);
	
	//draw line from above statment to upper input
	CGContextMoveToPoint(con, x+60, y+45);
	CGContextAddLineToPoint(con, x-10, y+45);
	
	//connect line from above statment to upper input of gate bellow
	CGContextMoveToPoint(con, x-10, y+45);
	CGContextAddLineToPoint(con, x-10, y+69);
}

-(void)drawORGate:(CGContextRef)con :(int)x :(int)y{
	// draw the OR gate
	CGContextMoveToPoint(con, x+100, y-40);
	CGContextAddQuadCurveToPoint(con, x+250, y+20, x+100, y+60);
	CGContextMoveToPoint(con, x+100, y-40);
	CGContextAddQuadCurveToPoint(con, x+150, y+20, x+100, y+60);
	
	//draw the output line
	CGContextMoveToPoint(con, x+175, y+15);
	CGContextAddLineToPoint(con, x+200, y+15);
	//CGContextAddQuadCurveToPoint(<#CGContextRef c#>, <#CGFloat cpx#>, <#CGFloat cpy#>, <#CGFloat x#>, <#CGFloat y#>)
}


- (void)drawRect:(CGRect)rect {
	TruthTableModel *truthTableModel;
	LogicGatesReducerAppDelegate *del = (LogicGatesReducerAppDelegate*) [[UIApplication sharedApplication] delegate];
	NSMutableArray *truthTableArry = [del getTruthTable];
	NSUInteger and_gate_num=[truthTableArry count];
	NSUInteger middle_point = and_gate_num / 2;
	int x = 50;
	int y = 50;
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetStrokeColorWithColor(context, [UIColor greenColor].CGColor);
	CGContextSetLineWidth(context, 1.0);
	//begin the sketch and gates
	for (int i =0; i < [truthTableArry count]; ++i) {
		truthTableModel = [truthTableArry objectAtIndex:i];
		if (i==middle_point) {
			[self drawORGate:context :x :y];
		}
		if ([truthTableModel get_output_value] == 1 && [truthTableModel get_num_of_inputs] == 2) {
			[self drawAndGate:context :x :y];
			//increase Y
			y= y + 60;
		}
		else if([truthTableModel get_output_value] == 1 && [truthTableModel get_num_of_inputs] == 3){
			[self drawAndGate:context :x :y];
			[self createAndGateConnection:context :x :y];
			//increase y
			y= y + 60;
			[self drawAndGate:context :x :y];
			//increase y
			y= y + 60;
		}
		else if([truthTableModel get_output_value] == 1 && [truthTableModel get_num_of_inputs] == 4){
		}
		else if([truthTableModel get_output_value] == 1 && [truthTableModel get_num_of_inputs] == 5){
		}
		else if([truthTableModel get_output_value] == 1 && [truthTableModel get_num_of_inputs] == 6){
		}
		else if([truthTableModel get_output_value] == 1 && [truthTableModel get_num_of_inputs] == 7){
		}
		/*
		//draw and gate with no input or output
		CGContextMoveToPoint(context, x, y);
		CGContextAddLineToPoint(context, x+25, y);
		CGContextAddQuadCurveToPoint(context, x+40, y+20, x+25, y+40);
		CGContextMoveToPoint(context, x, y+40);
		CGContextAddLineToPoint(context, x+24, y+40);
		CGContextMoveToPoint(context, x, y);
		CGContextAddLineToPoint(context, x, y+40);
		
		//draw output of and gate
		CGContextMoveToPoint(context, x+35, y+20);
		CGContextAddLineToPoint(context, x+60, y+20);
		
		// draw downline from output
		CGContextMoveToPoint(context, x+60, y+20);
		CGContextAddLineToPoint(context, x+60, y+45);
		
		//draw line from above statment to upper input
		CGContextMoveToPoint(context, x+60, y+45);
		CGContextAddLineToPoint(context, x-10, y+45);
		
		//connect line from above statment to upper input of gate bellow
		CGContextMoveToPoint(context, x-10, y+45);
		CGContextAddLineToPoint(context, x-10, y+69);
		
		
		//draw inputs for and gates
		
		// upper input 
		CGContextMoveToPoint(context, x-1, y+10);
		CGContextAddLineToPoint(context, x-10, y+10);
		
		// lower input
		CGContextMoveToPoint(context, x-1, y+30);
		CGContextAddLineToPoint(context, x-10, y+30);
		
		if (i == middle_point) {
			// draw the OR gate
			CGContextMoveToPoint(context, x+100, y-40);
			CGContextAddQuadCurveToPoint(context, x+250, y+20, x+100, y+60);
			CGContextMoveToPoint(context, x+100, y-40);
			CGContextAddQuadCurveToPoint(context, x+150, y+20, x+100, y+60);
			
			//draw the output line
			CGContextMoveToPoint(context, x+175, y+15);
			CGContextAddLineToPoint(context, x+200, y+15);
			//CGContextAddQuadCurveToPoint(<#CGContextRef c#>, <#CGFloat cpx#>, <#CGFloat cpy#>, <#CGFloat x#>, <#CGFloat y#>)
			
		}*/
		
		
		//y= y + 60;
	}
	
	// stroke the points and draw context on screen
	CGContextStrokePath(context);
}


@end
