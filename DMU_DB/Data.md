## 1. Understanding the Business Domain
Synaptic

These questions help you grasp the "big picture" of the client's operations.

Ideas -> Plan 
Money?

* **What is the primary purpose of the system/database we are modeling?** (e.g., Inventory management, customer tracking, order processing.)
- Incubator - fund to help small - medium sizes
- Apps -> Who are doing what? (What the business is? and who is funding it?)
- Also customers
- Who is providing fund?

* **What are the key real-world objects or concepts that the system needs to keep track of?** (These are your potential **Entities**.)
* **Can you walk me through the main process or workflow that this system will support?** (e.g., "A Customer places an Order, which contains multiple Products.")
Client comes -> Research on business (what stage is it in) -> Which sector -> Go to vcs or manufacturers -> Find customers for them and also find manufacturers for them -> Look in the market

* **What are the different roles of the people who will be using this system?** (e.g., Managers, Employees, Customers, Suppliers.)
- CEO - everything
- The person who gets calls from the businesses - gets access to business
- THe person who gets funder - all funding bodies and client
- The person who matches buyer - only get access to companies who have a prototype

---

## 2. Identifying Entities and Attributes

Once the domain is clear, focus on defining the components.

* **For each key object (Entity), what information must we store about it?** (These are your **Attributes**.)
    * *Example: For a "Customer," do we need their name, address, phone number, email, date of birth?*
    + Name of Comapny, Sector, Technical Description of the Business, Stage, Actual Capacity of Production, Cost, Length of Company, How much money, - Capacity, Level of Growth, Ambitions
    + Name, Sector, Industry, Nature, Type of Company, Type of Venture
    + Application for the funding body
    + Market Buyer - customers for the company
* **Is there a unique identifier for this object?** (This will be the **Primary Key**.)
    * *Example: Is it a Customer ID, an Employee ID, or an ISBN for a Book?*
* **Are there any attributes that are composed of several smaller pieces of information?** (This identifies **Composite Attributes**.)
    * *Example: An "Address" is composed of Street, City, State, and Zip Code.*
* **Are there any attributes that can have multiple values?** (This identifies **Multivalued Attributes**.)
    * *Example: Can an "Employee" have multiple Phone Numbers or Skills?*

---

## 3. Defining Relationships and Cardinality

These are the most critical questions for determining how entities connect.

* **How do the different objects (Entities) relate to each other?**
    * *Example: How does a "Student" relate to a "Course"? How does a "Product" relate to an "Order"?*
* **What is the name of the connection between these two objects?** (The **Relationship** name.)
    * *Example: A "Professor" $\rightarrow$ **Teaches** $\rightarrow$ a "Course."*
* **What is the minimum and maximum number of instances of one entity that can be associated with an instance of another entity?** (This determines **Cardinality and Participation**.)
    * **Focus on the two-way relationship:**
        * **A to B:** *Can one **A** have many **B**'s? Or just one? Does an **A** *have* to have a **B**, or is it optional?*
        * **B to A:** *Can one **B** be related to many **A**'s? Or just one? Does a **B** *have* to be related to an **A**, or is it optional?*

---

## 4. Addressing Constraints and Special Cases

These questions uncover deeper structural requirements.

* **Are there any objects that cannot exist without being related to another object?** (This suggests a **Weak Entity Set**.)
    * *Example: Does a "Dependent" of an "Employee" only make sense if the "Employee" exists?*
* **Do any entities have subtypes or different classifications?** (This suggests **Generalization/Specialization**.)
    * *Example: Is an "Employee" sometimes a "Manager" or a "Staff" member, each having unique attributes?*
* **Are there any historical data requirements?**
    * *Example: Do we need to store the prices of products from last year, or just the current price?*

