//
//  ListViewController.m
//  TimeTracker(simple)
//
//  Created by Ethan Hess on 5/15/15.
//  Copyright (c) 2015 Ethan Hess. All rights reserved.
//

#import "ListViewController.h"
#import "EntryController.h"
#import "Entry.h"

@interface ListViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [EntryController sharedInstance].entries.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    
    Entry *entry = [EntryController sharedInstance].entries[indexPath.row];
    
    NSInteger hours = 0;
    NSInteger minutes = 0;
    
    NSTimeInterval timeBetweenDates = [entry.endTime timeIntervalSinceDate:entry.startTime];
    
    double secondsInHour = 3600;
    NSInteger hoursBetweenDates = timeBetweenDates / secondsInHour;
    
    double secondsInMinute = 60;
    NSInteger minutesBetweenDates = (timeBetweenDates - (hoursBetweenDates * secondsInHour) / secondsInMinute);
    
    hours += hoursBetweenDates;
    minutes += minutesBetweenDates;
    
    NSString *hourString = [NSString stringWithFormat:@"%ld", (long)hours];
    NSString *minuteString = [NSString stringWithFormat:@"%ld", (long)minutes];
    
    cell.textLabel.text = entry.title;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - %@", hourString, minuteString];
    
    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [[EntryController sharedInstance]removeEntry:[EntryController sharedInstance].entries[indexPath.row]];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
        
        [tableView reloadData];
        
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
