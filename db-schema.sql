CREATE TABLE watchlist (
  type_id INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  status TEXT NOT NULL DEFAULT 'active',      -- active | retired
  source TEXT NOT NULL DEFAULT 'manual',      -- manual | ai
  added_at TIMESTAMPTZ DEFAULT NOW(),
  locked_until TIMESTAMPTZ,
  retired_at TIMESTAMPTZ
);

CREATE TABLE candidate_pool (
  type_id INTEGER PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE TABLE price_snapshots (
  id BIGSERIAL PRIMARY KEY,
  ts TIMESTAMPTZ DEFAULT NOW(),
  type_id INTEGER NOT NULL,
  region_id INTEGER NOT NULL,
  best_sell NUMERIC, best_buy NUMERIC,
  sell_volume BIGINT, buy_volume BIGINT
);
CREATE INDEX idx_snap ON price_snapshots (type_id, region_id, ts);

CREATE TABLE daily_history (
  type_id INTEGER NOT NULL,
  region_id INTEGER NOT NULL,
  date DATE NOT NULL,
  average NUMERIC, volume BIGINT, order_count INTEGER,
  PRIMARY KEY (type_id, region_id, date)
);

CREATE TABLE opportunities (
  id BIGSERIAL PRIMARY KEY,
  ts TIMESTAMPTZ DEFAULT NOW(),
  type_id INTEGER, item_name TEXT, route TEXT,
  net_margin_pct NUMERIC, total_profit NUMERIC,
  buy_price NUMERIC, sell_price NUMERIC,
  buy_location BIGINT, sell_location BIGINT, units BIGINT,
  notified BOOLEAN DEFAULT false
);

CREATE TABLE watchlist_changes (
  id BIGSERIAL PRIMARY KEY,
  ts TIMESTAMPTZ DEFAULT NOW(),
  action TEXT, type_id INTEGER, reason TEXT
);

INSERT INTO watchlist (type_id, name) VALUES
  (587, 'Rifter'),
  (596, 'Impairor'),
  (28668, 'Nanite Repair Paste'),
  (40519, 'Skill Extractor');
