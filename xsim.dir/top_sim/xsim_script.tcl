set_param project.enableReportConfiguration 0
load_feature core
current_fileset
xsim {top_sim} -view {{./waves/tb.wcfg}}
