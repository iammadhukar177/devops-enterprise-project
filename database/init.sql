-- Create database
CREATE DATABASE IF NOT EXISTS enterprise_app;
USE enterprise_app;

-- Create a users table
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role ENUM('admin', 'developer', 'tester', 'manager') DEFAULT 'developer',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create a projects table
CREATE TABLE IF NOT EXISTS projects (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    description TEXT,
    owner_id INT,
    status ENUM('planned', 'in_progress', 'completed') DEFAULT 'planned',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (owner_id) REFERENCES users(id) ON DELETE SET NULL
);

-- Create a tasks table
CREATE TABLE IF NOT EXISTS tasks (
    id INT AUTO_INCREMENT PRIMARY KEY,
    project_id INT NOT NULL,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    assigned_to INT,
    status ENUM('todo', 'in_progress', 'done') DEFAULT 'todo',
    priority ENUM('low', 'medium', 'high') DEFAULT 'medium',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (project_id) REFERENCES projects(id) ON DELETE CASCADE,
    FOREIGN KEY (assigned_to) REFERENCES users(id) ON DELETE SET NULL
);

-- Insert sample users
INSERT INTO users (name, email, password, role) VALUES
('Admin User', 'admin@example.com', 'admin123', 'admin'),
('Madhukar Sammeta', 'madhukar@example.com', 'securepass', 'developer'),
('Test User', 'tester@example.com', 'testpass', 'tester');

-- Insert sample projects
INSERT INTO projects (name, description, owner_id, status) VALUES
('DevOps Pipeline Setup', 'Setting up a CI/CD pipeline using Jenkins & Docker', 1, 'in_progress'),
('Microservice Deployment', 'Deploying Node.js microservices with Kubernetes', 2, 'planned');

-- Insert sample tasks
INSERT INTO tasks (project_id, title, description, assigned_to, status, priority) VALUES
(1, 'Write Jenkinsfile', 'Create declarative pipeline with build, test, deploy stages', 2, 'in_progress', 'high'),
(1, 'Dockerize Backend', 'Write Dockerfile for Node.js service', 2, 'todo', 'medium'),
(2, 'Kubernetes Manifests', 'Write Deployment & Service YAMLs', 3, 'todo', 'high');
