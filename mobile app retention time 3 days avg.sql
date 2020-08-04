
SELECT 
    da11.date,
    da11.application,
    da11.hardware_platform,
    AVG(da12.retention_day_1) retention_day_1_3days_avg,
    AVG(da12.retention_day_3) retention_day_3_3days_avg,
    AVG(da12.retention_day_7) retention_day_7_3days_avg
FROM
    data1 da11
        LEFT JOIN
    data1 da12 ON da11.application = da12.application
        AND da11.hardware_platform = da12.hardware_platform
        AND STR_TO_DATE(da12.date, '%m/%d/%y') < STR_TO_DATE(da11.date, '%m/%d/%y')
        AND STR_TO_DATE(da12.date, '%m/%d/%y') >= STR_TO_DATE(da11.date, '%m/%d/%y') - 3
GROUP BY da11.date , da11.application , da11.hardware_platform
ORDER BY da11.application , da11.hardware_platform , da11.date;
