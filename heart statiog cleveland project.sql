use hospital_db;
create database  hospital_db;
 select * from heart_statlog_database;
 

                                           # visualization heart patient
                                           
	select count(*) from heart_statlog_database; 
    
    #1.What is the average age of the patients in the dataset?
    
    SELECT AVG(age) AS average_age
FROM heart_statlog_database;

     #2 How does the prevalence of heart disease differ between males and females?
     
     SELECT 
    sex,
    COUNT(*) AS total,
    SUM(target) AS heart_disease_count,
    (SUM(target) * 100.0 / COUNT(*)) AS prevalence_percentage
FROM 
    heart_statlog_database
GROUP BY 
    sex;

#3.Is there a significant correlation between age and cholesterol levels?

SELECT 
    (SUM(age * cholesterol) - SUM(age) * SUM(cholesterol) / COUNT(*)) / 
    SQRT((SUM(age * age) - SUM(age) * SUM(age) / COUNT(*)) * 
         (SUM(cholesterol * cholesterol) - SUM(cholesterol) * SUM(cholesterol) / COUNT(*))) AS correlation_coefficient
FROM 
    heart_statlog_database;
    
    # 4 What is the distribution of chest pain types among the patients?
    
    SELECT 
    chest_paint_type,
    COUNT(*) AS count
FROM 
    heart_statlog_database
GROUP BY 
    chest_paint_type
ORDER BY 
    count DESC;
 
 # 5 How does resting blood pressure vary across different age groups?
 SELECT 
    age,
    AVG(resting_ecg) AS average_resting_bp
FROM 
    heart_statlog_database
GROUP BY 
    age
ORDER BY 
    age;
    
    #6 What percentage of patients have fasting blood sugar levels greater than 120 mg/dl?
