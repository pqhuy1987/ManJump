//
//  Map.h
//  ForeignJump
//
//  Created by Francis Visoiu Mistrih on 27/07/13.
//  Copyright (c) 2013 Epimac. All rights reserved.
//

@interface Map : CCLayer

+ (id) mapWithFile:(NSString *)file;

- (id) initWithFile:(NSString *)file;
- (id) loadMap;

@end
 