/*
Please review the dataset schema provided on the 'data1' sheet.
 The sheet contains an extract from SQL table.
  Please create a SQL query that presents retention values for 
  each application on each hardware_platform and for each day, 
  but as an average value of 3 days preceding each given day.
Desired final schema is:
 date, application, hardware_platform, retention_day_1_3days_avg,
  retention_day_3_3days_avg, retention_day_7_3days_avg
*/
use sales;
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
