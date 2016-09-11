function [fn_list, ob_names] = get_fn_list_B(ob)
    ob_names = {'AS', 'BS', 'UB', 'AL','Group'};
    ob_ids = {'AMS1', 'BS1B', 'UB1B', 'AL1','Group'};
    
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