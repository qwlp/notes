Chapter 1: Database Systems
2025-09-21

# Why Databases?

* Data is everywhere, we always generate data, we can't escape from it, everywhere we go we will see data.
* Data is essential for organizations to survive. (Try to operate a business without knowing who your customers are)

# Data versus Information

* Data consists of raw facts (raw means that the facts has not yet been processed to reveal their meaning)
* Information is the result of processing raw data to reveal its meaning. (It can be simple but also can be very complex)
* Information requires context. (Temperature of 105 degrees does not mean anything, is it in Celsius or is it in Fahrenheit)
* Knowledge is the body of information and facts about a specific subject.

* Data management is the discipline that focuses on the proper generation, storage, and retrieval of data.

# Introducing the Database

* A **database**  is a shared, integrated computer structure that stores a collection of the following:
  - End-user data —  raw facts of interest to the end user.
  - Metadata —  data about data (sometimes you hear a database described as a collection of self-describing data, data about data characteristics and relationship)

## Role and Advantages of the DMBS

* A database management system (DBMS) is a collection of programs that manages the database structure and controls the access to the data stored in the database.

* User -> DBMS -> Database
* The DMBS abstracts much of the database's internal complexity from the application programs and users. (The program might be written in some other language or a utility program of the DMBS.)
* Advantages of a DBMS:
  - Improved data sharing, security and integration.
  - Minimized data inconsistency (It exists when different versions of the same data appear in different places. Example: When a company's sales department has a sales representative named Bill Brown and the company's personnel department has a person's named William G. Brown, or when different branches of the companies sell a product at different prices.)
  - Improved data access through querying (a question or task asked by the end-user). A query is a question, an ad hoc query is a "spur-of-the-moment" question, the DBMS sends back a query result set
  - Better decision making
  - Increased end-user productivity.

## Types of Databases

* A DBMS can be used to build many types of databases including: based on number of users/data stored:
  - Single-user database —  supports only one user at a time.(Desktop Database —  if ran on a PC)
  - Multiuser database —  database that supports multiple concurrent users.
  - Workgroup database —  a multiuser database that supports less than 50 users, usually used for a specific department of an organization
  - Enterprise database (more than 50 users, usually hundreds) —  The overall company data representation, which provides support for present and expected future needs
* Based on location:
  - Centralized database —  if the database is located at a single site
  - Distributed database —  a logically related database that is stored in two or more physically independent sites.
  - Cloud database —  a database that is created and maintained using cloud services, such as Azure or AWS.
* Based on the type of data stored:
  - General-purpose database —  contains a wide variety of data used in multiple disciplines. (A census database)
  - Discipline-specific database —  focuses on a specific subject area (CompuStat, CRSP, GIS)
* The most popular way though is based on how they will be used and on the time sensitivity of the information gathered:
  - Operational database (aka. Online Transaction Processing (OLTP), Transactional database, production database) —  a database designed primarily to support a company's day-to-day operations. (sales, payment, customers...)
  - Analytical database —  focuses on storing historical data and business metrics used for tactical and strategic decision making. (pricing decisions, sales forecasts, market strategies). It usually consists of two main components:
    + Data warehouse —  a specialized database that stored historical and aggregated data in a format optimized for decision making. It usually consists of two main components:
    + Online Analytical Processing (OLAP): set of tools that provide advanced data analysis for retrieving, processing, and modeling data from the data warehouse
    + This has evolved into its own discipline called business intelligence —  a set of tools and processes used to capture, collect, integrate, store and analyze data to support business decision making.
* Based on how the data is structured:
  - Unstructured data —  data that exists in its original form - that is in the format in which it was collected
  - Structured data —  data that has been formatted to facilitate storage, use and information generation
  - Semistructured data —  data that has already been processed to some extent.
    
  




