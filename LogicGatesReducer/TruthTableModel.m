//
//  TruthTableModel.m
//  LogicGatesSolver
//
//  Created by Bilal El Uneis on 4/3/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TruthTableModel.h"


@implementation TruthTableModel

-(id) init{
	self = [super init];
	binary_value = nil;
	expression= nil;
	coveredMinTerms = nil;
	decimal_value = 0;
	output_value = 0;
	num_of_inputs = 0;
	isCombined = NO;
	isPrimeImp = NO;
	coveredMinTerms = [[NSMutableArray alloc]initWithCapacity:1];
	return self;
}


-(void)insertBinaryCell:(int) decimal :(int) numOfIn{
	//initate decimal_value;
	num_of_inputs = numOfIn;
	decimal_value = decimal;
	[coveredMinTerms addObject:[NSNumber numberWithInt:decimal_value]];
	
	//rest of code from C
	int  k = 0, n = 0;
	int  neg_flag = 0;
	int  remain;
	//int  old_decimal;  // for test
	char temp[80];
	char binary[80];
	
	// take care of negative input
	if (decimal < 0)
	{      
		decimal = -decimal;
		neg_flag = 1;
	}
	do 
	{
		//old_decimal = decimal;   // for test
		remain    = decimal % 2;
		// whittle down the decimal number
		decimal   = decimal / 2;
		// this is a test to show the action
		//printf("%d/2 = %d  remainder = %d\n", old_decimal, decimal, remain);
		// converts digit 0 or 1 to character '0' or '1'
		temp[k++] = remain + '0';
	} while (decimal > 0);
	
	if (neg_flag)
		temp[k++] = '-';       // add - sign
	else
		temp[k++] = ' ';       // space
	
	//add 0 for what is before to acomidate input size .. ex 2 = 10 but we have 3 input so result is 010
	int input_diff = (numOfIn - k)+1;
	while (n < input_diff) 
		binary[n++] = '0';
	
	// reverse the spelling
	k--;
	while (k >= 0)
		binary[n++] = temp[--k];
	
	binary[n-1] = '\0';         // end with NULL
	//copy c array string to c_binary_value
	//strcpy (c_binary_value,binary);
	//printf("\nc_binary value is %s\n",c_binary_value);
	
	//create NSString out of the C string
	binary_value = [[NSString alloc] initWithCString:binary];
	//NSLog(@"%@",binary_value);
	
	//generate exprisson
	[self generate_expression:binary];
	//NSLog(@"%@",expression);
}

// this can be changed to use NSString instead
-(void)generate_expression:(char*)bin{
	expression = [[NSMutableString alloc] initWithString:@""];
	int i =0;
	while (bin[i] != '\0') {
		if (i == 0) {
			if (bin[i] == '0')
				[expression appendString:@"A'"];
			else
				[expression appendString:@"A"];
		}
		else if (i == 1) {
			if (bin[i] == '0')
				[expression appendString:@"B'"];
			else
				[expression appendString:@"B"];
		}
		else if (i == 2) {
			if (bin[i] == '0')
				[expression appendString:@"C'"];
			else
				[expression appendString:@"C"];
		}
		else if (i == 3) {
			if (bin[i] == '0')
				[expression appendString:@"D'"];
			else
				[expression appendString:@"D"];
		}
		else if (i == 4) {
			if (bin[i] == '0')
				[expression appendString:@"X'"];
			else
				[expression appendString:@"X"];
		}
		else if (i == 5) {
			if (bin[i] == '0')
				[expression appendString:@"Y'"];
			else
				[expression appendString:@"Y"];
		}
		else if (i == 6) {
			if (bin[i] == '0')
				[expression appendString:@"Z'"];
			else
				[expression appendString:@"Z"];
		}
		
		i++;
	}
}

-(int)get_output_value{
	return output_value;
}
-(void)set_output_value :(int)value{
	output_value = value;
}

-(void)set_num_of_inputs:(int)value{
	num_of_inputs = value;
}

-(int)get_num_of_inputs{
	return num_of_inputs;
}

-(int)get_decimal_value{
	return decimal_value;
}
-(void) set_decimal_value:(int)value{
	decimal_value = value;
}

-(void)setBitValue:(char)bit :(int)index{
	char tmp[20];
	int i=0;
	for (i=0; i<[binary_value length]; i++) {
		tmp[i]=[binary_value characterAtIndex:i];
	}
	tmp[i]='\0';
	tmp[index]=bit;
    binary_value = [[NSMutableString alloc] initWithCString:tmp];
}

-(void)set_binary_value:(NSString*)value{
    binary_value = [[NSMutableString alloc]initWithString:value];
}

-(NSString*)get_binary_value{
	return binary_value;
}

-(void)set_expression:(NSString*)exp{
    expression= [[NSMutableString alloc]initWithString:exp];
}

-(NSString*)get_expression{
	return expression;
}

-(NSArray*)get_covered_minterms{
	return coveredMinTerms;
}

-(void)set_covered_minterms:(NSArray*)mintermArray{
	coveredMinTerms= [[NSMutableArray alloc]initWithArray:mintermArray];
	
}

-(void)addTo_covered_minterms:(NSArray*)mterm{
	for (int i=0; i < [mterm count]; i++) {
		for (int j=0; j<[coveredMinTerms count]; j++) {
			if([[mterm objectAtIndex:i]intValue] == [[coveredMinTerms objectAtIndex:j]intValue])
				continue;
			else
			{
				int integer = [[mterm objectAtIndex:i]intValue];
				NSNumber *num = [[NSNumber alloc]initWithInt:integer];
				[coveredMinTerms addObject:num];
			}
		}
	}
}

-(void)remove_minterm_duplicate{
	int i =0;
	int j =0;
	for (i=0; i < [coveredMinTerms count]; i++) {
		for (j=(i+1); j<[coveredMinTerms count]; j++) {
			if ([[coveredMinTerms objectAtIndex:i] intValue] == [[coveredMinTerms objectAtIndex:j] intValue]) {
				[coveredMinTerms removeObjectAtIndex:j];
			}
		}
	}
	int index = [coveredMinTerms count];
	index = index -1;
	if ([[coveredMinTerms objectAtIndex:index]intValue] == [[coveredMinTerms objectAtIndex:index-1]intValue]) {
		[coveredMinTerms removeObjectAtIndex:index];
	}
	
}

-(BOOL)get_isCombined{ return isCombined;}
-(void)set_isCombined:(BOOL)comb { isCombined = comb;}

-(void)setPrimeImp:(BOOL)isPrime{isPrimeImp = isPrime;}
-(BOOL)isPrimeImp{return isPrimeImp;}

@end
