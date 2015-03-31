//
//  ViewController.m
//  Superheropedia
//
//  Created by Ben Bueltmann on 3/17/15.
//  Copyright (c) 2015 Mobile Makers. All rights reserved.
//

#import "ViewController.h"
#import "Superhero.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic) NSArray *tableDataArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [Superhero retreiveSuperheroesWithCompletion:^(NSArray *heroes) {
        self.tableDataArray = heroes;
        [self.tableView reloadData];
    }];
   
}

//- (void)setTableDataArray:(NSArray *)tableDataArray {
//    _tableDataArray = tableDataArray;
//    [self.tableView reloadData];
//}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableDataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SuperheroesID"];
    Superhero *superhero = [self.tableDataArray objectAtIndex:indexPath.row];
    [superhero getImageDataWithCompletion:^(NSData *imageData, NSError *error) {
        cell.imageView.image = [UIImage imageWithData:imageData];
        [cell layoutSubviews];
    }];
    cell.textLabel.text = superhero.name;
    cell.detailTextLabel.text = superhero.itemDescription;
//    cell.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];

    return cell;
}



@end
