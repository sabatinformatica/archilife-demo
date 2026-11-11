CREATE DATABASE IF NOT EXISTS archilife_central CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE archilife_central;

CREATE TABLE IF NOT EXISTS branches (
  id CHAR(36) PRIMARY KEY,
  code VARCHAR(30) NOT NULL UNIQUE,
  name VARCHAR(120) NOT NULL,
  active BOOLEAN NOT NULL DEFAULT TRUE,
  last_seen_at DATETIME(3) NULL,
  created_at DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3)
);

CREATE TABLE IF NOT EXISTS products (
  id CHAR(36) PRIMARY KEY,
  sku VARCHAR(60) NOT NULL UNIQUE,
  barcode VARCHAR(80) NULL,
  name VARCHAR(180) NOT NULL,
  category VARCHAR(100) NULL,
  price DECIMAL(12,2) NOT NULL,
  active BOOLEAN NOT NULL DEFAULT TRUE,
  version BIGINT NOT NULL DEFAULT 1,
  updated_at DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3)
);

CREATE TABLE IF NOT EXISTS sync_inbox (
  event_id CHAR(36) PRIMARY KEY,
  branch_id CHAR(36) NOT NULL,
  event_type VARCHAR(80) NOT NULL,
  entity_id CHAR(36) NOT NULL,
  payload JSON NOT NULL,
  occurred_at DATETIME(3) NOT NULL,
  received_at DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  INDEX idx_inbox_branch_received (branch_id, received_at)
);

CREATE TABLE IF NOT EXISTS sales (
  id CHAR(36) PRIMARY KEY,
  branch_id CHAR(36) NOT NULL,
  sale_number VARCHAR(40) NOT NULL,
  customer_id CHAR(36) NULL,
  subtotal DECIMAL(12,2) NOT NULL,
  total DECIMAL(12,2) NOT NULL,
  payment_method VARCHAR(40) NOT NULL,
  sold_at DATETIME(3) NOT NULL,
  UNIQUE KEY uq_branch_sale (branch_id, sale_number),
  INDEX idx_sales_sold_at (sold_at)
);
