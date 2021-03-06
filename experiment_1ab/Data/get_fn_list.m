function [fn_list, ob_names] = get_fn_list(ob)
    ob_names = {'BS', 'UB', 'SL','AM', 'PC', 'RM','Group'};
    ob_ids = {'BS1', 'UB1', 'SL1','AM1', 'PC1', 'RM1','Group'};
    
    data_log_fn = sprintf('Data/%s.log', ob_ids{ob});
    data_log_fid = fopen(data_log_fn, 'r');
    if data_log_fid ~= -1
        %fn_list = textscan(data_log_fid, '%s', data_log_fid);
        fn_list = textscan(data_log_fid, '%s', 100, 'CollectOutput', 1);
        fn_list = fn_list{1,1};
    else
        error('Unable to open data log file %s',data_log_fn);
    end
    fclose(data_log_fid);
end