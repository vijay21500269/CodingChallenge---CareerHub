CREATE DATABASE CareerHub;
USE CareerHub;

DROP TABLE IF EXISTS Applications;
DROP TABLE IF EXISTS Applicants;
DROP TABLE IF EXISTS Jobs;
DROP TABLE IF EXISTS Companies;

CREATE TABLE Companies (
    CompanyID INT PRIMARY KEY AUTO_INCREMENT,
    CompanyName VARCHAR(255) NOT NULL,
    Location VARCHAR(255) NOT NULL
);

CREATE TABLE Jobs (
    JobID INT PRIMARY KEY AUTO_INCREMENT,
    CompanyID INT NOT NULL,
    JobTitle VARCHAR(255) NOT NULL,
    JobDescription TEXT NOT NULL,
    JobLocation VARCHAR(255) NOT NULL,
    Salary DECIMAL(10,2) NOT NULL,
    JobType ENUM('Full-time', 'Part-time', 'Contract') NOT NULL,
    PostedDate DATE NOT NULL,
    FOREIGN KEY (CompanyID) REFERENCES Companies(CompanyID) ON DELETE CASCADE
);

CREATE TABLE Applicants (
    ApplicantID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    Email VARCHAR(255) UNIQUE NOT NULL,
    Phone VARCHAR(20) UNIQUE NOT NULL,
    ApplicantResume TEXT NOT NULL
);

CREATE TABLE Applications (
    ApplicationID INT PRIMARY KEY AUTO_INCREMENT,
    JobID INT NOT NULL,
    ApplicantID INT NOT NULL,
    ApplicationDate DATE NOT NULL,
    CoverLetter TEXT NOT NULL,
    FOREIGN KEY (JobID) REFERENCES Jobs(JobID) ON DELETE CASCADE,
    FOREIGN KEY (ApplicantID) REFERENCES Applicants(ApplicantID) ON DELETE CASCADE
);

INSERT INTO Companies (CompanyName, Location) VALUES
('Tata Consultancy Services', 'Mumbai, India'),
('Google', 'Mountain View, USA'),
('Infosys', 'Bangalore, India'),
('Amazon', 'Seattle, USA'),
('HCL Technologies', 'Noida, India'),
('Microsoft', 'Redmond, USA'),
('Accenture', 'Dublin, Ireland'),
('Capgemini', 'Paris, France'),
('Wipro', 'Hyderabad, India'),
('IBM', 'New York, USA');

INSERT INTO Jobs (CompanyID, JobTitle, JobDescription, JobLocation, Salary, JobType, PostedDate) VALUES
(1, 'Software Engineer', 'Develop web applications', 'Mumbai, India', 1200000.00, 'Full-time', '2024-11-10'),
(2, 'Data Scientist', 'Analyze large datasets', 'Mountain View, USA', 150000.00, 'Full-time', '2024-12-05'),
(3, 'System Analyst', 'Optimize IT systems', 'Bangalore, India', 1000000.00, 'Full-time', '2024-12-20'),
(4, 'Cloud Architect', 'Design cloud solutions', 'Seattle, USA', 170000.00, 'Full-time', '2025-01-08'),
(5, 'Cybersecurity Specialist', 'Ensure system security', 'Noida, India', 1100000.00, 'Full-time', '2025-01-25'),
(6, 'AI Researcher', 'Develop AI models', 'Redmond, USA', 180000.00, 'Full-time', '2025-02-15'),
(7, 'Consultant', 'Advise clients on strategies', 'Dublin, Ireland', 95000.00, 'Full-time', '2025-02-28'),
(8, 'DevOps Engineer', 'Automate deployments', 'Paris, France', 130000.00, 'Full-time', '2025-03-05'),
(9, 'Full Stack Developer', 'Build web solutions', 'Hyderabad, India', 1150000.00, 'Full-time', '2025-03-10'),
(10, 'Business Analyst', 'Analyze business trends', 'New York, USA', 125000.00, 'Full-time', '2025-03-20');

