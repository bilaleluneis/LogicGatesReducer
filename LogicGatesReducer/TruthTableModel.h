//
//  TruthTableModel.h
//  LogicGatesSolver
//
//  Created by Bilal El Uneis on 4/3/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TruthTableModel : NSObject {
	NSMutableString *binary_value;
	NSMutableString *expression;
	NSMutableArray *coveredMinTerms;
	int num_of_inputs;
	int decimal_value;
	int output_value;
	BOOL isCombined;
	BOOL isPrimeImp;
}

-(id)init;
-(void)insertBinaryCell:(int) decimal :(int) numOfIn;
-(void)generate_expression:(char*) bin;
-(int)get_output_value;
-(void)set_output_value :(int)value;
-(void)set_num_of_inputs:(int)value;
-(int)get_num_of_inputs;
-(int)get_decimal_value;
-(void) set_decimal_value:(int)value;
-(void)setBitValue:(char)bit :(int)index;
-(void)set_binary_value:(NSString*)value;
-(NSString*)get_binary_value;
-(void)set_expression:(NSString*)exp;
-(NSString*)get_expression;
//-(int)get_binary_value_length;
-(void)dealloc;
-(NSArray*)get_covered_minterms;
-(void)set_covered_minterms:(NSArray*)mintermArray;
-(void)addTo_covered_minterms:(NSArray*)mterm;
-(void)remove_minterm_duplicate;
-(BOOL)get_isCombined;
-(void)set_isCombined:(BOOL)comb;
-(void)setPrimeImp:(BOOL)isPrime;
-(BOOL)isPrimeImp;

@end
