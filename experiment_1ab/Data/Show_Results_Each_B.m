clear all;

for i = 1:4
    [fn_list, names] = get_fn_list_B(i);
    fprintf('\nObserver: %s\n',names{i});
    correct_by_condition = Calc_And_Show_Results(fn_list);
end