//
//  EntryController.m
//  TimeTracker(simple)
//
//  Created by Ethan Hess on 5/15/15.
//  Copyright (c) 2015 Ethan Hess. All rights reserved.
//

#import "EntryController.h"
#import "Entry.h"

@implementation EntryController

+ (EntryController *)sharedInstance {
    static EntryController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [EntryController new];
    });
    
    return sharedInstance;
    
}

- (NSArray *)entries {
    
    NSFetchRequest *fetchReuquest = [NSFetchRequest fetchRequestWithEntityName:@"Entry"];
    
    NSArray *objects = [[Stack sharedInstance].managedObjectContext executeFetchRequest:fetchReuquest error:NULL];
    
    return objects;
}

- (void)addEntryWithTitle:(NSString *)title startTime:(NSDate *)startTime endTime:(NSDate *)endTime {
    
    Entry *entry = [NSEntityDescription insertNewObjectForEntityForName:@"Entry" inManagedObjectContext:[Stack sharedInstance].managedObjectContext];
    
    entry.title = title;
    entry.startTime = startTime;
    entry.endTime = endTime;
    
    [self save];
    
}

- (void)removeEntry:(Entry *)entry {
    
    [entry.managedObjectContext deleteObject:entry];
    
    [self save]; 
    
}

- (void)save {
    
    [[Stack sharedInstance].managedObjectContext save:NULL];
    
}

@end
