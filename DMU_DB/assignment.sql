-- Insert sample data for Users Management Database

-- Insert groups
INSERT INTO `group` (name, description) VALUES
('Administrators', 'System administrators with full access to all features'),
('Regular Users', 'Standard users with limited permissions'),
('Guest Users', 'Temporary access users with minimal permissions');

-- Insert user roles
INSERT INTO userRole (name, description) VALUES
('Admin', 'Administrator role with full system access'),
('Editor', 'Can create and edit content'),
('Viewer', 'Read-only access to content');

-- Insert permissions
INSERT INTO permission (name) VALUES
('CREATE_USER'),
('EDIT_USER'),
('DELETE_USER'),
('VIEW_USER'),
('CREATE_CONTENT'),
('EDIT_CONTENT'),
('DELETE_CONTENT'),
('VIEW_CONTENT');

-- Insert role permissions (many-to-many relationship)
-- Admin role gets all permissions
INSERT INTO rolePermission (permissionId, userRoleId) VALUES
(1, 1), -- Admin: CREATE_USER
(2, 1), -- Admin: EDIT_USER
(3, 1), -- Admin: DELETE_USER
(4, 1), -- Admin: VIEW_USER
(5, 1), -- Admin: CREATE_CONTENT
(6, 1), -- Admin: EDIT_CONTENT
(7, 1), -- Admin: DELETE_CONTENT
(8, 1); -- Admin: VIEW_CONTENT

-- Editor role gets content permissions
INSERT INTO rolePermission (permissionId, userRoleId) VALUES
(4, 2), -- Editor: VIEW_USER
(5, 2), -- Editor: CREATE_CONTENT
(6, 2), -- Editor: EDIT_CONTENT
(8, 2); -- Editor: VIEW_CONTENT

-- Viewer role gets only view permissions
INSERT INTO rolePermission (permissionId, userRoleId) VALUES
(4, 3), -- Viewer: VIEW_USER
(8, 3); -- Viewer: VIEW_CONTENT

-- Insert user accounts
INSERT INTO userAccount (hashedPassword, firstName, lastName, email, groupId, userRoleId) VALUES
('$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 
 'John', 'Doe', 'john.doe@example.com', 1, 1),
('$2y$10$TKh8H1.PfQx37YgCzwiKb.KjNyWgaHb9cbcoQgdIVFlYg7B77UdFm', 
 'Jane', 'Smith', 'jane.smith@example.com', 1, 1),
('$2y$10$YWpbpRjKbC9S3h0T0rJb7OqzQxYKxX8H5M6NjKmPnF0vV9WxLzF4e', 
 'Bob', 'Johnson', 'bob.johnson@example.com', 2, 2),
('$2y$10$XpQyuZKxF9W3N7TjBvMfReH5K8YnPmJqL2VxCwDsE6FgUhIoA3B2m', 
 'Alice', 'Williams', 'alice.williams@example.com', 2, 2),
('$2y$10$ZxWvYuTsRqPoNmLkJiHgFeGdCbVaXsWqEtRyUiOpAsLkMnBvCxDyZ', 
 'Charlie', 'Brown', 'charlie.brown@example.com', 3, 3),
('$2y$10$AbCdEfGhIjKlMnOpQrStUvWxYzAbCdEfGhIjKlMnOpQrStUvWxYz', 
 'Diana', 'Davis', 'diana.davis@example.com', 3, 3);
