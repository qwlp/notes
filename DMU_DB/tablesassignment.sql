-- Users Management Database Schema

-- Create group table
CREATE TABLE `group` (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(1000)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Create userAccount table
CREATE TABLE userAccount (
    id INT AUTO_INCREMENT PRIMARY KEY,
    hashedPassword VARCHAR(100) NOT NULL,
    firstName VARCHAR(100) NOT NULL,
    lastName VARCHAR(100) NOT NULL,
    email VARCHAR(254) NOT NULL UNIQUE,
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    groupId INT NOT NULL,
    userRoleId INT NOT NULL,
    INDEX idx_groupId (groupId),
    INDEX idx_userRoleId (userRoleId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Create userRole table
CREATE TABLE userRole (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(1000)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Create permission table
CREATE TABLE permission (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Create rolePermission junction table (many-to-many relationship)
CREATE TABLE rolePermission (
    id INT AUTO_INCREMENT PRIMARY KEY,
    permissionId INT NOT NULL,
    userRoleId INT NOT NULL,
    UNIQUE KEY unique_role_permission (userRoleId, permissionId),
    INDEX idx_permissionId (permissionId),
    INDEX idx_userRoleId (userRoleId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Add foreign key constraints
ALTER TABLE userAccount
    ADD CONSTRAINT fk_userAccount_group 
    FOREIGN KEY (groupId) REFERENCES `group`(id) 
    ON DELETE RESTRICT ON UPDATE CASCADE,
    ADD CONSTRAINT fk_userAccount_userRole 
    FOREIGN KEY (userRoleId) REFERENCES userRole(id) 
    ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE rolePermission
    ADD CONSTRAINT fk_rolePermission_permission 
    FOREIGN KEY (permissionId) REFERENCES permission(id) 
    ON DELETE CASCADE ON UPDATE CASCADE,
    ADD CONSTRAINT fk_rolePermission_userRole 
    FOREIGN KEY (userRoleId) REFERENCES userRole(id) 
    ON DELETE CASCADE ON UPDATE CASCADE;
