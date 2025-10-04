-- Synaptic Model (Incubator Model) Database Schema
-- MySQL Database Schema
-- Character Set: UTF-8

-- Create database if not exists
-- CREATE DATABASE IF NOT EXISTS synaptic_incubator CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
-- USE synaptic_incubator;

-- Drop tables if they exist (in reverse order of dependencies)
DROP TABLE IF EXISTS SystemUser_Company;
DROP TABLE IF EXISTS Company_MarketBuyer;

DROP TABLE IF EXISTS Company_Funder;
DROP TABLE IF EXISTS Application;
DROP TABLE IF EXISTS SystemUser;
DROP TABLE IF EXISTS EmployeeRole;
DROP TABLE IF EXISTS MarketBuyer;
DROP TABLE IF EXISTS Funder;
DROP TABLE IF EXISTS Company;

-- Create Company table

CREATE TABLE Company (
    Name VARCHAR(255) PRIMARY KEY,
    Sector VARCHAR(100),
    Technical_Description TEXT,
    Stage VARCHAR(50),

    Actual_Capacity_of_Production VARCHAR(100),
    Cost DECIMAL(15, 2),
    Length_of_Company INT,
    Money_Requested DECIMAL(15, 2),
    Level_of_Growth VARCHAR(50),
    Ambitions TEXT,
    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Updated_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create Funder table
CREATE TABLE Funder (
    Name VARCHAR(255) PRIMARY KEY,
    Sector VARCHAR(100),
    Industry VARCHAR(100),
    Nature VARCHAR(100),
    Type_of_Company VARCHAR(100),
    Type_of_Venture VARCHAR(100),
    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Updated_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create MarketBuyer table

CREATE TABLE MarketBuyer (
    BuyerID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(255) NOT NULL,
    Industry VARCHAR(100),
    Type_of_Company VARCHAR(100),
    Requirements TEXT,

    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Updated_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create EmployeeRole table
CREATE TABLE EmployeeRole (

    Role_Name VARCHAR(100) PRIMARY KEY,

    Description TEXT,
    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Updated_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create SystemUser table
CREATE TABLE SystemUser (
    Employee_ID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(255) NOT NULL,
    Contact VARCHAR(255),
    Role_Name VARCHAR(100),
    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Updated_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (Role_Name) REFERENCES EmployeeRole(Role_Name) 

        ON DELETE SET NULL 
        ON UPDATE CASCADE

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create Application table
CREATE TABLE Application (
    Application_ID INT PRIMARY KEY AUTO_INCREMENT,

    Company_Name VARCHAR(255) NOT NULL,
    Funder_Name VARCHAR(255) NOT NULL,
    Date_Submitted DATE,
    Status VARCHAR(50) DEFAULT 'Pending',
    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Updated_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (Company_Name) REFERENCES Company(Name) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    FOREIGN KEY (Funder_Name) REFERENCES Funder(Name) 

        ON DELETE CASCADE 
        ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create Company_Funder junction table (many-to-many: RECEIVES_FUNDING_FROM)
CREATE TABLE Company_Funder (
    Company_Name VARCHAR(255),
    Funder_Name VARCHAR(255),
    Funding_Amount DECIMAL(15, 2),
    Funding_Date DATE,
    Notes TEXT,
    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Updated_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (Company_Name, Funder_Name),
    FOREIGN KEY (Company_Name) REFERENCES Company(Name) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    FOREIGN KEY (Funder_Name) REFERENCES Funder(Name) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create Company_MarketBuyer junction table (many-to-many: TARGETS)
CREATE TABLE Company_MarketBuyer (
    Company_Name VARCHAR(255),
    BuyerID INT,
    Target_Date DATE,
    Status VARCHAR(50) DEFAULT 'Active',
    Notes TEXT,
    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Updated_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (Company_Name, BuyerID),

    FOREIGN KEY (Company_Name) REFERENCES Company(Name) 

        ON DELETE CASCADE 
        ON UPDATE CASCADE,

    FOREIGN KEY (BuyerID) REFERENCES MarketBuyer(BuyerID) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create SystemUser_Company junction table (many-to-many: MANAGES)
CREATE TABLE SystemUser_Company (
    Employee_ID INT,
    Company_Name VARCHAR(255),
    Assignment_Date DATE DEFAULT (CURRENT_DATE),
    Role_In_Management VARCHAR(100),
    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    Updated_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (Employee_ID, Company_Name),
    FOREIGN KEY (Employee_ID) REFERENCES SystemUser(Employee_ID) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    FOREIGN KEY (Company_Name) REFERENCES Company(Name) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- Create indexes for better query performance
CREATE INDEX idx_application_company ON Application(Company_Name);
CREATE INDEX idx_application_funder ON Application(Funder_Name);
CREATE INDEX idx_application_status ON Application(Status);
CREATE INDEX idx_application_date ON Application(Date_Submitted);
CREATE INDEX idx_company_sector ON Company(Sector);
CREATE INDEX idx_company_stage ON Company(Stage);
CREATE INDEX idx_funder_sector ON Funder(Sector);
CREATE INDEX idx_funder_industry ON Funder(Industry);

CREATE INDEX idx_marketbuyer_industry ON MarketBuyer(Industry);
CREATE INDEX idx_systemuser_role ON SystemUser(Role_Name);
CREATE INDEX idx_company_funder_date ON Company_Funder(Funding_Date);
CREATE INDEX idx_company_marketbuyer_status ON Company_MarketBuyer(Status);

-- Add table comments (MySQL specific)
ALTER TABLE Company COMMENT = 'Stores information about companies in the incubator program';
ALTER TABLE Funder COMMENT = 'Stores information about funding organizations and investors';
ALTER TABLE Application COMMENT = 'Tracks funding applications from companies to funders';
ALTER TABLE MarketBuyer COMMENT = 'Stores potential market buyers and customer information';

ALTER TABLE EmployeeRole COMMENT = 'Defines employee roles within the incubator system';
ALTER TABLE SystemUser COMMENT = 'System users/employees who manage the incubator operations';
ALTER TABLE Company_Funder COMMENT = 'Tracks funding relationships between companies and funders';
ALTER TABLE Company_MarketBuyer COMMENT = 'Tracks which companies target which market buyers';
ALTER TABLE SystemUser_Company COMMENT = 'Tracks which employees manage which companies';
