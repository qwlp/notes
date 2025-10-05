### 1\. Company $\text{SUBMITS}$ Application $\text{(1-to-Many)}$

This relationship links the $\text{Company}$ table to the $\text{Application}$ table, with $\text{Company}$'s $\text{Name}$ being the foreign key in $\text{Application}$.


```sql
-- Add the foreign key in Application referencing Company

ALTER TABLE Application
ADD COLUMN Company_Name VARCHAR(255),
ADD CONSTRAINT fk_application_company
    FOREIGN KEY (Company_Name)
    REFERENCES Company(Name)
    ON DELETE CASCADE  -- If a Company is deleted, its Applications are deleted
    ON UPDATE CASCADE; -- If a Company's Name changes, it updates in Application

```

-----

### 2\. Application $\text{IS\_FOR}$ Funder $\text{(Many-to-1)}$


This relationship links the $\text{Application}$ table to the $\text{Funder}$ table, with $\text{Funder}$'s $\text{Name}$ being the foreign key in $\text{Application}$.


```sql
-- Add the foreign key in Application referencing Funder
ALTER TABLE Application
ADD COLUMN Funder_Name VARCHAR(255),

ADD CONSTRAINT fk_application_funder
    FOREIGN KEY (Funder_Name)
    REFERENCES Funder(Name)
    ON DELETE RESTRICT  -- Prevent deleting a Funder if there are Applications for them
    ON UPDATE CASCADE;
```

-----

### 3\. Company $\text{RECEIVES\_FUNDING\_FROM}$ Funder $\text{(Many-to-Many)}$

A many-to-many relationship requires a new **junction table** (or associative entity). Let's call it $\text{Company\_Funder}$.


#### Step 3a: Create the Junction Table

```sql
CREATE TABLE Company_Funder (
    Company_Name VARCHAR(255) NOT NULL,
    Funder_Name VARCHAR(255) NOT NULL,
    PRIMARY KEY (Company_Name, Funder_Name)
);
```

#### Step 3b: Add Foreign Keys to the Junction Table


```sql
-- Add the foreign key referencing Company
ALTER TABLE Company_Funder
ADD CONSTRAINT fk_cf_company
    FOREIGN KEY (Company_Name)
    REFERENCES Company(Name)

    ON DELETE CASCADE -- If Company is deleted, its funding record is deleted
    ON UPDATE CASCADE;

-- Add the foreign key referencing Funder
ALTER TABLE Company_Funder
ADD CONSTRAINT fk_cf_funder
    FOREIGN KEY (Funder_Name)

    REFERENCES Funder(Name)
    ON DELETE CASCADE -- If Funder is deleted, its funding record is deleted
    ON UPDATE CASCADE;
```

-----


### 4\. Company $\text{TARGETS}$ MarketBuyer $\text{(Many-to-Many)}$


This many-to-many relationship also requires a **junction table**. Let's call it $\text{Company\_MarketBuyer}$.

#### Step 4a: Create the Junction Table

```sql
CREATE TABLE Company_MarketBuyer (
    Company_Name VARCHAR(255) NOT NULL,
    MarketBuyer_ID INT NOT NULL, -- Assuming BuyerID is an INT
    PRIMARY KEY (Company_Name, MarketBuyer_ID)
);
```

#### Step 4b: Add Foreign Keys to the Junction Table

```sql
-- Add the foreign key referencing Company
ALTER TABLE Company_MarketBuyer
ADD CONSTRAINT fk_cmb_company
    FOREIGN KEY (Company_Name)
    REFERENCES Company(Name)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

-- Add the foreign key referencing MarketBuyer
ALTER TABLE Company_MarketBuyer
ADD CONSTRAINT fk_cmb_marketbuyer
    FOREIGN KEY (MarketBuyer_ID)

    REFERENCES MarketBuyer(BuyerID)
    ON DELETE CASCADE
    ON UPDATE CASCADE;
```

*(**Note**: I assumed $\text{MarketBuyer\_ID}$ is an $\text{INT}$ based on typical ID naming conventions. Adjust the data type if it's different in your $\text{MarketBuyer}$ table.)*

-----

### 5\. SystemUser $\text{PLAYS}$ EmployeeRole $\text{(Many-to-1)}$

This relationship links the $\text{SystemUser}$ table to the $\text{EmployeeRole}$ table, with $\text{EmployeeRole}$'s $\text{Role\_Name}$ being the foreign key in $\text{SystemUser}$.


```sql
-- Add the foreign key in SystemUser referencing EmployeeRole
ALTER TABLE SystemUser
ADD COLUMN Role_Name VARCHAR(255),
ADD CONSTRAINT fk_systemuser_role

    FOREIGN KEY (Role_Name)
    REFERENCES EmployeeRole(Role_Name)
    ON DELETE SET NULL -- If a Role is deleted, SystemUsers in that role become NULL
    ON UPDATE CASCADE;
```

-----

### 6\. SystemUser $\text{MANAGES}$ Company $\text{(Many-to-Many)}$


This many-to-many relationship requires a **junction table**. Let's call it $\text{SystemUser\_Company}$.


#### Step 6a: Create the Junction Table

```sql
CREATE TABLE SystemUser_Company (
    Employee_ID INT NOT NULL, -- Assuming Employee_ID is an INT
    Company_Name VARCHAR(255) NOT NULL,

    PRIMARY KEY (Employee_ID, Company_Name)
);
```


#### Step 6b: Add Foreign Keys to the Junction Table

```sql
-- Add the foreign key referencing SystemUser
ALTER TABLE SystemUser_Company

ADD CONSTRAINT fk_suc_systemuser
    FOREIGN KEY (Employee_ID)
    REFERENCES SystemUser(Employee_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

-- Add the foreign key referencing Company
ALTER TABLE SystemUser_Company
ADD CONSTRAINT fk_suc_company
    FOREIGN KEY (Company_Name)
    REFERENCES Company(Name)
    ON DELETE CASCADE

    ON UPDATE CASCADE;

```

