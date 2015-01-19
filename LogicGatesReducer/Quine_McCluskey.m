//
//  Quine–McCluskey.m
//  LogicGatesSolver
//
//  Created by Bilal El Uneis on 4/21/10.
//  updated 1/18/2015
//

#import "Quine_McCluskey.h"
#import "TruthTableModel.h"

// using empty category to simulate private properties and methods
@interface Quine_McCluskey()

@end


@implementation Quine_McCluskey{
/*cant put private variables in an empty category, it can only hold properties and methods
 so the only option if want to use vars is to declare them in the impl with @private
 */
@private NSMutableArray *tabularTable;
@private NSMutableArray *kmap;
    
}

-(id)init{
	self = [super init];
    if(self){
        tabularTable = nil;
        kmap = nil;
    }
	return self;
}

-(void) createTabularTable:(NSMutableArray*) tt{
	tabularTable = [[NSMutableArray alloc]initWithCapacity:1];
	//insert elemets that has output = 1 into tabular table
	for (int i = 0; i < [tt count]; i++) {
		TruthTableModel *ttm = [tt objectAtIndex:i];
		if ([ttm get_output_value] == 1) {
			[tabularTable addObject:ttm];
		}
	}
}

-(NSString*) displayTabularTable{
	NSMutableString *s = nil;
	s = [[NSMutableString alloc]initWithString:@"\nQuine-McCluseky\n"];
	for (int i =0 ; i < [tabularTable count]; i++) {
		TruthTableModel *ttm = [tabularTable objectAtIndex:i];
		int dec_v =  [ttm get_decimal_value];
		int output_v = [ttm get_output_value];
		NSString *binary_v = [ttm get_binary_value];
		NSNumber *decimal_value = [NSNumber numberWithInt:dec_v];
		NSNumber *output_value = [NSNumber numberWithInt:output_v];
		
		[s appendString:@"m("];
		[s appendString:[decimal_value stringValue]];
		[s appendString:@")\t"];
		[s appendString:binary_v];
		[s appendString:@"\t\t"];
		[s appendString:[output_value stringValue]];
		[s appendString:@"\n"];
	}
	return s;
}

-(NSString*) displayKmap{
	NSMutableString *s = nil;
	s = [[NSMutableString alloc]initWithString:@"\nKmap\n"];
	for (int i =0 ; i < [tabularTable count]; i++) {
		TruthTableModel *ttm = [tabularTable objectAtIndex:i];
		//int dec_v =  [ttm get_decimal_value];
		//int output_v = [ttm get_output_value];
		NSString *binary_v = [ttm get_binary_value];
		//NSNumber *decimal_value = [NSNumber numberWithInt:dec_v];
		//NSNumber *output_value = [NSNumber numberWithInt:output_v];
		NSArray *minterms = [ttm get_covered_minterms];
		[s appendString:@"m("];
		int j =0;
		NSNumber *n=nil;
		for (j=0; j<[minterms count]-1; j++) {
			n = [minterms objectAtIndex:j];
			[s appendString:[n stringValue]];
			[s appendString:@","];
		}
		n = [minterms objectAtIndex:j];
		[s appendString:[n stringValue]];
		//[s appendString:[decimal_value stringValue]];
		[s appendString:@")\t"];
		[s appendString:binary_v];
		if ([ttm isPrimeImp]==YES) {
			[s appendString:@"\t*"];
		}
		[s appendString:@"\n"];
		//[s appendString:[output_value stringValue]];
		//[s appendString:@"\n"];
		
	}
	return s;
}