SELECT 
    (SUM(CASE WHEN fasting_blood_sugar > 120 THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) AS percentage
FROM 
    heart_statlog_database;
    
    #7What is the most common resting ECG result in the dataset?
    
    SELECT resting_ecg, COUNT(*) AS count
FROM heart_statlog_database
GROUP BY resting_ecg
ORDER BY count DESC
LIMIT 1;

# 8 How does maximum heart rate achieved during exercise correlate with age? 
SELECT 
    (SUM(age * max_heart_rate) - SUM(age) * SUM(max_heart_rate) / COUNT(*)) / 
    SQRT((SUM(age * age) - SUM(age) * SUM(age) / COUNT(*)) * 
         (SUM(max_heart_rate * max_heart_rate) - SUM(max_heart_rate) * SUM(max_heart_rate) / COUNT(*))) AS correlation_coefficient
FROM 
    heart_statlog_database;
    
    #9 What is the average oldpeak value among patients with and without heart disease?
SELECT 
    target,
    AVG(oldpeak) AS average_oldpeak
FROM 
    heart_statlog_database
GROUP BY 
    target;
 #10 Is there a relationship between ST slope and the presence of heart disease?
 
 SELECT st_slope, target,
    COUNT(*) AS count
FROM 
    heart_statlog_database
GROUP BY 
    st_slope, target
ORDER BY 
    st_slope, target;
#11What are the most common symptoms (chest pain type) among patients with heart disease?

SELECT 
   chest_paint_type ,
    COUNT(*) AS count
FROM 
    heart_statlog_database
WHERE 
    target = 1
GROUP BY chest_paint_type
ORDER BY 
    count DESC;
    
    #12 How does the presence of exercise-induced angina affect the target outcome?
  
  SELECT exercise_angina, target,
    COUNT(*) AS count FROM heart_statlog_database
GROUP BY exercise_angina, target
ORDER BY exercise_angina, target;


#13How does the resting blood pressure compare between patients with and without heart disease?

SELECT target, AVG(resting_bps) AS average_resting_bp
FROM heart_statlog_database
GROUP BY target;
 
 #14What is the distribution of cholesterol levels in the dataset?
 
 SELECT cholesterol, COUNT(*) AS frequency
FROM heart_statlog_database
GROUP BY cholesterol
ORDER BY cholesterol;

 #15 Are there significant differences in the maximum heart rate achieved by gender?
 
 SELECT sex ,AVG(max_heart_rate) AS avg_max_heart_rate,
    MIN(max_heart_rate) AS min_max_heart_rate,
    MAX(max_heart_rate) AS max_max_heart_rate,
    COUNT(*) AS num_participants
From  heart_statlog_database
GROUP BY sex;

# 16 How often do patients with heart disease have an abnormal resting ECG?

SELECT 
    COUNT(*) AS total_patients,
    SUM(CASE WHEN max_heart_rate = 'heart_disease_condition' THEN 1 ELSE 0 END) AS heart_disease_patients,
    SUM(CASE WHEN resting_ecg = 'abnormal' THEN 1 ELSE 0 END) AS abnormal_ecg_patients
FROM heart_statlog_database
WHERE max_heart_rate = 'heart_disease_condition';

#17What is the average age of patients with exercise-induced angina?

SELECT AVG(age) AS average_age
FROM heart_statlog_database
WHERE exercise_angina = 'yes';

#18What is the relationship between oldpeak and ST slope?

SELECT 
    ST_slope,
    AVG(oldpeak) AS average_oldpeak
FROM heart_statlog_database
GROUP By
    ST_slope;

#19 How does fasting blood sugar correlate with cholesterol levels? 

SELECT fasting_blood_sugar, cholesterol
FROM heart_statlog_database;

#20How does age impact the likelihood of having heart disease?
with hcount as(
SELECT 
    age,
    COUNT(*) AS total_patients,
    SUM(CASE WHEN max_heart_rate = 'diagnosed' THEN 1 ELSE 0 END) AS heart_disease_patients,
    CAST(SUM(CASE WHEN max_heart_rate= 'diagnosed' THEN 1 ELSE 0 END) AS FLOAT) / COUNT(*) AS likelihood
FROM  heart_statlog_database
GROUP BY 
    age
ORDER BY age)
select age, total_patients from hcount
where total_patients>30
order by total_patients desc ;

#21 Is there a significant difference in resting blood pressure between patients with different chest pain types?

SELECT 
  chest_paint_type ,
    AVG(resting_bps) AS average_resting_bp
FROM 
    heart_statlog_database
GROUP By chest_paint_type;
#22What percentage of patients have an ST slope of upsloping, flat, and downsloping?

SELECT 
    ST_slope,
    COUNT(*) * 100.0 / (SELECT COUNT(*) FROM heart_statlog_database) AS percentage
FROM 
    heart_statlog_database
GROUP BY 
    ST_slope;

#23How does the maximum heart rate achieved during exercise impact the likelihood of heart disease?

SELECT 
    target,
    AVG(max_heart_rate) AS average_max_heart_rate
FROM 
    heart_statlog_database
GROUP BY 
    target;

#24What is the distribution of target outcomes in the dataset?
SELECT 
    target,
    COUNT(*) AS count
FROM 
    heart_statlog_database
GROUP BY 
    target;
#25 How does cholesterol level vary among different chest pain types?
SELECT 
 chest_paint_type ,
    AVG(cholesterol) AS average_cholesterol
FROM 
    heart_statlog_database
GROUP BY chest_paint_type;

#26What is the average resting blood pressure among patients with different ST slopes?
SELECT 
 ST_slope,
    AVG(resting_bps) AS average_resting_bp
FROM 
    heart_statlog_database
GROUP BY 
    ST_slope;
#27How does age correlate with the presence of exercise-induced angina?
SELECT 
exercise_angina,
    AVG(age) AS average_age
FROM 
    heart_statlog_database
GROUP BY exercise_angina;

#28What is the distribution of oldpeak values among patients?
SELECT oldpeak,
    COUNT(*) AS count
FROM 
    heart_statlog_database
GROUP BY oldpeak
ORDER BY 
    oldpeak;

#29Are patients with higher fasting blood sugar more likely to have heart disease?
SELECT 
    fasting_blood_sugar > 120 AS high_fasting_blood_sugar,
    COUNT(*) AS total_patients,
    SUM(CASE WHEN target = 1 THEN 1 ELSE 0 END) AS patients_with_heart_disease,
    SUM(CASE WHEN target = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS percentage_with_heart_disease
FROM 
    heart_statlog_database
GROUP BY 
    fasting_blood_sugar;

#30What is the average maximum heart rate achieved by patients in different age groups and how does it vary by sex?


SELECT 
    CASE 
        WHEN age < 30 THEN 'Under 30'
        WHEN age BETWEEN 30 AND 39 THEN '30-39'
        WHEN age BETWEEN 40 AND 49 THEN '40-49'
        WHEN age BETWEEN 50 AND 59 THEN '50-59'
        WHEN age BETWEEN 60 AND 69 THEN '60-69'
        ELSE '70 and above'
    END AS age_group,
    sex,
    AVG(max_heart_rate) AS average_max_heart_rate
FROM heart_statlog_database
    GROUP BY 
    age, sex
ORDER BY 
    age, sex;
