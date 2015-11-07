//
//  DetailedViewController.m
//  UCI Directory
//
//  Created by 夏目夏樹 on 11/6/15.
//
//

#import "DetailedViewController.h"

@interface DetailedViewController ()

@end

@implementation DetailedViewController

- (id)initWithDetail:(NSDictionary *)theDetail {
    self = [super init];
    if (self) {
        detail = theDetail;

        //self.automaticallyAdjustsScrollViewInsets = NO;
        CGRect rect = [[self view] bounds];
        detailTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height)];
        [detailTableView setDelegate:self];
        [detailTableView setDataSource:self];
        detailTableView.allowsSelection = NO;
        [[self view] addSubview:detailTableView];
        [detailTableView reloadData];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"DetailCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

 
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = [NSString stringWithFormat:@"Name: %@", [detail objectForKey:@"displayName"]];
            break;
        case 1:
            cell.textLabel.text = [NSString stringWithFormat:@"UCInetID: %@", [detail objectForKey:@"uid"]];
            break;
        case 2:
            cell.textLabel.text = [NSString stringWithFormat:@"Level: %@", [detail objectForKey:@"studentLevel"]];
            break;
        case 3:
            cell.textLabel.text = [NSString stringWithFormat:@"Major: %@", [detail objectForKey:@"major"]];
            break;
        case 4:
            cell.textLabel.text = [NSString stringWithFormat:@"Email: %@", [detail objectForKey:@"mail"]];
            break;
        default:
            break;
    }

    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CGRect rect = [[self view] bounds];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, 20)];
    [label setText:@"hi"];
    return label;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

@end