INSERT INTO Applicants (FirstName, LastName, Email, Phone, ApplicantResume) VALUES
('Ravi', 'Kumar', 'ravi.kumar@email.com', '+91 9876543210', 'Experienced software developer...'),
('John', 'Smith', 'john.smith@email.com', '+1 1234567890', 'Expert in machine learning...'),
('Ayesha', 'Fatima', 'ayesha.fatima@email.com', '+91 8765432109', 'Python backend developer...'),
('Emily', 'Johnson', 'emily.johnson@email.com', '+1 2345678901', 'Cloud engineer with AWS certification...'),
('Vikram', 'Singh', 'vikram.singh@email.com', '+91 7654321098', 'Data scientist with deep learning expertise...'),
('Michael', 'Brown', 'michael.brown@email.com', '+1 3456789012', 'Cybersecurity expert with 5 years of experience...'),
('Sanjana', 'Reddy', 'sanjana.reddy@email.com', '+91 6543210987', 'Web developer proficient in React and Node.js...'),
('Lucas', 'Martinez', 'lucas.martinez@email.com', '+33 4567890123', 'Business consultant with international experience...'),
('Neha', 'Sharma', 'neha.sharma@email.com', '+91 5432109876', 'DevOps engineer skilled in Kubernetes and Docker...'),
('Sophia', 'Williams', 'sophia.williams@email.com', '+1 4567890123', 'Experienced business analyst in fintech domain...');

INSERT INTO Applications (JobID, ApplicantID, ApplicationDate, CoverLetter) VALUES
(1, 1, '2024-11-12', 'I am excited to apply for this software engineer position...'),
(2, 2, '2024-12-07', 'Data science is my passion, and I look forward to contributing...'),
(3, 3, '2024-12-22', 'As a backend developer, I have built scalable applications...'),
(4, 4, '2025-01-10', 'Cloud computing has been my area of expertise for years...'),
(5, 5, '2025-01-27', 'Cybersecurity is critical, and I am eager to help strengthen systems...'),
(6, 6, '2025-02-17', 'With AI advancements, I wish to contribute to cutting-edge research...'),
(7, 7, '2025-03-01', 'Consulting is where my experience in business transformation fits best...'),
(8, 8, '2025-03-07', 'DevOps automation is key to modern software development, and I excel at it...'),
(9, 9, '2025-03-12', 'As a full-stack developer, I specialize in user-friendly applications...'),
(10, 10, '2025-03-22', 'I am excited to bring my analytical skills to your business strategy team...');

SELECT j.JobTitle, COUNT(a.ApplicationID) AS ApplicationCount
FROM Jobs j
LEFT JOIN Applications a ON j.JobID = a.JobID
GROUP BY j.JobID, j.JobTitle; -- 5

SELECT j.JobTitle, c.CompanyName, j.JobLocation, j.Salary
FROM Jobs j
JOIN Companies c ON j.CompanyID = c.CompanyID
WHERE j.Salary BETWEEN '95000.00' AND '130000.00';-- 6

SELECT j.JobTitle, c.CompanyName, a.ApplicationDate
FROM Applications a
JOIN Jobs j ON a.JobID = j.JobID
JOIN Companies c ON j.CompanyID = c.CompanyID
WHERE a.ApplicantID = 3;-- 7

SELECT AVG(Salary) AS AverageSalary
FROM Jobs
WHERE Salary > 0;-- 8

SELECT c.CompanyName, COUNT(j.JobID) AS JobCount
FROM Companies c
JOIN Jobs j ON c.CompanyID = j.CompanyID
GROUP BY c.CompanyID, c.CompanyName
HAVING COUNT(j.JobID) = (
    SELECT MAX(JobCount)
    FROM (SELECT COUNT(JobID) AS JobCount FROM Jobs GROUP BY CompanyID) AS JobCounts
);-- 9

ALTER TABLE Applicants ADD COLUMN ExperienceYears INT NOT NULL DEFAULT 0;
SET SQL_SAFE_UPDATES = 0;

