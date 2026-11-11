CREATE DATABASE IF NOT EXISTS archilife_branch CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE archilife_branch;

CREATE TABLE IF NOT EXISTS app_config (
  config_key VARCHAR(100) PRIMARY KEY,
  config_value TEXT NOT NULL
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
  updated_at DATETIME(3) NOT NULL
);

CREATE TABLE IF NOT EXISTS customers (
  id CHAR(36) PRIMARY KEY,
  document_number VARCHAR(40) NULL,
  name VARCHAR(180) NOT NULL,
  phone VARCHAR(40) NULL,
  email VARCHAR(180) NULL,
  created_at DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3)
);

CREATE TABLE IF NOT EXISTS sales (
  id CHAR(36) PRIMARY KEY,
  sale_number VARCHAR(40) NOT NULL UNIQUE,
  customer_id CHAR(36) NULL,
  subtotal DECIMAL(12,2) NOT NULL,
  total DECIMAL(12,2) NOT NULL,
  payment_method VARCHAR(40) NOT NULL,
  status VARCHAR(30) NOT NULL DEFAULT 'COMPLETED',
  sold_at DATETIME(3) NOT NULL,
  sync_status VARCHAR(20) NOT NULL DEFAULT 'PENDING'
);

CREATE TABLE IF NOT EXISTS sale_items (
  id CHAR(36) PRIMARY KEY,
  sale_id CHAR(36) NOT NULL,
  product_id CHAR(36) NOT NULL,
  product_name VARCHAR(180) NOT NULL,
  quantity DECIMAL(12,3) NOT NULL,
  unit_price DECIMAL(12,2) NOT NULL,
  line_total DECIMAL(12,2) NOT NULL,
  INDEX idx_sale_items_sale (sale_id)
);

CREATE TABLE IF NOT EXISTS stock_movements (
  id CHAR(36) PRIMARY KEY,
  product_id CHAR(36) NOT NULL,
  movement_type VARCHAR(30) NOT NULL,
  quantity DECIMAL(12,3) NOT NULL,
  reference_id CHAR(36) NOT NULL,
  occurred_at DATETIME(3) NOT NULL,
  INDEX idx_stock_product_date (product_id, occurred_at)
);

CREATE TABLE IF NOT EXISTS sync_outbox (
  event_id CHAR(36) PRIMARY KEY,
  event_type VARCHAR(80) NOT NULL,
  entity_id CHAR(36) NOT NULL,
  payload JSON NOT NULL,
  occurred_at DATETIME(3) NOT NULL,
  status VARCHAR(20) NOT NULL DEFAULT 'PENDING',
  attempts INT NOT NULL DEFAULT 0,
  last_error TEXT NULL,
  next_attempt_at DATETIME(3) NULL,
  INDEX idx_outbox_pending (status, next_attempt_at)
);

CREATE TABLE IF NOT EXISTS sync_checkpoints (
  source_name VARCHAR(80) PRIMARY KEY,
  last_cursor VARCHAR(100) NULL,
  updated_at DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3)
);
