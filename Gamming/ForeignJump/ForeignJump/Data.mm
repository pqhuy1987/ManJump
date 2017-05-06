//
//  Data.mm
//  ForeignJump
//
//  Created by Francis Visoiu Mistrih on 14/08/13.
//  Copyright (c) 2013 Epimac. All rights reserved.
//
#import "Data.h"
#import "InGame.h"

const int capacity = 2;

static int score;

static float distance;

static BOOL dead;

static BOOL win;

static NSMutableArray *toDestroyArray;

static BOOL firstTime;

static float timeBegin = [[NSDate date] timeIntervalSince1970];

static int bonus;

@implementation Data

+ (void)resetData {
    score = 0;

    distance = 0;
    
    dead = NO;
    
    win = NO;
    
    [toDestroyArray release];
    
    timeBegin = 0;
    
    bonus = 0;
}

#pragma mark - Score
+ (int) getScore {
    return (int)score;
}

+ (void) setScore:(int)score_ {
    score = score_;
}

+ (void) addScore:(int)score_ {
    score += score_;
}

+ (void) scorePlusPlus {
    [self addScore:1];
}

#pragma mark - Distance
+ (int) getDistance {
    return distance;
}

+ (void) setDistance:(int)distance_ {
    distance = distance_;
}

+ (void) addDistance:(int)distance_ {
    distance += distance_;
}

+ (void) distancePlusPlus {
    [self addDistance:1];
}

#pragma mark - Dead
+ (BOOL) isDead {
    return dead;
}

+ (void) setDead:(BOOL)dead_ {
    dead = dead_;
}


#pragma mark - Win
+ (BOOL) didWin {
    return win;
}

+ (void) setWin:(BOOL)win_ {
    win = win_;
}


#pragma mark - Array to destroy
+ (id) initDestroyArray {
    toDestroyArray = [[NSMutableArray alloc] initWithCapacity:capacity];
    return toDestroyArray;
}

+ (NSMutableArray *) getToDestroyArray {
    return toDestroyArray;
}

+ (void) destroyAllBodies {
    
    b2World *world = [InGame getWorld];
    
    for (NSValue *bodyValue in toDestroyArray)
    {
        b2Body *body;
        body = (b2Body*)[bodyValue pointerValue];
        world->DestroyBody(body);
        body = NULL;
    }
    
    [toDestroyArray removeAllObjects];
}

+ (void) addBodyToDestroy:(b2Body *)body {
    id userData = (id)body->GetUserData();
    CCSprite *dataSprite = (CCSprite *)userData;
    
    //setting the user data to 999999 so that it doesn't add into the array again
    if (dataSprite.tag != 999999) {
        dataSprite.tag = 999999;
        body->SetUserData(dataSprite);
        [toDestroyArray addObject:[NSValue valueWithPointer:body]];
    }
}

+ (BOOL) isDestroyArrayEmpty {
    return [toDestroyArray count] == 0;
}

+ (BOOL) isDestroyArrayFull {
    return [toDestroyArray count] >= capacity;
}

#pragma mark - FirstTime
+ (BOOL) isNotFirstTime {
    return !firstTime;
}

+ (void) setNotFirstTime:(BOOL)state {
    firstTime = !state;
}

+ (float) timeEleapsed {
    return [[NSDate date] timeIntervalSince1970] - timeBegin;
}

+ (int)randomIntBetween:(int)minValue and:(int)maxValue {
    return (int)(minValue + arc4random_uniform(maxValue + 1 - minValue));
}

+ (int) getBonus {
    return bonus;
}

+ (void) setBonus:(int)number {
    bonus = number;
}


@end
