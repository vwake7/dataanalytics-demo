--download file from kaggle https://www.kaggle.com/datasets/afranur/web-analytics-dataset 
--load csv file
.MODE CSV
.LOAD "Web Analytic_Dataset.csv" wanalytics
ALTER TABLE wanalytics ADD COLUMN tdate;
