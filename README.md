Smart Farm Crop Health Monitor – PL/SQL Project

A PL/SQL-based smart agriculture system designed to help farmers monitor crop conditions, detect environmental risks, and receive automated alerts for unhealthy situations (e.g., high temperature, low humidity, or pest detection).

This project combines database design, automation logic, and real-world problem-solving using Oracle SQL & PL/SQL.

 Project Initiation

The Smart Farm Crop Health Monitor was developed as part of an academic practicum in Oracle PL/SQL, focusing on innovation and real-world database solutions.
The project aims to demonstrate how PL/SQL can automate data analysis and assist in sustainable farming through intelligent alerts and reports.

It is ideal for students, researchers, or agricultural data developers interested in smart farming and database automation.

 Instructor Information

Assistant Lecturer – Adventist University of Central Africa (AUCA)
Eric Maniraguha

LinkedIn

GitHub (Primary)

GitHub (Secondary)

Research Associate – CyLab Africa / Upanzi Network

Instructor – Adventist University of Central Africa (AUCA)

Master of Science in Information Technology – Carnegie Mellon University Africa

 Project Outline
1. Introduction

Agriculture faces challenges such as climate changes, pest attacks, and unpredictable weather patterns. The Smart Farm Crop Health Monitor helps farmers make informed decisions by tracking daily temperature, humidity, and pest data for each crop.
When conditions become risky, the system automatically creates alerts and stores them for review.

2. Objectives

To automate monitoring of environmental data for crops.

To detect abnormal temperature or humidity levels using PL/SQL.

To generate alerts and reports for farmers.

To demonstrate the use of procedures, functions, and conditional logic in Oracle PL/SQL.

3. Database Schema
CROPS Table
Column	Type	Description
crop_id	NUMBER	Unique crop ID
crop_name	VARCHAR2(50)	Name of the crop
farm_zone	VARCHAR2(30)	Location/zone in the farm
ideal_temp	NUMBER	Recommended temperature
ideal_humidity	NUMBER	Recommended humidity
DAILY_READINGS Table
Column	Type	Description
reading_id	NUMBER	Unique reading ID
crop_id	NUMBER	References crop_id in CROPS
temperature	NUMBER	Recorded temperature
humidity	NUMBER	Recorded humidity
pest_detected	VARCHAR2(3)	YES or NO
reading_date	DATE	Date of data record
ALERTS Table
Column	Type	Description
alert_id	NUMBER	Unique alert ID
crop_id	NUMBER	References crop_id
alert_message	VARCHAR2(200)	Problem description
alert_date	DATE	Alert creation date
4. PL/SQL Components

Procedures and Functions:

check_crop_health

Analyzes daily readings.

Compares them with the crop’s ideal values.

Inserts an alert when conditions are unsafe or pests are detected.

generate_summary_report

Produces a report of crops with alerts.

delete_old_alerts (optional)

Cleans up old alerts to keep data current.

5. Innovation & Uniqueness

Unlike ordinary record-keeping systems, this project introduces automated data evaluation.
Using PL/SQL, it simulates real-world smart farming features like:

Automatic problem detection.

Real-time alert generation.

Scalable database design ready for IoT integration.

This demonstrates how PL/SQL logic can be applied to agriculture intelligence and environmental monitoring.

6. Expected Output

Store and analyze environmental readings.

Automatically identify and log abnormal conditions.

Generate a readable summary of alerts and healthy crops.

Provide a solid example of database-driven automation using Oracle PL/SQL.

 Technology Stack

Database: Oracle 21c / 19c

Language: PL/SQL (Procedures, Functions, Cursors)

Tools: Oracle SQL Developer

Version Control (optional): GitHub

 Learning Outcomes

Students will learn how to:

Design relational tables with constraints and foreign keys.

Implement decision logic using IF…THEN and loops in PL/SQL.

Automate data-driven processes and generate reports.

Apply database programming in real-world agriculture systems.

 License — MIT
MIT License

Copyright (c) 2025

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the “Software”), to deal
in the Software without restriction, including without limitation the rights   
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell      
copies of the Software, and to permit persons to whom the Software is          
furnished to do so, subject to the following conditions:                       

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.                                

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR      
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,        
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE    
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER         
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,   
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE  
SOFTWARE.
