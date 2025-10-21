-- This sql script creates database and table structure, also insert data into tables.
DROP TABLE IF EXISTS assets;

DROP TABLE IF EXISTS portfolios;

DROP TABLE IF EXISTS positions;

-- Create asset table structure in Data-Base
CREATE TABLE IF NOT EXISTS assets (
    asset_id SMALLINT,
    asset_class VARCHAR(15),
    rating VARCHAR(3),
    volatility NUMERIC(4, 3),
    sector VARCHAR(15),
    CONSTRAINT pk_asset_id PRIMARY KEY (asset_id)
);

-- Insert data in asset table
COPY assets
FROM
    'E:/Data Sets/financial risk/assets.csv' -- path of file
WITH
    (FORMAT CSV, HEADER TRUE, DELIMITER ',');

-- Create portfolio table structure in Data-Base
CREATE TABLE IF NOT EXISTS portfolios (
    portfolio_id SMALLINT,
    portfolio_name CHAR(8),
    manager_name VARCHAR(15),
    inception_date DATE,
    total_value_usd NUMERIC(15, 2),
    exposure_limit NUMERIC(15, 2),
    CONSTRAINT pk_porfolio_id PRIMARY KEY (portfolio_id)
);

-- Insert data in portfolios table
COPY portfolios
FROM
    'E:/Data Sets/financial risk/portfolios.csv' -- path of file
WITH
    (FORMAT CSV, HEADER TRUE, DELIMITER ',');

-- Create positions table structure in Data-Base
CREATE TABLE IF NOT EXISTS positions (
    position_id SMALLINT,
    portfolio_id SMALLINT,
    asset_id SMALLINT,
    region VARCHAR(8),
    exposure_value NUMERIC(15, 2),
    return_rate NUMERIC(5, 2),
    trade_date DATE,
    CONSTRAINT pk_position_id PRIMARY KEY (position_id),
    CONSTRAINT fk_portfolio_id FOREIGN KEY (portfolio_id) REFERENCES portfolios (portfolio_id),
    CONSTRAINT fk_asset_id FOREIGN KEY (asset_id) REFERENCES assets (asset_id)
);

-- Insert data in positions table
COPY positions
FROM
    'E:/Data Sets/financial risk/positions.csv' -- path of file
WITH
    (FORMAT CSV, HEADER TRUE, DELIMITER ',');