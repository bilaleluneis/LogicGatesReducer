#import "TruthTableModel.h"

/**
 @author Bilal El Uneis (bilaleluneis@gmail.com)
 @since 4/3/10 updated 1/19/2015
 @abstract Interface to Model Truth Table used to describe logic gates
 functionality.
 */

@implementation TruthTableModel{
    @private
        NSMutableString *_binaryValue;
        NSMutableString *_expression;
        NSMutableArray *_coveredMinTerms;
        int _numOfInputs;
        int _decimalValue;
        int _outputValue;
        BOOL _combinedInd;
        BOOL _primeImpInd;
}

#pragma mark designated initalizer
- (instancetype)init{
	self = [super init];
    if(self){
        _binaryValue = nil;
        _expression= nil;
        _coveredMinTerms = nil;
        _decimalValue = 0;
        _outputValue = 0;
        _numOfInputs = 0;
        _combinedInd = NO;
        _primeImpInd = NO;
        _coveredMinTerms = [[NSMutableArray alloc]initWithCapacity:1];
    }
	return self;
}


- (void)insertBinaryCell:(int) decimal :(int) numOfIn{
	//initate decimal_value;
	_numOfInputs = numOfIn;
	_decimalValue = decimal;
	[_coveredMinTerms addObject:[NSNumber numberWithInt:_decimalValue]];
	
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
	_binaryValue = [[NSMutableString alloc] initWithCString:binary encoding:NSUTF8StringEncoding];
	//NSLog(@"%@",binary_value);
	
	//generate exprisson
	[self generateExpression:binary];
	//NSLog(@"%@",expression);
}

// this can be changed to use NSString instead
- (void)generateExpression:(char*)bin{
	_expression = [[NSMutableString alloc] initWithString:@""];
	int i =0;
	while (bin[i] != '\0') {
		if (i == 0) {
			if (bin[i] == '0')
				[_expression appendString:@"A'"];
			else
				[_expression appendString:@"A"];
		}
		else if (i == 1) {
			if (bin[i] == '0')
				[_expression appendString:@"B'"];
			else
				[_expression appendString:@"B"];
		}
		else if (i == 2) {
			if (bin[i] == '0')
				[_expression appendString:@"C'"];
			else
				[_expression appendString:@"C"];
		}
		else if (i == 3) {
			if (bin[i] == '0')
				[_expression appendString:@"D'"];
			else
				[_expression appendString:@"D"];
		}
		else if (i == 4) {
			if (bin[i] == '0')
				[_expression appendString:@"X'"];
			else
				[_expression appendString:@"X"];
		}
		else if (i == 5) {
			if (bin[i] == '0')
				[_expression appendString:@"Y'"];
			else
				[_expression appendString:@"Y"];
		}
		else if (i == 6) {
			if (bin[i] == '0')
				[_expression appendString:@"Z'"];
			else
				[_expression appendString:@"Z"];
		}
		
		i++;
	}
}

- (int)get_output_value{
	return _outputValue;
}
- (void)set_output_value :(int)value{
	_outputValue = value;
}

- (void)set_num_of_inputs:(int)value{
	_numOfInputs = value;
}

- (int)get_num_of_inputs{
	return _numOfInputs;
}

- (int)get_decimal_value{
	return _decimalValue;
}
- (void) set_decimal_value:(int)value{
	_decimalValue = value;
}

- (void)setBitValue:(char)bit :(int)index{
	char tmp[20];
	int i=0;
	for (i=0; i<[_binaryValue length]; i++) {
		tmp[i]=[_binaryValue characterAtIndex:i];
	}
	tmp[i]='\0';
	tmp[index]=bit;
    _binaryValue = [[NSMutableString alloc] initWithCString:tmp encoding:NSUTF8StringEncoding];
}

- (void)set_binary_value:(NSString*)value{
    _binaryValue = [[NSMutableString alloc]initWithString:value];
}

- (NSString*)get_binary_value{
	return _binaryValue;
}

- (void)set_expression:(NSString*)exp{
    _expression= [[NSMutableString alloc]initWithString:exp];
}

- (NSString*)get_expression{
	return _expression;
}

- (NSArray*)get_covered_minterms{
	return _coveredMinTerms;
}

- (void)set_covered_minterms:(NSArray*)mintermArray{
	_coveredMinTerms= [[NSMutableArray alloc]initWithArray:mintermArray];
	
}

- (void)addTo_covered_minterms:(NSArray*)mterm{
	for (int i=0; i < [mterm count]; i++) {
		for (int j=0; j<[_coveredMinTerms count]; j++) {
			if([[mterm objectAtIndex:i]intValue] == [[_coveredMinTerms objectAtIndex:j]intValue])
				continue;
			else
			{
				int integer = [[mterm objectAtIndex:i]intValue];
				NSNumber *num = [[NSNumber alloc]initWithInt:integer];
				[_coveredMinTerms addObject:num];
			}
		}
	}
}

- (void)remove_minterm_duplicate{
	int i =0;
	int j =0;
	for (i=0; i < [_coveredMinTerms count]; i++) {
		for (j=(i+1); j<[_coveredMinTerms count]; j++) {
			if ([[_coveredMinTerms objectAtIndex:i] intValue] == [[_coveredMinTerms objectAtIndex:j] intValue]) {
				[_coveredMinTerms removeObjectAtIndex:j];
			}
		}
	}
	int index = (int)[_coveredMinTerms count];
	index = index -1;
	if ([[_coveredMinTerms objectAtIndex:index]intValue] == [[_coveredMinTerms objectAtIndex:index-1]intValue]) {
		[_coveredMinTerms removeObjectAtIndex:index];
	}
	
}

- (BOOL)get_isCombined{ return _combinedInd;}
- (void)set_isCombined:(BOOL)comb { _combinedInd = comb;}

- (void)setPrimeImpInd:(BOOL)isPrime{_primeImpInd = isPrime;}
- (BOOL)isPrimeImpInd{return _primeImpInd;}

@end
