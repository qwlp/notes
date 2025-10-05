## 1\. One-to-Many Relationships


| Relationship | Tables Involved | Constraint Logic |
| :--- | :--- | :--- |
| **Company SUBMITS Application** | `Application` references `Company` | **ON DELETE CASCADE** (Delete company, delete applications) |
| **Application IS\_FOR Funder** | `Application` references `Funder` | **ON DELETE RESTRICT** (Prevents deleting a funder with pending applications) |
| **SystemUser PLAYS EmployeeRole** | `SystemUser` references `EmployeeRole` | **ON DELETE SET NULL** (If a role is deleted, users' role ID is set to null) |

```sql
-- Company SUBMITS Application (1:N)
ALTER TABLE Application
ADD COLUMN Company_Name VARCHAR(255),
ADD CONSTRAINT fk_application_company
    FOREIGN KEY (Company_Name)
    REFERENCES Company(Name)

    ON DELETE CASCADE
    ON UPDATE CASCADE;

-- Application IS_FOR Funder (N:1)
ALTER TABLE Application

ADD COLUMN Funder_Name VARCHAR(255),
ADD CONSTRAINT fk_application_funder
    FOREIGN KEY (Funder_Name)
    REFERENCES Funder(Name)
    ON DELETE RESTRICT
    ON UPDATE CASCADE;

-- SystemUser PLAYS EmployeeRole (N:1)
ALTER TABLE SystemUser
ADD COLUMN Role_Name VARCHAR(255),
ADD CONSTRAINT fk_systemuser_role
    FOREIGN KEY (Role_Name)
    REFERENCES EmployeeRole(Role_Name)

    ON DELETE SET NULL

    ON UPDATE CASCADE;
```

-----

## 2\. Many-to-Many Relationships


These relationships require the creation of an **associative (junction) table** to link the two primary entities.

### A. Company RECEIVES\_FUNDING\_FROM Funder

Creates the `Company_Funder` table.

```sql
-- Step 1: Create the junction table
CREATE TABLE Company_Funder (
    Company_Name VARCHAR(255) NOT NULL,

    Funder_Name VARCHAR(255) NOT NULL,
    PRIMARY KEY (Company_Name, Funder_Name)
);

-- Step 2: Add foreign key referencing Company
ALTER TABLE Company_Funder
ADD CONSTRAINT fk_cf_company
    FOREIGN KEY (Company_Name)
    REFERENCES Company(Name)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

-- Step 3: Add foreign key referencing Funder
ALTER TABLE Company_Funder
ADD CONSTRAINT fk_cf_funder
    FOREIGN KEY (Funder_Name)
    REFERENCES Funder(Name)
    ON DELETE CASCADE
    ON UPDATE CASCADE;
```

-----

### B. Company TARGETS MarketBuyer


Creates the `Company_MarketBuyer` table. (Assuming `MarketBuyer.BuyerID` is an `INT`).

```sql
-- Step 1: Create the junction table
CREATE TABLE Company_MarketBuyer (
    Company_Name VARCHAR(255) NOT NULL,
    MarketBuyer_ID INT NOT NULL,
    PRIMARY KEY (Company_Name, MarketBuyer_ID)

);

-- Step 2: Add foreign key referencing Company
ALTER TABLE Company_MarketBuyer
ADD CONSTRAINT fk_cmb_company
    FOREIGN KEY (Company_Name)
    REFERENCES Company(Name)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

-- Step 3: Add foreign key referencing MarketBuyer
ALTER TABLE Company_MarketBuyer
ADD CONSTRAINT fk_cmb_marketbuyer
    FOREIGN KEY (MarketBuyer_ID)
    REFERENCES MarketBuyer(BuyerID)
    ON DELETE CASCADE
    ON UPDATE CASCADE;
```

-----

### C. SystemUser MANAGES Company

Creates the `SystemUser_Company` table. (Assuming `SystemUser.Employee_ID` is an `INT`).


```sql
-- Step 1: Create the junction table
CREATE TABLE SystemUser_Company (
    Employee_ID INT NOT NULL,

    Company_Name VARCHAR(255) NOT NULL,
    PRIMARY KEY (Employee_ID, Company_Name)
);

-- Step 2: Add foreign key referencing SystemUser

ALTER TABLE SystemUser_Company
ADD CONSTRAINT fk_suc_systemuser
    FOREIGN KEY (Employee_ID)
    REFERENCES SystemUser(Employee_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

-- Step 3: Add foreign key referencing Company
ALTER TABLE SystemUser_Company
ADD CONSTRAINT fk_suc_company
    FOREIGN KEY (Company_Name)
    REFERENCES Company(Name)
    ON DELETE CASCADE
    ON UPDATE CASCADE;
```
