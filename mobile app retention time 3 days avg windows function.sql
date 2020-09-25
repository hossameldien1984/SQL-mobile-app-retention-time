select  STR_TO_DATE(data1.date, '%m/%d/%y') data_date,
    data1.application,
    data1.hardware_platform,
    avg(data1.retention_day_1) over (partition by data1.application,data1.hardware_platform
    order by STR_TO_DATE(data1.date, '%m/%d/%y')
	rows  between 3 preceding and 1 preceding) ret_avg_day1,
    avg(data1.retention_day_3) over (partition by data1.application,data1.hardware_platform
    order by STR_TO_DATE(data1.date, '%m/%d/%y')
	rows  between 3 preceding and 1 preceding) ret_avg_day3,
    avg(data1.retention_day_7) over (partition by data1.application,data1.hardware_platform
    order by STR_TO_DATE(data1.date, '%m/%d/%y')
	rows  between 3 preceding and 1 preceding) ret_avg_day7
    from data1
    ORDER BY data1.application , data1.hardware_platform , STR_TO_DATE(data1.date, '%m/%d/%y');