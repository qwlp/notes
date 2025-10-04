-- Synaptic Model (Incubator Model) Database Schema
-- MySQL Database Schema


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

);

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
);

-- Create MarketBuyer table
CREATE TABLE MarketBuyer (
    BuyerID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(255) NOT NULL,
    Industry VARCHAR(100),

    Type_of_Company VARCHAR(100),
    Requirements TEXT,
    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Updated_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


-- Create EmployeeRole table
CREATE TABLE EmployeeRole (
    Role_Name VARCHAR(100) PRIMARY KEY,
    Description TEXT,
    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Updated_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Create SystemUser table
CREATE TABLE SystemUser (
    Employee_ID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(255) NOT NULL,
    Contact VARCHAR(255),

    Role_Name VARCHAR(100),
    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Updated_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (Role_Name) REFERENCES EmployeeRole(Role_Name) ON DELETE SET NULL ON UPDATE CASCADE
);


-- Create Application table

CREATE TABLE Application (
    Application_ID INT PRIMARY KEY AUTO_INCREMENT,
    Company_Name VARCHAR(255) NOT NULL,
    Funder_Name VARCHAR(255) NOT NULL,
    Date_Submitted DATE,
    Status VARCHAR(50) DEFAULT 'Pending',
    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Updated_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (Company_Name) REFERENCES Company(Name) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Funder_Name) REFERENCES Funder(Name) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Create Company_Funder junction table

CREATE TABLE Company_Funder (
    Company_Name VARCHAR(255),
    Funder_Name VARCHAR(255),

    Funding_Amount DECIMAL(15, 2),
    Funding_Date DATE,
    Notes TEXT,

    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Updated_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (Company_Name, Funder_Name),
    FOREIGN KEY (Company_Name) REFERENCES Company(Name) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Funder_Name) REFERENCES Funder(Name) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Create Company_MarketBuyer junction table

CREATE TABLE Company_MarketBuyer (
    Company_Name VARCHAR(255),
    BuyerID INT,
    Target_Date DATE,
    Status VARCHAR(50) DEFAULT 'Active',
    Notes TEXT,
    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    Updated_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (Company_Name, BuyerID),
    FOREIGN KEY (Company_Name) REFERENCES Company(Name) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (BuyerID) REFERENCES MarketBuyer(BuyerID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Create SystemUser_Company junction table

CREATE TABLE SystemUser_Company (
    Employee_ID INT,
    Company_Name VARCHAR(255),
    Assignment_Date DATE,
    Role_In_Management VARCHAR(100),
    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Updated_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (Employee_ID, Company_Name),
    FOREIGN KEY (Employee_ID) REFERENCES SystemUser(Employee_ID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Company_Name) REFERENCES Company(Name) ON DELETE CASCADE ON UPDATE CASCADE
);

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