UPDATE Applicants 
SET ExperienceYears = CASE 
    WHEN ApplicantID = 1 THEN 5
    WHEN ApplicantID = 2 THEN 2
    WHEN ApplicantID = 3 THEN 4
    WHEN ApplicantID = 4 THEN 1
    WHEN ApplicantID = 5 THEN 6
    WHEN ApplicantID = 6 THEN 3
    WHEN ApplicantID = 7 THEN 7
    WHEN ApplicantID = 8 THEN 2
    WHEN ApplicantID = 9 THEN 5
    WHEN ApplicantID = 10 THEN 8
END;


select * from Applicants;

SELECT a.FirstName, a.LastName, c.CompanyName, c.Location, a.ExperienceYears
FROM Applications app
JOIN Jobs j ON app.JobID = j.JobID
JOIN Companies c ON j.CompanyID = c.CompanyID
JOIN Applicants a ON app.ApplicantID = a.ApplicantID
WHERE c.Location IN ('Mumbai, India', 'Mountain View, USA', 'Bangalore, India', 
                     'Seattle, USA', 'Noida, India', 'Redmond, USA', 
                     'Dublin, Ireland', 'Paris, France', 'Hyderabad, India', 'New York, USA') 
AND a.ExperienceYears > 3;-- 10

SELECT DISTINCT JobTitle
FROM Jobs
WHERE Salary BETWEEN 60000 AND 800000;-- 11

SELECT j.JobTitle
FROM Jobs j
LEFT JOIN Applications a ON j.JobID = a.JobID
WHERE a.ApplicationID IS NULL;-- 12

SELECT a.FirstName, a.LastName, c.CompanyName, j.JobTitle
FROM Applications app
JOIN Applicants a ON app.ApplicantID = a.ApplicantID
JOIN Jobs j ON app.JobID = j.JobID
JOIN Companies c ON j.CompanyID = c.CompanyID;-- 13

SELECT c.CompanyName, COUNT(j.JobID) AS JobCount
FROM Companies c
LEFT JOIN Jobs j ON c.CompanyID = j.CompanyID
GROUP BY c.CompanyID, c.CompanyName; -- 14

SELECT a.FirstName, a.LastName, COALESCE(c.CompanyName, 'No Applications') AS Company, 
       COALESCE(j.JobTitle, 'No Applications') AS JobTitle
FROM Applicants a
LEFT JOIN Applications app ON a.ApplicantID = app.ApplicantID
LEFT JOIN Jobs j ON app.JobID = j.JobID
LEFT JOIN Companies c ON j.CompanyID = c.CompanyID; -- 15

SELECT DISTINCT c.CompanyName
FROM Companies c
JOIN Jobs j ON c.CompanyID = j.CompanyID
WHERE j.Salary > (SELECT AVG(Salary) FROM Jobs WHERE Salary > 0); -- 16

SELECT FirstName, LastName, CONCAT(Address, ', ', State) AS FullAddress
FROM Applicants; -- 17

SELECT a.FirstName, a.LastName, CONCAT(c.Location) AS FullAddress
FROM Applicants a
JOIN Applications app ON a.ApplicantID = app.ApplicantID
JOIN Jobs j ON app.JobID = j.JobID
JOIN Companies c ON j.CompanyID = c.CompanyID; -- 17

SELECT JobTitle
FROM Jobs
WHERE JobTitle LIKE 'Full Stack Developer' OR JobTitle LIKE 'Software Engineer'; -- 18

SELECT a.FirstName, a.LastName, COALESCE(j.JobTitle, 'No Job Applied') AS JobTitle
FROM Applicants a
LEFT JOIN Applications app ON a.ApplicantID = app.ApplicantID
LEFT JOIN Jobs j ON app.JobID = j.JobID; -- 19

SELECT a.FirstName, a.LastName, c.CompanyName, c.Location
FROM Applicants a
CROSS JOIN Companies c
WHERE c.Location IN ('Hyderabad, India') 
AND a.ExperienceYears > 2;-- 20

