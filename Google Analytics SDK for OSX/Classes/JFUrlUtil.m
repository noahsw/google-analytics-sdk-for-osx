//
//  JFUrlUtil.m
//
//  Created by Jason Fuerstenberg on 2011/12/31.
//  Copyright 2011 Jason Fuerstenberg. All rights reserved.
//
//	Licensed under the Apache License, Version 2.0 (the "License");
//	you may not use this file except in compliance with the License.
//	You may obtain a copy of the License at
//
//	http://www.apache.org/licenses/LICENSE-2.0
//
//	Unless required by applicable law or agreed to in writing, software
//	distributed under the License is distributed on an "AS IS" BASIS,
//	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//	See the License for the specific language governing permissions and
//	limitations under the License.

#import "JFUrlUtil.h"

@interface JFUrlUtil (PrivateMethods)

+ (BOOL) isPercentAtIndex: (NSUInteger) index followedByTwoDigitHexCodeInCharacterArray: (unichar *) characters ofLength: (NSUInteger) length;

@end


@implementation JFUrlUtil

/*
 * Encodes the provided URL while respecting the portion before the query and
 * without escaping percent sequences that appear to have already been encoded.
 */
+ (NSString *) encodeUrl: (NSString *) url {
	
	BOOL hasReachedTheQuery = NO;
	NSUInteger length = [url length];
	NSRange rangeOfAllCharacters = NSMakeRange(0, length);
	unichar *chars = malloc(length * sizeof(unichar));
	
	[url getCharacters: chars
				 range: rangeOfAllCharacters];
	
	// The output characters will be collected in another array.
	unichar *outChars = calloc(length * 4, sizeof(unichar));
	NSUInteger outIndex = 0;
	
	// Iterate over every character, encoding any that need it...
	for (NSUInteger inIndex = 0; inIndex < length; ) {
		
		if (!hasReachedTheQuery && chars[inIndex] == '?') {
			// The query portion of the URL has now been reached.
			hasReachedTheQuery = YES;
			outChars[outIndex++] = chars[inIndex++];
			continue;
		}
		
		// The logic in this loop is optimized (loop-unrolled) for performance reasons.
		// SPACE → %20
		if (chars[inIndex] == ' ') {
			outChars[outIndex++] = '%';
			outChars[outIndex++] = '2';
			outChars[outIndex++] = '0';
			inIndex++;
			continue;
		}
		
		// SEMICOLON → %3B
		if (chars[inIndex] == ';') {
			outChars[outIndex++] = '%';
			outChars[outIndex++] = '3';
			outChars[outIndex++] = 'B';
			inIndex++;
			continue;
		}
		
		// @ → %40
		if (chars[inIndex] == '@') {
			outChars[outIndex++] = '%';
			outChars[outIndex++] = '4';
			outChars[outIndex++] = '0';
			inIndex++;
			continue;
		}
		
		// HAT → %5E
		if (chars[inIndex] == '^') {
			outChars[outIndex++] = '%';
			outChars[outIndex++] = '5';
			outChars[outIndex++] = 'E';
			inIndex++;
			continue;
		}
		
		// PIPE → %7C
		if (chars[inIndex] == '|') {
			outChars[outIndex++] = '%';
			outChars[outIndex++] = '7';
			outChars[outIndex++] = 'C';
			inIndex++;
			continue;
		}
		
		// TILDE → %7E
		if (chars[inIndex] == '~') {
			outChars[outIndex++] = '%';
			outChars[outIndex++] = '7';
			outChars[outIndex++] = 'E';
			inIndex++;
			continue;
		}
		
		if (chars[inIndex] == '%') {
			BOOL isAlreadyEncoded = [JFUrlUtil isPercentAtIndex: inIndex
					  followedByTwoDigitHexCodeInCharacterArray: chars
													   ofLength: length];
			if (isAlreadyEncoded) {
				outChars[outIndex++] = chars[inIndex++];
				outChars[outIndex++] = chars[inIndex++];
				outChars[outIndex++] = chars[inIndex++];
				continue;
			} else {
				// The percent needs to be turned into %25
				outChars[outIndex++] = '%';
				outChars[outIndex++] = '2';
				outChars[outIndex++] = '5';
				inIndex++;
				continue;
			}
		}
		
		if (hasReachedTheQuery) {
			// The following characters only need encoding in the query portion of the URL.

			// HYPHEN → %2D
			if (chars[inIndex] == '-') {
				outChars[outIndex++] = '%';
				outChars[outIndex++] = '2';
				outChars[outIndex++] = 'D';
				inIndex++;
				continue;
			}
			
			// PERIOD → %2E
			if (chars[inIndex] == '.') {
				outChars[outIndex++] = '%';
				outChars[outIndex++] = '2';
				outChars[outIndex++] = 'E';
				inIndex++;
				continue;
			}
			
			// SLASH → %2F
			if (chars[inIndex] == '/') {
				outChars[outIndex++] = '%';
				outChars[outIndex++] = '2';
				outChars[outIndex++] = 'F';
				inIndex++;
				continue;
			}
			
			// COLON → %3A
			if (chars[inIndex] == ':') {
				outChars[outIndex++] = '%';
				outChars[outIndex++] = '3';
				outChars[outIndex++] = 'A';
				inIndex++;
				continue;
			}
			
			// QUESTION MARK → %3F
			if (chars[inIndex] == '?') {
				outChars[outIndex++] = '%';
				outChars[outIndex++] = '3';
				outChars[outIndex++] = 'F';
				inIndex++;
				continue;
			}
			
			// { → %7b
			if (chars[inIndex] == '{') {
				outChars[outIndex++] = '%';
				outChars[outIndex++] = '7';
				outChars[outIndex++] = 'B';
				inIndex++;
				continue;
			}
			
			// } → 7d
			if (chars[inIndex] == '}') {
				outChars[outIndex++] = '%';
				outChars[outIndex++] = '7';
				outChars[outIndex++] = 'D';
				inIndex++;
				continue;
			}
		}
			
			
		// The character does not require encoding so just pass it through...
		outChars[outIndex++] = chars[inIndex++];
	}
	
	NSMutableString *outString = [NSMutableString stringWithCharacters: outChars length: outIndex];
	free(chars);
	free(outChars);
	
	return outString;
}

/*
 * Returns YES if the percent at the provided index is followed by an already escaped 2-digit HEX code.
 */
+ (BOOL) isPercentAtIndex: (NSUInteger) index followedByTwoDigitHexCodeInCharacterArray: (unichar *) characters ofLength: (NSUInteger) length {
	
	if (index + 3 > length) {
		// There aren't enough characters after the percent.
		return NO;
	}
	
	unichar firstCharacter = characters[index + 1];
	unichar secondCharacter = characters[index + 2];

	if (!((firstCharacter >= '0' && firstCharacter <= '9') ||
		(firstCharacter >= 'A' && firstCharacter <= 'F') ||
		(firstCharacter >= 'a' && firstCharacter <= 'f'))) {
		return NO;
	}
	
	if (!((secondCharacter >= '0' && secondCharacter <= '9') ||
		  (secondCharacter >= 'A' && secondCharacter <= 'F') ||
		  (secondCharacter >= 'a' && secondCharacter <= 'f'))) {
		return NO;
	}
	
	return YES;
}

@end