-(void)reduce{
	kmap = [[NSMutableArray alloc] initWithCapacity:1];
	for (int i=0; i< [tabularTable count]; i++) {
		for (int j=1; j<[tabularTable count]; j++) {
			if ([self differInOneBitOnly:[tabularTable objectAtIndex:i] :[tabularTable objectAtIndex:j]]) {
				TruthTableModel *tmp = [tabularTable objectAtIndex:i];
				TruthTableModel *tt = [[TruthTableModel alloc] init];
				[tt set_decimal_value:[tmp get_decimal_value]];
				[tt set_num_of_inputs:[tmp get_num_of_inputs]];
				[tt set_binary_value:[tmp get_binary_value]];
				[tt set_expression:[tmp get_expression]];
				[tt set_covered_minterms:[tmp get_covered_minterms]];
				[tt addTo_covered_minterms:[[tabularTable objectAtIndex:j]get_covered_minterms]];
				[tt remove_minterm_duplicate]; // remove duplicates
				[tt set_output_value:[tmp get_output_value]];
				int index = [self get_diff_index:[tabularTable objectAtIndex:i] :[tabularTable objectAtIndex:j]];
				[tt setBitValue:'-' :index]; 
				[kmap addObject:tt];
				[tabularTable removeObjectAtIndex:j];
				NSLog(@"KMAP  %@",[self displayKmap]);
			}
			[tabularTable removeObjectAtIndex:i];
			NSLog(@"TABULAR  %@",[self displayTabularTable]);
			
		}
	}
}


-(void)reduceViaQMC{
	kmap = [[NSMutableArray alloc]initWithCapacity:1];
	//NSMutableArray *tmpKmap = nil;
	BOOL bitChangeAccured = NO;
	
	int do_loop_counter = 0;
	if ([tabularTable count] == 0) {
		return;
	}
	int do_loop_sen = [[tabularTable objectAtIndex:0]get_num_of_inputs];
	
	do{
		
		do_loop_counter++;
		
	
		/*if (tmpKmap != nil || [tmpKmap count]>0) {
			[tmpKmap release];
		}
		tmpKmap = [[NSMutableArray alloc]initWithArray:kmap];*/
		
		
	
	for (int i =0; i<[tabularTable count]; i++) {
		for (int j=(i+1); j<[tabularTable count]; j++) {
			if ([self differInOneBitOnly:[tabularTable objectAtIndex:i] :[tabularTable objectAtIndex:j]]) {
				bitChangeAccured = YES;
				TruthTableModel *tmp = [tabularTable objectAtIndex:i];
				TruthTableModel *tmp2= [tabularTable objectAtIndex:j];
				[tmp2 set_isCombined:YES];
				TruthTableModel *tt = [[TruthTableModel alloc] init];
				[tt set_binary_value:[tmp get_binary_value]];
				[tt set_expression:[tmp get_expression]];
				[tt set_covered_minterms:[tmp get_covered_minterms]];
				[tt addTo_covered_minterms:[[tabularTable objectAtIndex:j]get_covered_minterms]];
				[tt remove_minterm_duplicate]; // remove duplicates
				[tt set_output_value:[tmp get_output_value]];
				[tt set_num_of_inputs:[tmp get_num_of_inputs]];
				[tt set_decimal_value:[tmp get_decimal_value]];
				int index = [self get_diff_index:[tabularTable objectAtIndex:i] :[tabularTable objectAtIndex:j]];
				if (index != -1) {
					[tt setBitValue:'-' :index]; 
				}
				[kmap addObject:tt];
				NSLog(@"%@",[self displayKmap]);
			}
		}
		TruthTableModel *tmp = [tabularTable objectAtIndex:i];
		if (bitChangeAccured == NO && i != ([tabularTable count]) && [tmp get_isCombined] == NO) {
			TruthTableModel *tt = [[TruthTableModel alloc] init];
			[tt set_binary_value:[tmp get_binary_value]];
			[tt set_expression:[tmp get_expression]];
			[tt set_covered_minterms:[tmp get_covered_minterms]];
			[tt set_output_value:[tmp get_output_value]];
			[tt set_num_of_inputs:[tmp get_num_of_inputs]];
			[tt set_decimal_value:[tmp get_decimal_value]];
			[kmap addObject:tt];
			NSLog(@"%@",[self displayKmap]);
		}
		bitChangeAccured = NO;
		[tmp set_isCombined:NO];
	}
		
		tabularTable = [[NSMutableArray alloc] initWithArray:kmap];
		kmap = [[NSMutableArray alloc]initWithCapacity:1];
		
	}while(do_loop_counter < do_loop_sen);
	
	//remove duplicate miterms from tabular table
	[self remove_duplicate_minterms];
	
}

