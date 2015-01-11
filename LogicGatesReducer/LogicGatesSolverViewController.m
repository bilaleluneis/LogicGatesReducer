//
//  LogicGatesSolverViewController.m
//  LogicGatesSolver
//
//  Created by Bilal El Uneis on 3/16/10.
//  
//

#import "LogicGatesSolverViewController.h"
#import "GatesDiagramViewController.h"
#import "TruthTableModel.h"
#import "LogicGatesReducerAppDelegate.h"

#import "Quine_McCluskey.h"
#import "DebugConsoleViewController.h"

#import <math.h>

@implementation LogicGatesSolverViewController

@synthesize tableView;
@synthesize number_of_inputs;
@synthesize booleanExpression;
//@synthesize delegate;


- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section{
	LogicGatesReducerAppDelegate *del = (LogicGatesReducerAppDelegate*) [[UIApplication sharedApplication] delegate];
	return [[del getTruthTable]count];
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	UITableViewCell *cell = [tv dequeueReusableCellWithIdentifier:@"cell"];
	if (cell == nil) {
		cell = [[UITableViewCell alloc]initWithFrame:CGRectZero reuseIdentifier:@"cell"];
	}
	LogicGatesReducerAppDelegate *del = (LogicGatesReducerAppDelegate*) [[UIApplication sharedApplication] delegate];
	TruthTableModel *truthTableModel = [[del getTruthTable] objectAtIndex:indexPath.row];
	NSMutableString *tmpstring1 = [[NSMutableString alloc] initWithString:[truthTableModel get_binary_value]];
	[tmpstring1 appendString:@"    ["];
	[tmpstring1 appendString:[truthTableModel get_expression]];
	[tmpstring1 appendString:@"]    "];
	NSNumber *n = [NSNumber numberWithInt:[truthTableModel get_output_value]];
	[tmpstring1 appendString:[n stringValue]];
	cell.textLabel.text = tmpstring1;
	return cell;
}

- (void)tableView:(UITableView *)tv didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	LogicGatesReducerAppDelegate *del = (LogicGatesReducerAppDelegate*) [[UIApplication sharedApplication] delegate];
	TruthTableModel *truthTableModel = [[del getTruthTable] objectAtIndex:indexPath.row];
	if ([truthTableModel get_output_value] == 0) {
		[truthTableModel set_output_value:1];
	}
	else {
		[truthTableModel set_output_value:0];
	}
	[tv deselectRowAtIndexPath:indexPath animated:YES];
	[tv reloadData];
	NSMutableString *text = [self setTextView_expression:[del getTruthTable]];
	[booleanExpression setText:text];
	//[text release];
}

-(NSMutableString*) setTextView_expression:(NSMutableArray*)truthTable{
	int i = 0;
	NSMutableString *string = [[NSMutableString alloc]initWithString:@""];
	for (i=0; i < [truthTable count]; i++) {
		TruthTableModel *truthTableModel = [truthTable objectAtIndex:i];
		if ([truthTableModel get_output_value] == 1) {
			if ([string length] != 0) {
				[string	appendString:@"+"];
			}
			[string appendString:[truthTableModel get_expression]];
		}
	}
	return string;
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	// Release any cached data, images, etc that aren't in use.
}


//actions
- (IBAction)showInfo { 
	GatesDiagramViewController *controller = 
	[[GatesDiagramViewController alloc] initWithNibName:@"GatesDiagramViewController" bundle:nil];
	controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	[self presentModalViewController:controller animated:YES];
}

- (IBAction) debug{
	DebugConsoleViewController *debugConsole = [[DebugConsoleViewController alloc]init];
	debugConsole.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	[self presentModalViewController:debugConsole animated:YES];

}

- (IBAction)increase_num_of_input{
	int tmp = [number_of_inputs.text intValue];
	if (tmp != 7) {
		tmp +=1;
		NSNumber *numberobj = [NSNumber numberWithInt:tmp];
		[number_of_inputs setText:[numberobj stringValue]];
		LogicGatesReducerAppDelegate *del = (LogicGatesReducerAppDelegate*) [[UIApplication sharedApplication] delegate];
		/*if (del.truthTableArray != nil) {
			[del.truthTableArray release];
		}*/
		//[del.truthTableArray release];
		NSMutableArray *newTable = [[NSMutableArray alloc] initWithCapacity:(int)pow((int)2, (int)tmp)];
		for (int i =0; i < (int)pow((int)2, (int)tmp); i++) {
			TruthTableModel *t = [[TruthTableModel alloc]init];
			[t set_num_of_inputs:tmp];
			[t insertBinaryCell:i:tmp];
			[newTable addObject:t];
		}
		[del setTruthTable:newTable];
		[tableView reloadData];
	}
}


- (IBAction)decrease_num_of_input{
	int tmp = [number_of_inputs.text intValue];
	if (tmp != 2) {
		tmp -=1;
		NSNumber *numberobj = [NSNumber numberWithInt:tmp];
		[number_of_inputs setText:[numberobj stringValue]];
		LogicGatesReducerAppDelegate *del = (LogicGatesReducerAppDelegate*) [[UIApplication sharedApplication] delegate];
		NSMutableArray *newTable = [[NSMutableArray alloc] initWithCapacity:(int)pow((int)2, (int)tmp)];
		for (int i =0; i < (int)pow((int)2, (int)tmp); i++) {
			TruthTableModel *t = [[TruthTableModel alloc]init];
			[t set_num_of_inputs:tmp];
			[t insertBinaryCell:i:tmp];
			[newTable addObject:t];
		}
		[del setTruthTable:newTable];
		[tableView reloadData];
	}
}

@end
