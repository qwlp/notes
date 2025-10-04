-- Create database
CREATE DATABASE IF NOT EXISTS synaptic_incubator;
USE synaptic_incubator;

-- Company table
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
    Ambitions TEXT
);

-- Funder table
CREATE TABLE Funder (
    Name VARCHAR(255) PRIMARY KEY,
    Sector VARCHAR(100),
    Industry VARCHAR(100),
    Nature VARCHAR(100),
    Type_of_Company VARCHAR(100),
    Type_of_Venture VARCHAR(100)
);

-- MarketBuyer table
CREATE TABLE MarketBuyer (
    BuyerID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Industry VARCHAR(100),
    Type_of_Company VARCHAR(100),
    Requirements TEXT
);

-- EmployeeRole table
CREATE TABLE EmployeeRole (
    Role_Name VARCHAR(100) PRIMARY KEY,
    Description TEXT
);

-- SystemUser table
CREATE TABLE SystemUser (
    Employee_ID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Contact VARCHAR(255),
    Role_Name VARCHAR(100),
    FOREIGN KEY (Role_Name) REFERENCES EmployeeRole(Role_Name)
        ON UPDATE CASCADE
        ON DELETE SET NULL
);

-- Application table
CREATE TABLE Application (
    Application_ID INT AUTO_INCREMENT PRIMARY KEY,
    Company_Name VARCHAR(255) NOT NULL,
    Funder_Name VARCHAR(255) NOT NULL,
    Date_Submitted DATE,
    Status VARCHAR(50),
    FOREIGN KEY (Company_Name) REFERENCES Company(Name)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (Funder_Name) REFERENCES Funder(Name)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- Company_Funder junction table (many-to-many: RECEIVES_FUNDING_FROM)
CREATE TABLE Company_Funder (
    Company_Name VARCHAR(255),
    Funder_Name VARCHAR(255),
    Funding_Amount DECIMAL(15, 2),
    Funding_Date DATE,
    PRIMARY KEY (Company_Name, Funder_Name),
    FOREIGN KEY (Company_Name) REFERENCES Company(Name)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (Funder_Name) REFERENCES Funder(Name)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- Company_MarketBuyer junction table (many-to-many: TARGETS)
CREATE TABLE Company_MarketBuyer (
    Company_Name VARCHAR(255),
    BuyerID INT,
    Target_Date DATE,
    Status VARCHAR(50),
    PRIMARY KEY (Company_Name, BuyerID),
    FOREIGN KEY (Company_Name) REFERENCES Company(Name)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (BuyerID) REFERENCES MarketBuyer(BuyerID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- SystemUser_Company junction table (many-to-many: MANAGES)
CREATE TABLE SystemUser_Company (
    Employee_ID INT,
    Company_Name VARCHAR(255),
    Assignment_Date DATE,
    Role_in_Management VARCHAR(100),
    PRIMARY KEY (Employee_ID, Company_Name),
    FOREIGN KEY (Employee_ID) REFERENCES SystemUser(Employee_ID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (Company_Name) REFERENCES Company(Name)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- Create indexes for better query performance
CREATE INDEX idx_application_status ON Application(Status);
CREATE INDEX idx_application_date ON Application(Date_Submitted);
CREATE INDEX idx_company_sector ON Company(Sector);
CREATE INDEX idx_company_stage ON Company(Stage);
CREATE INDEX idx_funder_sector ON Funder(Sector);
