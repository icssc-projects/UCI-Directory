//
//  ViewController.m
//  UCI Directory
//
//  Created by 夏目夏樹 on 11/6/15.
//
//

#import "AFNetworking.h"
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [searchBar becomeFirstResponder];
    [self searchBar:searchBar textDidChange:@""];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    currentSearchTest = searchText;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url = [[NSString stringWithFormat:@"http://127.0.0.1:1337/complete.json?query=%@", searchText] stringByAddingPercentEncodingWithAllowedCharacters:
                     [NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        if ([[responseObject objectForKey:@"query"] isEqualToString:currentSearchTest]) {
            typeaheadData = (NSArray *)[responseObject objectForKey:@"data"];
            [searchResultsTableView reloadData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        typeaheadData = @[];
        [searchResultsTableView reloadData];
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [[typeaheadData objectAtIndex:indexPath.row] objectForKey:@"displayName"];
    cell.detailTextLabel.text = [[typeaheadData objectAtIndex:indexPath.row] objectForKey:@"uid"];
    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [typeaheadData count];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailedViewController *detailedViewController = [[DetailedViewController alloc] initWithDetail:[typeaheadData objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:detailedViewController animated:YES];
}

@end
