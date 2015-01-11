//
//  LogicGatesSolverViewController.h
//  LogicGatesSolver
//
//  Created by Bilal El Uneis on 3/16/10.
//  
//

#import <UIKit/UIKit.h>

@class TruthTableModel;
@class LogicGatesReducerAppDelegate;

@interface LogicGatesSolverViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
	
	UITableView *tableView;
	UILabel *number_of_inputs;
	UITextView *booleanExpression;
	int input_num;
}

@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) IBOutlet UILabel *number_of_inputs;
@property (nonatomic, retain) IBOutlet UITextView *booleanExpression;

- (IBAction)showInfo;
- (IBAction) debug;
- (IBAction)increase_num_of_input;
- (IBAction)decrease_num_of_input;

-(NSMutableString*) setTextView_expression:(NSMutableArray*)truthTable;

@end