-(void) remove_duplicate_minterms{
	for (int i=0; i< [tabularTable count]; i++) {
		for (int j=i+1; j<[tabularTable count]; j++) {
			TruthTableModel *tmp = [tabularTable objectAtIndex:i];
			TruthTableModel *tmp2= [tabularTable objectAtIndex:j];
			if ([[tmp get_binary_value] isEqualToString:[tmp2 get_binary_value]]) {
				[tabularTable removeObjectAtIndex:j];
			}
		}
	}
}


-(BOOL) differInOneBitOnly :(TruthTableModel*)tt1 :(TruthTableModel*)tt2{
	int diff_num = 0;
	BOOL invalid_dash=NO;
	int length = [tt1 get_num_of_inputs];
	char c1;
	char c2;
	for (int i=0; i < length; i++) {
		c1 = [[tt1 get_binary_value] characterAtIndex:i];
		c2 = [[tt2 get_binary_value] characterAtIndex:i];
		if ((c1 != c2) && (c1!='-' && c2 !='-')) {
			++diff_num;
		}
		if ((c1 != c2) && (c1=='-' || c2=='-')) {
			invalid_dash = YES;
		}
	}
	if (diff_num == 1 && invalid_dash==NO)
		return YES;
	else 
		return NO;
}

-(int)get_diff_index:(TruthTableModel*)tt1 :(TruthTableModel*)tt2{
	int length = [tt1 get_num_of_inputs];
	BOOL invalid_dash=NO;
	int index = -1;
	char c1;
	char c2;
	for (int i=0; i < length; i++) {
		c1 = [[tt1 get_binary_value] characterAtIndex:i];
		c2 = [[tt2 get_binary_value] characterAtIndex:i];
		if ((c1 != c2) && (c1!='-' && c2 !='-')) {
			index = i;
		}
		if ((c1 != c2) && (c1=='-' || c2=='-')) {
			invalid_dash = YES;
		}
	}
	if (invalid_dash == NO) {
		return index;
	}
	return -1; // need to check for -1
}


-(NSString*)generateBooleanExpression{
	return nil;
}

-(void)finalMinimization{
    for (int i=0; i < [tabularTable count]; i++) {
		[self markIfPrimeImp:i];
	}
}

-(void)markIfPrimeImp:(int)index{
	TruthTableModel *tt1=[tabularTable objectAtIndex:index];
	//TruthTableModel *tt2=nil;
	//BOOL mintermexist = YES;
	for (int i=0; i<[[tt1 get_covered_minterms]count]; i++) {
		//if (i != index) {
			//tt2 = [tabularTable objectAtIndex:i];
			//[tabularTable 
			//mintermexist = ;
			if ([self minTermExists:[[[tt1 get_covered_minterms] objectAtIndex:i] intValue] :index] == YES) {
				[tt1 setPrimeImp:NO];
				return;
			}
			
		//}
	}
	[tt1 setPrimeImp:YES];
	
}

-(BOOL)minTermExists:(int)minterm :(int)index{
	TruthTableModel *tt = nil;
	for (int i=0; i<[tabularTable count]; i++) {
		if (i != index) {
			tt = [tabularTable objectAtIndex:i];
			for (int j=0; j<[[tt get_covered_minterms]count]; j++) {
				if ([[[tt get_covered_minterms]objectAtIndex:j] intValue] == minterm) {
					return YES;
				}
			}
		}
	}
	return NO;
}

-(void) markPrimeImp:(TruthTableModel*)tt1 :(TruthTableModel*)tt2{
	BOOL is_prime = YES; // be default assume it is prime
	int tt1_min_at =0;
	int tt2_min_at =0;
	for (int i=0; i < [[tt1 get_covered_minterms]count]; i++) {
		for (int j=0; j<[[tt2 get_covered_minterms]count]; j++) {
			tt1_min_at = [[[tt1 get_covered_minterms]objectAtIndex:i] intValue];
			tt2_min_at = [[[tt2 get_covered_minterms]objectAtIndex:j] intValue];
			if (tt1_min_at == tt2_min_at) {//found that the min term accurs else where in other group
				is_prime = NO;
			}
		}
	}
	if (is_prime == YES){
		[tt1 setPrimeImp:YES];
		//[tt2 setPrimeImp:YES];
	}
	else{
		[tt1 setPrimeImp:NO];
		//[tt2 setPrimeImp:NO];
	}
}

@end
