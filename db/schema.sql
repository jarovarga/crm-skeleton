create table address_types (
  type varchar(255) not null primary key,
  title varchar(255) null,
  sorting int default 100 not null
) collate = utf8mb4_unicode_ci;
create index sorting on address_types (sorting);
create table admin_access (
  id int auto_increment primary key,
  resource varchar(255) not null,
  action varchar(255) default '*' not null,
  type enum ('render', 'action', 'handle') null,
  level enum ('read', 'write') null,
  created_at datetime not null,
  updated_at datetime not null,
  constraint resource unique (resource, action)
) collate = utf8mb4_unicode_ci;
create table admin_groups (
  id int auto_increment primary key,
  name varchar(255) not null,
  sorting int default 100 not null,
  created_at datetime not null,
  updated_at datetime not null,
  constraint name unique (name)
) collate = utf8mb4_unicode_ci;
create index sorting on admin_groups (sorting);
create table admin_groups_access (
  id int auto_increment primary key,
  admin_group_id int not null,
  admin_access_id int not null,
  created_at datetime not null,
  constraint admin_group_id unique (admin_group_id, admin_access_id),
  constraint admin_groups_access_ibfk_1 foreign key (admin_group_id) references admin_groups (id),
  constraint admin_groups_access_ibfk_2 foreign key (admin_access_id) references admin_access (id)
) collate = utf8mb4_unicode_ci;
create index admin_access_id on admin_groups_access (admin_access_id);
create table api_access (
  id int auto_increment primary key,
  resource varchar(255) not null,
  created_at timestamp default CURRENT_TIMESTAMP not null,
  updated_at timestamp null,
  constraint resource unique (resource)
) collate = utf8mb4_unicode_ci;
create table api_logs (
  id bigint auto_increment primary key,
  token varchar(255) null,
  path varchar(255) null,
  input mediumtext not null,
  response_code int not null,
  response_time int not null,
  ip varchar(255) null,
  user_agent varchar(2000) null,
  created_at datetime not null
) collate = utf8mb4_unicode_ci row_format = DYNAMIC;
create index created_at on api_logs (created_at);
create index created_at_2 on api_logs (created_at);
create index token on api_logs (token);
create table api_logs_1721754126 (
  id int auto_increment primary key,
  token varchar(255) not null,
  path varchar(255) not null,
  input mediumtext null,
  response_code int not null,
  response_time int not null,
  ip varchar(255) not null,
  user_agent text null,
  created_at datetime not null
) collate = utf8mb4_unicode_ci;
create index created_at on api_logs_1721754126 (created_at);
create index created_at_2 on api_logs_1721754126 (created_at);
create index token on api_logs_1721754126 (token);
create table api_tokens (
  id int auto_increment primary key,
  name varchar(255) not null,
  active tinyint(1) default 1 not null,
  token varchar(255) not null,
  ip_restrictions varchar(255) not null,
  created_at datetime not null,
  updated_at datetime not null,
  constraint token unique (token)
) collate = utf8mb4_unicode_ci;
create table api_access_tokens (
  id int auto_increment primary key,
  api_access_id int not null,
  api_token_id int not null,
  constraint api_access_tokens_ibfk_1 foreign key (api_access_id) references api_access (id),
  constraint api_access_tokens_ibfk_2 foreign key (api_token_id) references api_tokens (id)
) collate = utf8mb4_unicode_ci;
create index api_access_id on api_access_tokens (api_access_id);
create index api_token_id on api_access_tokens (api_token_id);
create table api_token_meta (
  id int auto_increment primary key,
  api_token_id int not null,
  `key` varchar(255) not null,
  value varchar(255) not null,
  created_at datetime not null,
  updated_at datetime not null,
  constraint api_token_id unique (api_token_id, `key`),
  constraint api_token_meta_ibfk_1 foreign key (api_token_id) references api_tokens (id)
) collate = utf8mb4_unicode_ci;
create index value on api_token_meta (value);
create table api_token_stats (
  token_id int not null,
  calls int not null,
  last_call datetime not null,
  constraint token_id unique (token_id),
  constraint api_token_stats_ibfk_1 foreign key (token_id) references api_tokens (id) on delete cascade
) collate = utf8mb4_unicode_ci;
create table cache (
  id int auto_increment primary key,
  `key` varchar(255) not null,
  value text null,
  updated_at datetime not null,
  constraint `key` unique (`key`)
) collate = utf8mb4_unicode_ci;
create table calendar (
  id int auto_increment primary key,
  date date not null,
  year int not null,
  month int not null,
  day int not null,
  quarter int not null,
  week int not null,
  day_name varchar(9) not null,
  month_name varchar(9) not null,
  holiday_flag char not null,
  weekend_flag char not null,
  constraint year unique (year, month, day)
) collate = utf8mb4_unicode_ci;
create index date on calendar (date);
create table config_categories (
  id int auto_increment primary key,
  name varchar(255) not null,
  sorting int default 10 not null,
  icon varchar(255) default 'fa fa-wrench' not null,
  created_at datetime not null,
  updated_at datetime not null
) collate = utf8mb4_unicode_ci;
create index sorting on config_categories (sorting);
create table configs (
  id int auto_increment primary key,
  name varchar(255) not null,
  display_name varchar(255) not null,
  value text null,
  description text null,
  type varchar(255) default 'text' not null,
  options json null,
  config_category_id int not null,
  sorting int default 10 not null,
  autoload tinyint(1) default 1 not null,
  locked tinyint(1) default 0 not null,
  created_at datetime not null,
  updated_at datetime not null,
  has_default_value tinyint(1) not null,
  constraint name unique (name),
  constraint configs_ibfk_1 foreign key (config_category_id) references config_categories (id)
) collate = utf8mb4_unicode_ci;
create index config_category_id on configs (config_category_id);
create index sorting on configs (sorting);
create table content_access (
  id int auto_increment primary key,
  name varchar(255) not null,
  description varchar(255) null,
  class varchar(255) not null,
  sorting int default 100 not null,
  created_at datetime not null,
  updated_at datetime not null,
  constraint name unique (name)
) collate = utf8mb4_unicode_ci;
create index sorting on content_access (sorting);
create table countries (
  id int auto_increment primary key,
  name varchar(255) not null,
  iso_code varchar(255) not null,
  sorting int null,
  constraint iso_code unique (iso_code)
) collate = utf8mb4_unicode_ci;
create index name on countries (name);
create table device_tokens (
  id int auto_increment primary key,
  device_id varchar(255) not null,
  created_at datetime not null,
  last_used_at datetime not null,
  token varchar(255) not null,
  constraint token unique (token)
) collate = utf8mb4_unicode_ci;
create index device_id on device_tokens (device_id);
create table distribution_centers (
  id int auto_increment primary key,
  name varchar(255) not null,
  code varchar(255) not null
) collate = utf8mb4_unicode_ci;
create index code on distribution_centers (code);
create table `groups` (
  id int auto_increment primary key,
  name varchar(255) not null,
  sorting int default 10 not null,
  created_at datetime not null,
  updated_at datetime not null
) collate = utf8mb4_unicode_ci;
create index sorting on `groups` (sorting);
create table hermes_tasks (
  id int auto_increment primary key,
  message_id varchar(255) not null,
  retry int null,
  created_at datetime not null,
  type varchar(255) not null,
  payload mediumtext not null,
  processed_at datetime not null,
  state varchar(255) not null,
  execute_at datetime null
) collate = utf8mb4_unicode_ci;
create index created_at on hermes_tasks (created_at);
create index execute_at on hermes_tasks (processed_at);
create index state on hermes_tasks (state);
create table hermes_tasks_old (
  id varchar(255) not null,
  created_at datetime not null,
  type varchar(255) not null,
  payload text not null,
  processed_at datetime not null,
  state varchar(255) not null,
  constraint id unique (id)
) collate = utf8mb4_unicode_ci;
create index created_at on hermes_tasks_old (created_at);
create index execute_at on hermes_tasks_old (processed_at);
create index state on hermes_tasks_old (state);
create table idempotent_keys (
  id int auto_increment primary key,
  `key` varchar(255) null,
  path varchar(255) null,
  created_at datetime null,
  constraint `key` unique (`key`, path)
) collate = utf8mb4_unicode_ci;
create table invoice_numbers (
  id int auto_increment primary key,
  delivered_at datetime not null,
  number varchar(255) null,
  constraint number unique (number)
) collate = utf8mb4_unicode_ci;
create table invoices (
  id int auto_increment primary key,
  invoice_number_id int not null,
  variable_symbol varchar(255) not null,
  buyer_name varchar(255) null,
  buyer_address varchar(255) null,
  buyer_zip varchar(255) null,
  buyer_city varchar(255) null,
  buyer_country_id int null,
  buyer_id varchar(255) null,
  buyer_tax_id varchar(255) null,
  buyer_vat_id varchar(255) null,
  supplier_name varchar(255) null,
  supplier_address varchar(255) null,
  supplier_zip varchar(255) null,
  supplier_city varchar(255) null,
  supplier_id varchar(255) null,
  supplier_tax_id varchar(255) null,
  supplier_vat_id varchar(255) null,
  created_date datetime not null,
  delivery_date datetime not null,
  payment_date datetime not null,
  updated_date datetime not null,
  constraint invoices_ibfk_1 foreign key (invoice_number_id) references invoice_numbers (id),
  constraint invoices_ibfk_2 foreign key (buyer_country_id) references countries (id)
) collate = utf8mb4_unicode_ci;
create table invoice_items (
  id int auto_increment primary key,
  invoice_id int not null,
  text text null,
  count int not null,
  price decimal(10, 2) not null,
  price_without_vat decimal(10, 2) not null,
  vat int not null,
  currency varchar(255) default 'EUR' not null,
  constraint invoice_items_ibfk_1 foreign key (invoice_id) references invoices (id)
) collate = utf8mb4_unicode_ci;
create index invoice_id on invoice_items (invoice_id);
create index buyer_country_id on invoices (buyer_country_id);
create index invoice_number_id on invoices (invoice_number_id);
create table login_attempts (
  id int auto_increment primary key,
  user_id int null,
  email varchar(255) not null,
  created_at datetime not null,
  status varchar(255) not null,
  source varchar(255) not null,
  ip varchar(255) not null,
  user_agent text not null,
  message varchar(255) null,
  browser varchar(255) null,
  browser_version varchar(255) null,
  os varchar(255) null,
  device varchar(255) null,
  is_mobile tinyint(1) null
) collate = utf8mb4_unicode_ci;
create index created_at on login_attempts (created_at);
create index created_at_2 on login_attempts (created_at, status);
create index ip on login_attempts (ip);
create index source on login_attempts (source);
create index user_id on login_attempts (user_id);
create table magazines (
  id int auto_increment primary key,
  identifier varchar(255) not null,
  name varchar(255) not null,
  created_at datetime not null,
  updated_at datetime not null,
  is_default tinyint(1) default 0 not null,
  constraint identifier unique (identifier)
) collate = utf8mb4_unicode_ci;
create table issues (
  id int auto_increment primary key,
  issued_at datetime not null,
  magazine_id int not null,
  identifier varchar(255) not null,
  is_published tinyint(1) default 1 not null,
  cover varchar(255) null,
  state varchar(255) default 'new' not null,
  name varchar(255) not null,
  error_message varchar(255) null,
  created_at datetime not null,
  updated_at datetime not null,
  checksum varchar(255) null,
  constraint identifier unique (identifier),
  constraint issues_ibfk_1 foreign key (magazine_id) references magazines (id)
) collate = utf8mb4_unicode_ci;
create table issue_pages (
  id int auto_increment primary key,
  identifier varchar(255) not null,
  issue_id int not null,
  page int not null,
  file varchar(255) not null,
  size int unsigned default '0' not null,
  mime varchar(255) not null,
  quality enum ('small', 'large') not null,
  width int not null,
  height int not null,
  orientation enum ('portrait', 'landscape') not null,
  created_at datetime not null,
  updated_at datetime not null,
  constraint identifier unique (identifier),
  constraint issue_id unique (issue_id, page, quality),
  constraint issue_pages_ibfk_1 foreign key (issue_id) references issues (id)
) collate = utf8mb4_unicode_ci;
create table issue_source_files (
  id int auto_increment primary key,
  identifier varchar(255) not null,
  issue_id int not null,
  file varchar(255) not null,
  original_name varchar(255) not null,
  size int unsigned default '0' not null,
  mime varchar(255) not null,
  created_at datetime not null,
  updated_at datetime not null,
  constraint identifier unique (identifier),
  constraint issue_source_files_ibfk_1 foreign key (issue_id) references issues (id)
) collate = utf8mb4_unicode_ci;
create index issue_id on issue_source_files (issue_id);
create index issued_at on issues (issued_at);
create index magazine_id on issues (magazine_id);
create table measurement_annotation (
  id int auto_increment primary key,
  title varchar(255) not null,
  description text null,
  target_date datetime not null,
  created_at datetime not null,
  updated_at datetime not null
) collate = utf8mb4_unicode_ci;
create index target_date on measurement_annotation (target_date);
create table measurements (
  id int auto_increment primary key,
  code varchar(255) null,
  title varchar(255) null,
  description text null,
  created_at datetime not null,
  updated_at datetime not null,
  constraint code unique (code)
) collate = utf8mb4_unicode_ci;
create table measurement_groups (
  id int auto_increment primary key,
  measurement_id int not null,
  title varchar(255) not null,
  created_at datetime not null,
  updated_at datetime not null,
  constraint measurement_id unique (measurement_id, title),
  constraint measurement_groups_ibfk_1 foreign key (measurement_id) references measurements (id) on delete cascade
) collate = utf8mb4_unicode_ci;
create table measurement_values (
  id bigint auto_increment primary key,
  measurement_id int null,
  value decimal(10, 2) not null,
  sorting_day date not null,
  year int null,
  month int null,
  day int null,
  week int null,
  constraint measurement_values_ibfk_1 foreign key (measurement_id) references measurements (id) on delete cascade
) collate = utf8mb4_unicode_ci;
create table measurement_group_values (
  id bigint auto_increment primary key,
  measurement_group_id int not null,
  measurement_value_id bigint not null,
  `key` varchar(255) null,
  value decimal(10, 2) not null,
  constraint measurement_group_id unique (
    measurement_group_id, measurement_value_id,
    `key`
  ),
  constraint measurement_group_values_ibfk_1 foreign key (measurement_value_id) references measurement_values (id) on delete cascade,
  constraint measurement_group_values_ibfk_2 foreign key (measurement_group_id) references measurement_groups (id) on delete cascade
) collate = utf8mb4_unicode_ci;
create index measurement_value_id on measurement_group_values (measurement_value_id);
create index measurement_id on measurement_values (measurement_id, sorting_day);
create table onboarding_goals (
  id int auto_increment primary key,
  code varchar(255) not null,
  name varchar(255) null,
  type varchar(255) null,
  created_at datetime not null,
  updated_at datetime not null,
  constraint code unique (code)
) collate = utf8mb4_unicode_ci;
create table payment_gateways (
  id int auto_increment primary key,
  name varchar(255) not null,
  code varchar(255) not null,
  visible tinyint(1) default 1 not null,
  sorting int default 10 not null,
  created_at datetime not null,
  modified_at datetime not null,
  is_recurrent tinyint(1) default 0 not null,
  constraint code unique (code)
) collate = utf8mb4_unicode_ci;
create table payment_gateway_meta (
  id int auto_increment primary key,
  payment_gateway_id int not null,
  `key` varchar(255) not null,
  value varchar(255) not null,
  constraint payment_gateway_meta_ibfk_1 foreign key (payment_gateway_id) references payment_gateways (id) on update cascade on delete cascade
) collate = utf8mb4_unicode_ci;
create index `key` on payment_gateway_meta (`key`);
create index payment_gateway_id on payment_gateway_meta (payment_gateway_id);
create index sorting on payment_gateways (sorting);
create table phinxlog (
  version bigint not null primary key,
  migration_name varchar(100) null,
  start_time timestamp null,
  end_time timestamp null,
  breakpoint tinyint(1) default 0 not null
) collate = utf8mb4_unicode_ci;
create table postal_fees (
  id int auto_increment primary key,
  code varchar(255) not null,
  title varchar(255) not null,
  amount decimal(10, 2) not null,
  created_at datetime not null,
  updated_at datetime not null
) collate = utf8mb4_unicode_ci;
create table country_postal_fees (
  id int auto_increment primary key,
  country_id int not null,
  postal_fee_id int not null,
  sorting int default 10 not null,
  `default` tinyint(1) default 0 not null,
  active tinyint(1) default 1 null,
  created_at datetime not null,
  updated_at datetime not null,
  constraint country_postal_fees_ibfk_1 foreign key (country_id) references countries (id),
  constraint country_postal_fees_ibfk_2 foreign key (postal_fee_id) references postal_fees (id)
) collate = utf8mb4_unicode_ci;
create table country_postal_fee_conditions (
  id int auto_increment primary key,
  country_postal_fee_id int not null,
  code varchar(255) not null,
  value varchar(255) not null,
  created_at datetime not null,
  constraint country_postal_fee_conditions_ibfk_1 foreign key (country_postal_fee_id) references country_postal_fees (id)
) collate = utf8mb4_unicode_ci;
create index country_postal_fee_id on country_postal_fee_conditions (country_postal_fee_id);
create index country_id on country_postal_fees (country_id);
create index postal_fee_id on country_postal_fees (postal_fee_id);
create table product_templates (
  id int auto_increment primary key,
  name varchar(255) not null
) collate = utf8mb4_unicode_ci;
create table product_template_properties (
  id int auto_increment primary key,
  title varchar(255) not null,
  code varchar(255) not null,
  type varchar(255) null,
  required tinyint(1) default 1 not null,
  `default` tinyint(1) default 0 not null,
  visible tinyint(1) default 1 not null,
  sorting int not null,
  product_template_id int not null,
  hint text null,
  constraint code unique (code, product_template_id),
  constraint product_template_properties_ibfk_1 foreign key (product_template_id) references product_templates (id)
) collate = utf8mb4_unicode_ci;
create index product_template_id on product_template_properties (product_template_id);
create table products (
  id int auto_increment primary key,
  name varchar(255) not null,
  code varchar(255) not null,
  price float not null,
  catalog_price float null,
  vat int not null,
  user_label varchar(255) not null,
  bundle tinyint(1) not null,
  shop tinyint(1) default 0 not null,
  visible tinyint(1) default 0 null,
  sorting int null,
  ean varchar(255) null,
  image_url varchar(255) null,
  og_image_url varchar(255) null,
  images text null,
  product_template_id int null,
  stored tinyint(1) default 0 not null,
  unique_per_user tinyint(1) null,
  has_delivery tinyint(1) null,
  stock int default 0 not null,
  distribution_center varchar(255) null,
  description text null,
  created_at datetime not null,
  modified_at datetime not null,
  available_at datetime null,
  deleted_at datetime null,
  constraint products_ibfk_1 foreign key (product_template_id) references product_templates (id),
  constraint products_ibfk_2 foreign key (distribution_center) references distribution_centers (code) on update cascade
) collate = utf8mb4_unicode_ci;
create table product_bundles (
  id int auto_increment primary key,
  bundle_id int not null,
  item_id int not null,
  constraint product_bundles_ibfk_1 foreign key (bundle_id) references products (id),
  constraint product_bundles_ibfk_2 foreign key (item_id) references products (id)
) collate = utf8mb4_unicode_ci;
create index bundle_id on product_bundles (bundle_id);
create index item_id on product_bundles (item_id);
create table product_properties (
  id int auto_increment primary key,
  value text null,
  product_id int not null,
  product_template_property_id int not null,
  constraint product_id_2 unique (
    product_id, product_template_property_id
  ),
  constraint product_properties_ibfk_1 foreign key (product_id) references products (id),
  constraint product_properties_ibfk_2 foreign key (product_template_property_id) references product_template_properties (id)
) collate = utf8mb4_unicode_ci;
create index product_id on product_properties (product_id);
create index product_template_property_id on product_properties (product_template_property_id);
create index distribution_center on products (distribution_center);
create index product_template_id on products (product_template_id);
create table retention_analysis_jobs (
  id int auto_increment primary key,
  state enum (
    'created', 'started', 'finished',
    'failed'
  ) not null,
  name varchar(255) not null,
  params text not null,
  results longtext null,
  started_at datetime null,
  finished_at datetime null,
  updated_at datetime not null,
  created_at datetime not null
) collate = utf8mb4_unicode_ci;
create table scenarios (
  id int auto_increment primary key,
  name varchar(255) not null,
  visual json null,
  created_at datetime not null,
  modified_at datetime not null,
  deleted_at datetime null,
  restored_at datetime null,
  enabled tinyint(1) not null
) collate = utf8mb4_unicode_ci;
create table scenarios_elements (
  id int auto_increment primary key,
  scenario_id int not null,
  uuid varchar(36) not null,
  name varchar(255) not null,
  type enum (
    'segment', 'email', 'wait', 'goal',
    'banner', 'condition', 'generic',
    'push_notification', 'ab_test'
  ) not null,
  options json null,
  deleted_at timestamp null,
  constraint uuid unique (uuid),
  constraint scenarios_elements_ibfk_1 foreign key (scenario_id) references scenarios (id)
) collate = utf8mb4_unicode_ci;
create table scenarios_element_elements (
  id int auto_increment primary key,
  parent_element_id int not null,
  child_element_id int not null,
  positive tinyint(1) default 1 null,
  position int default 0 null,
  constraint parent_element_id unique (
    parent_element_id, child_element_id,
    position
  ),
  constraint scenarios_element_elements_ibfk_1 foreign key (parent_element_id) references scenarios_elements (id) on delete cascade,
  constraint scenarios_element_elements_ibfk_2 foreign key (child_element_id) references scenarios_elements (id) on delete cascade
) collate = utf8mb4_unicode_ci;
create index child_element_id on scenarios_element_elements (child_element_id);
create table scenarios_element_stats (
  id int auto_increment primary key,
  element_id int not null,
  state varchar(255) null,
  count int null,
  aggregated_minutes int null,
  created_at datetime not null,
  constraint scenarios_element_stats_ibfk_1 foreign key (element_id) references scenarios_elements (id)
) collate = utf8mb4_unicode_ci;
create index element_id on scenarios_element_stats (element_id, state);
create index scenario_id on scenarios_elements (scenario_id);
create table scenarios_triggers (
  id int auto_increment primary key,
  scenario_id int not null,
  event_code varchar(255) not null,
  name varchar(255) not null,
  type enum ('event', 'before_event') not null,
  options json null,
  uuid varchar(36) not null,
  deleted_at timestamp null,
  constraint uuid unique (uuid),
  constraint scenarios_triggers_ibfk_1 foreign key (scenario_id) references scenarios (id)
) collate = utf8mb4_unicode_ci;
create table scenarios_generated_events (
  id int auto_increment primary key,
  trigger_id int not null,
  code varchar(255) not null,
  external_id int not null,
  created_at datetime not null,
  constraint trigger_id unique (trigger_id, code, external_id),
  constraint scenarios_generated_events_ibfk_1 foreign key (trigger_id) references scenarios_triggers (id)
) collate = utf8mb4_unicode_ci;
create table scenarios_jobs (
  id bigint auto_increment primary key,
  trigger_id int null,
  element_id int null,
  state varchar(255) not null,
  parameters json null,
  result json null,
  context json null,
  retry_count int not null,
  started_at datetime null,
  finished_at datetime null,
  created_at datetime not null,
  updated_at datetime not null,
  deleted_at datetime null,
  constraint scenarios_jobs_ibfk_1 foreign key (trigger_id) references scenarios_triggers (id),
  constraint scenarios_jobs_ibfk_2 foreign key (element_id) references scenarios_elements (id)
) collate = utf8mb4_unicode_ci;
create index deleted_at on scenarios_jobs (deleted_at);
create index element_id on scenarios_jobs (element_id, state);
create index state on scenarios_jobs (state);
create index trigger_id on scenarios_jobs (trigger_id);
create index updated_at on scenarios_jobs (updated_at);
create table scenarios_trigger_elements (
  id int auto_increment primary key,
  trigger_id int not null,
  element_id int not null,
  constraint trigger_id unique (trigger_id, element_id),
  constraint scenarios_trigger_elements_ibfk_1 foreign key (trigger_id) references scenarios_triggers (id) on delete cascade,
  constraint scenarios_trigger_elements_ibfk_2 foreign key (element_id) references scenarios_elements (id) on delete cascade
) collate = utf8mb4_unicode_ci;
create index element_id on scenarios_trigger_elements (element_id);
create table scenarios_trigger_stats (
  id int auto_increment primary key,
  trigger_id int not null,
  state varchar(255) null,
  count int null,
  aggregated_minutes int null,
  created_at datetime not null,
  constraint scenarios_trigger_stats_ibfk_1 foreign key (trigger_id) references scenarios_triggers (id)
) collate = utf8mb4_unicode_ci;
create index trigger_id on scenarios_trigger_stats (trigger_id, state);
create index scenario_id on scenarios_triggers (scenario_id);
create table segment_groups (
  id int auto_increment primary key,
  name varchar(255) not null,
  code varchar(255) not null,
  sorting int default 100 not null,
  created_at datetime not null,
  updated_at datetime not null,
  constraint code unique (code)
) collate = utf8mb4_unicode_ci;
create index sorting on segment_groups (sorting);
create table segments (
  id int auto_increment primary key,
  version int default 1 not null,
  name varchar(255) not null,
  code varchar(255) not null,
  locked tinyint(1) default 0 not null,
  table_name varchar(255) not null,
  created_at datetime not null,
  updated_at datetime not null,
  cache_count int null,
  cache_count_periodicity json null,
  cache_count_updated_at datetime null,
  cache_count_time float null,
  fields text null,
  query_string text null,
  segment_group_id int not null,
  criteria text null,
  deleted_at timestamp null,
  note text null,
  constraint code unique (code),
  constraint segments_ibfk_1 foreign key (segment_group_id) references segment_groups (id)
) collate = utf8mb4_unicode_ci;
create table sales_funnels (
  id int auto_increment primary key,
  name varchar(255) not null,
  url_key varchar(255) not null,
  start_at datetime null,
  end_at datetime null,
  created_at datetime not null,
  updated_at datetime not null,
  body longtext not null,
  error_html text null,
  no_access_html text null,
  head_meta text null,
  head_script text null,
  is_active tinyint(1) default 1 not null,
  segment_id int null,
  only_logged tinyint(1) default 0 not null,
  only_not_logged tinyint(1) default 0 not null,
  total_show int default 0 not null,
  loggedin_show int default 0 not null,
  notloggedin_show int default 0 not null,
  total_conversions int default 0 not null,
  total_errors int default 0 not null,
  last_use datetime null,
  last_conversion datetime null,
  redirect_funnel_id int null,
  limit_per_user int null,
  note text null,
  constraint url_key unique (url_key),
  constraint sales_funnels_ibfk_1 foreign key (segment_id) references segments (id),
  constraint sales_funnels_ibfk_2 foreign key (redirect_funnel_id) references sales_funnels (id)
) collate = utf8mb4_unicode_ci;
create table sales_funnel_tags (
  id int auto_increment primary key,
  sales_funnel_id int not null,
  tag varchar(255) not null,
  constraint sales_funnel_id unique (sales_funnel_id, tag),
  constraint sales_funnel_tags_ibfk_1 foreign key (sales_funnel_id) references sales_funnels (id)
) collate = utf8mb4_unicode_ci;
create index created_at on sales_funnels (created_at);
create index redirect_funnel_id on sales_funnels (redirect_funnel_id);
create index segment_id on sales_funnels (segment_id);
create table sales_funnels_meta (
  id int auto_increment primary key,
  sales_funnel_id int not null,
  `key` varchar(255) not null,
  value varchar(255) not null,
  created_at datetime not null,
  updated_at datetime not null,
  constraint sales_funnel_id unique (sales_funnel_id, `key`),
  constraint sales_funnels_meta_ibfk_1 foreign key (sales_funnel_id) references sales_funnels (id)
) collate = utf8mb4_unicode_ci;
create table sales_funnels_payment_gateways (
  id int auto_increment primary key,
  sales_funnel_id int not null,
  payment_gateway_id int not null,
  sorting int default 100 not null,
  constraint sales_funnel_id unique (
    sales_funnel_id, payment_gateway_id
  ),
  constraint sales_funnels_payment_gateways_ibfk_1 foreign key (sales_funnel_id) references sales_funnels (id),
  constraint sales_funnels_payment_gateways_ibfk_2 foreign key (payment_gateway_id) references payment_gateways (id)
) collate = utf8mb4_unicode_ci;
create index payment_gateway_id on sales_funnels_payment_gateways (payment_gateway_id);
create table sales_funnels_stats (
  id int auto_increment primary key,
  sales_funnel_id int not null,
  date datetime not null,
  type varchar(255) not null,
  value int default 0 not null,
  device_type varchar(255) null,
  constraint sales_funnels_stats_unique unique (
    sales_funnel_id, date, type, device_type
  ),
  constraint sales_funnels_stats_ibfk_1 foreign key (sales_funnel_id) references sales_funnels (id)
) collate = utf8mb4_unicode_ci;
create index segment_group_id on segments (segment_group_id);
create table segments_values (
  id int auto_increment primary key,
  segment_id int not null,
  date datetime not null,
  value int not null,
  constraint segments_values_ibfk_1 foreign key (segment_id) references segments (id)
) collate = utf8mb4_unicode_ci;
create index date on segments_values (date);
create index segment_id on segments_values (segment_id);
create table snippets (
  id int auto_increment primary key,
  identifier varchar(255) not null,
  title varchar(255) not null,
  is_active tinyint(1) default 1 not null,
  sorting int default 100 not null,
  html text not null,
  created_at datetime not null,
  updated_at datetime not null,
  last_used datetime null,
  total_used int default 0 not null,
  has_default_value tinyint(1) not null
) collate = utf8mb4_unicode_ci;
create index identifier on snippets (identifier);
create table subscription_extension_methods (
  method varchar(255) not null primary key,
  created_at datetime not null,
  title varchar(255) not null,
  description text not null,
  sorting int default 100 not null
) collate = utf8mb4_unicode_ci;
create index sorting on subscription_extension_methods (sorting);
create table subscription_length_methods (
  method varchar(255) not null primary key,
  created_at datetime not null,
  title varchar(255) not null,
  description text not null,
  sorting int default 100 not null
) collate = utf8mb4_unicode_ci;
create index sorting on subscription_length_methods (sorting);
create table subscription_type_names (
  id int auto_increment primary key,
  type varchar(255) not null,
  sorting int not null,
  is_active tinyint(1) default 1 not null,
  constraint type unique (type)
) collate = utf8mb4_unicode_ci;
create index sorting on subscription_type_names (sorting);
create table subscription_types (
  id int auto_increment primary key,
  name varchar(255) not null,
  code varchar(255) null,
  extension_method_id varchar(255) default 'extend_actual' not null,
  length_method_id varchar(255) default 'fix_days' not null,
  description text null,
  price decimal(10, 2) not null,
  length int not null,
  extending_length int null,
  fixed_start datetime null,
  fixed_end datetime null,
  user_label varchar(255) not null,
  active tinyint(1) not null,
  visible tinyint(1) default 1 not null,
  web tinyint(1) default 0 null,
  print tinyint(1) default 0 not null,
  club tinyint(1) default 0 not null,
  mobile tinyint(1) default 0 not null,
  `default` tinyint(1) default 0 not null,
  sorting int default 10 not null,
  created_at datetime not null,
  modified_at datetime not null,
  next_subscription_type_id int null,
  trial_periods tinyint unsigned default '0' not null,
  no_subscription tinyint(1) default 0 not null,
  print_friday tinyint(1) default 0 not null,
  ad_free tinyint(1) default 0 not null,
  ask_address tinyint(1) default 0 not null,
  limit_per_user int null,
  disable_notifications tinyint(1) default 0 not null,
  recurrent_charge_before int null,
  constraint code unique (code),
  constraint subscription_types_ibfk_1 foreign key (next_subscription_type_id) references subscription_types (id),
  constraint subscription_types_ibfk_2 foreign key (extension_method_id) references subscription_extension_methods (method),
  constraint subscription_types_ibfk_3 foreign key (length_method_id) references subscription_length_methods (method)
) collate = utf8mb4_unicode_ci;
create table sales_funnels_subscription_types (
  id int auto_increment primary key,
  sales_funnel_id int not null,
  subscription_type_id int not null,
  sorting int default 100 not null,
  constraint sales_funnel_id unique (
    sales_funnel_id, subscription_type_id
  ),
  constraint sales_funnels_subscription_types_ibfk_1 foreign key (sales_funnel_id) references sales_funnels (id),
  constraint sales_funnels_subscription_types_ibfk_2 foreign key (subscription_type_id) references subscription_types (id)
) collate = utf8mb4_unicode_ci;
create index subscription_type_id on sales_funnels_subscription_types (subscription_type_id);
create table subscription_type_content_access (
  id int auto_increment primary key,
  subscription_type_id int not null,
  content_access_id int not null,
  created_at datetime not null,
  constraint subscription_type_id_2 unique (
    subscription_type_id, content_access_id
  ),
  constraint subscription_type_content_access_ibfk_1 foreign key (subscription_type_id) references subscription_types (id),
  constraint subscription_type_content_access_ibfk_2 foreign key (content_access_id) references content_access (id)
) collate = utf8mb4_unicode_ci;
create index content_access_id on subscription_type_content_access (content_access_id);
create index subscription_type_id on subscription_type_content_access (subscription_type_id);
create table subscription_type_items (
  id int auto_increment primary key,
  subscription_type_id int not null,
  name varchar(255) not null,
  amount decimal(10, 2) not null,
  vat int not null,
  sorting int default 100 not null,
  created_at datetime not null,
  updated_at datetime not null,
  deleted_at datetime null,
  constraint subscription_type_items_ibfk_1 foreign key (subscription_type_id) references subscription_types (id)
) collate = utf8mb4_unicode_ci;
create table subscription_type_item_meta (
  id int auto_increment primary key,
  subscription_type_item_id int not null,
  `key` varchar(255) not null,
  value varchar(255) null,
  created_at datetime not null,
  updated_at datetime not null,
  constraint subscription_type_item_id unique (
    subscription_type_item_id, `key`
  ),
  constraint subscription_type_item_meta_ibfk_1 foreign key (subscription_type_item_id) references subscription_type_items (id)
) collate = utf8mb4_unicode_ci;
create index subscription_type_id on subscription_type_items (subscription_type_id, sorting);
create table subscription_type_magazines (
  id int auto_increment primary key,
  subscription_type_id int not null,
  magazine_id int not null,
  constraint subscription_type_id unique (
    subscription_type_id, magazine_id
  ),
  constraint subscription_type_magazines_ibfk_1 foreign key (subscription_type_id) references subscription_types (id),
  constraint subscription_type_magazines_ibfk_2 foreign key (magazine_id) references magazines (id)
) collate = utf8mb4_unicode_ci;
create index magazine_id on subscription_type_magazines (magazine_id);
create table subscription_type_tags (
  id int auto_increment primary key,
  subscription_type_id int not null,
  tag varchar(255) not null,
  constraint subscription_type_id unique (subscription_type_id, tag),
  constraint subscription_type_tags_ibfk_1 foreign key (subscription_type_id) references subscription_types (id)
) collate = utf8mb4_unicode_ci;
create index extension_method_id on subscription_types (extension_method_id);
create index length_method_id on subscription_types (length_method_id);
create index next_subscription_type_id on subscription_types (next_subscription_type_id);
create index sorting on subscription_types (sorting);
create table subscription_types_meta (
  id int auto_increment primary key,
  subscription_type_id int not null,
  `key` varchar(255) not null,
  value varchar(255) not null,
  sorting int default 100 not null,
  created_at datetime not null,
  updated_at datetime not null,
  constraint subscription_type_id unique (subscription_type_id, `key`),
  constraint subscription_types_meta_ibfk_1 foreign key (subscription_type_id) references subscription_types (id)
) collate = utf8mb4_unicode_ci;
create table tags (
  id int auto_increment primary key,
  code varchar(255) not null,
  name varchar(255) null,
  html_heading text null,
  icon varchar(255) not null,
  visible tinyint(1) default 0 not null,
  frontend_visible tinyint(1) null,
  user_assignable tinyint(1) null,
  sorting int null,
  constraint code unique (code)
) collate = utf8mb4_unicode_ci;
create table product_tags (
  id int auto_increment primary key,
  product_id int not null,
  tag_id int not null,
  sorting int default 100 not null,
  constraint product_tags_ibfk_1 foreign key (product_id) references products (id),
  constraint product_tags_ibfk_2 foreign key (tag_id) references tags (id)
) collate = utf8mb4_unicode_ci;
create index product_id on product_tags (product_id);
create index tag_id on product_tags (tag_id);
create table upgrade_schemas (
  id int auto_increment primary key,
  name varchar(255) not null
) collate = utf8mb4_unicode_ci;
create table subscription_type_upgrade_schemas (
  id int auto_increment primary key,
  subscription_type_id int null,
  upgrade_schema_id int null,
  constraint subscription_type_id unique (
    subscription_type_id, upgrade_schema_id
  ),
  constraint subscription_type_upgrade_schemas_ibfk_1 foreign key (subscription_type_id) references subscription_types (id),
  constraint subscription_type_upgrade_schemas_ibfk_2 foreign key (upgrade_schema_id) references upgrade_schemas (id)
) collate = utf8mb4_unicode_ci;
create index upgrade_schema_id on subscription_type_upgrade_schemas (upgrade_schema_id);
create table upgrade_options (
  id int auto_increment primary key,
  upgrade_schema_id int not null,
  subscription_type_id int null,
  type varchar(255) not null,
  config json not null,
  constraint upgrade_options_ibfk_1 foreign key (upgrade_schema_id) references upgrade_schemas (id),
  constraint upgrade_options_ibfk_2 foreign key (subscription_type_id) references subscription_types (id)
) collate = utf8mb4_unicode_ci;
create index subscription_type_id on upgrade_options (subscription_type_id);
create index upgrade_schema_id on upgrade_options (upgrade_schema_id);
create table users (
  id int auto_increment primary key,
  email varchar(255) not null,
  first_name varchar(255) null,
  last_name varchar(255) null,
  public_name varchar(255) not null,
  password varchar(255) not null,
  ext_id int null,
  uuid varchar(255) null,
  role varchar(255) default 'user' not null,
  active int default 0 not null,
  confirmed_at datetime null,
  email_validated_at datetime null,
  current_sign_in_at datetime null,
  created_at datetime not null,
  modified_at datetime not null,
  current_sign_in_ip varchar(255) null,
  invoice tinyint(1) default 0 not null,
  note text null,
  locale varchar(255) not null,
  is_institution tinyint(1) default 0 not null,
  institution_name varchar(255) null,
  supporter tinyint(1) default 0 not null,
  source varchar(255) default 'unknown' not null,
  registration_channel varchar(255) not null,
  sales_funnel_id int null,
  referer varchar(2000) null,
  disable_auto_invoice tinyint(1) default 0 not null,
  deleted_at datetime null,
  constraint email unique (email),
  constraint uuid unique (uuid),
  constraint users_ibfk_1 foreign key (sales_funnel_id) references sales_funnels (id)
) collate = utf8mb4_unicode_ci;
create table addresses (
  id int auto_increment primary key,
  user_id int not null,
  type varchar(255) not null,
  title varchar(255) null,
  created_at datetime not null,
  updated_at datetime not null,
  deleted_at datetime null,
  first_name varchar(255) null,
  last_name varchar(255) null,
  address varchar(255) null,
  number varchar(255) null,
  city varchar(255) null,
  zip varchar(255) null,
  country_id int null,
  company_id varchar(255) null,
  company_tax_id varchar(255) null,
  company_vat_id varchar(255) null,
  company_name varchar(255) null,
  phone_number varchar(255) null,
  constraint addresses_ibfk_1 foreign key (country_id) references countries (id),
  constraint addresses_ibfk_2 foreign key (user_id) references users (id),
  constraint addresses_ibfk_3 foreign key (type) references address_types (type)
) collate = utf8mb4_unicode_ci;
create table address_change_requests (
  id int auto_increment primary key,
  type varchar(255) not null,
  user_id int not null,
  address_id int null,
  first_name varchar(255) null,
  last_name varchar(255) null,
  company_name varchar(255) null,
  address varchar(255) null,
  number varchar(255) null,
  city varchar(255) null,
  zip varchar(255) null,
  country_id int null,
  company_id varchar(255) null,
  company_tax_id varchar(255) null,
  company_vat_id varchar(255) null,
  phone_number varchar(255) null,
  status varchar(255) not null,
  created_at datetime not null,
  updated_at datetime not null,
  old_first_name varchar(255) null,
  old_last_name varchar(255) null,
  old_company_name varchar(255) null,
  old_address varchar(255) null,
  old_number varchar(255) null,
  old_city varchar(255) null,
  old_zip varchar(255) null,
  old_country_id int null,
  old_company_id varchar(255) null,
  old_company_tax_id varchar(255) null,
  old_company_vat_id varchar(255) null,
  old_phone_number varchar(255) null,
  constraint address_change_requests_ibfk_1 foreign key (user_id) references users (id),
  constraint address_change_requests_ibfk_2 foreign key (address_id) references addresses (id),
  constraint address_change_requests_ibfk_3 foreign key (type) references address_types (type)
) collate = utf8mb4_unicode_ci;
create index address_id on address_change_requests (address_id);
create index created_at on address_change_requests (created_at);
create index type on address_change_requests (type);
create index user_id on address_change_requests (user_id);
create table address_redirects (
  id int auto_increment primary key,
  original_address_id int not null,
  redirect_address_id int not null,
  `from` datetime not null,
  `to` datetime not null,
  note text null,
  created_at datetime not null,
  updated_at datetime not null,
  constraint address_redirects_ibfk_1 foreign key (original_address_id) references addresses (id),
  constraint address_redirects_ibfk_2 foreign key (redirect_address_id) references addresses (id)
) collate = utf8mb4_unicode_ci;
create index original_address_id on address_redirects (original_address_id);
create index redirect_address_id on address_redirects (redirect_address_id);
create index country_id on addresses (country_id);
create index type on addresses (type);
create index user_id on addresses (user_id);
create table addresses_meta (
  id int auto_increment primary key,
  address_id int not null,
  address_change_request_id int not null,
  `key` varchar(255) not null,
  value varchar(255) not null,
  created_at timestamp default CURRENT_TIMESTAMP not null,
  updated_at timestamp null on update CURRENT_TIMESTAMP,
  constraint addresses_meta_ibfk_1 foreign key (address_id) references addresses (id),
  constraint addresses_meta_ibfk_2 foreign key (address_change_request_id) references address_change_requests (id)
) collate = utf8mb4_unicode_ci;
create index address_change_request_id on addresses_meta (address_change_request_id);
create index address_id on addresses_meta (address_id);
create index `key` on addresses_meta (`key`);
create index key_2 on addresses_meta (`key`);
create table admin_user_groups (
  id int auto_increment primary key,
  admin_group_id int not null,
  user_id int not null,
  created_at datetime not null,
  updated_at datetime not null,
  constraint admin_group_id unique (admin_group_id, user_id),
  constraint admin_user_groups_ibfk_1 foreign key (admin_group_id) references admin_groups (id),
  constraint admin_user_groups_ibfk_2 foreign key (user_id) references users (id)
) collate = utf8mb4_unicode_ci;
create index user_id on admin_user_groups (user_id);
create table audit_logs (
  id bigint auto_increment primary key,
  operation enum (
    'create', 'read', 'update', 'delete'
  ) not null,
  user_id int null,
  table_name varchar(255) not null,
  signature varchar(255) not null,
  data longtext null,
  created_at datetime not null,
  deleted_at datetime null,
  constraint audit_logs_ibfk_1 foreign key (user_id) references users (id)
) collate = utf8mb4_unicode_ci;
create index created_at on audit_logs (created_at);
create index signature on audit_logs (signature);
create index table_name on audit_logs (table_name);
create index user_id on audit_logs (user_id);
create table autologin_tokens (
  id int auto_increment primary key,
  token varchar(255) not null,
  user_id int null,
  email varchar(255) not null,
  created_at datetime not null,
  valid_from datetime not null,
  valid_to datetime not null,
  used_count int default 0 not null,
  max_count int default 1 not null,
  constraint token unique (token),
  constraint autologin_tokens_ibfk_1 foreign key (user_id) references users (id)
) collate = utf8mb4_unicode_ci;
create index user_id on autologin_tokens (user_id);
create index valid_to on autologin_tokens (valid_to, user_id);
create table change_passwords_logs (
  id int auto_increment primary key,
  user_id int not null,
  type varchar(255) not null,
  created_at datetime not null,
  from_password varchar(255) not null,
  to_password varchar(255) not null,
  constraint change_passwords_logs_ibfk_1 foreign key (user_id) references users (id)
) collate = utf8mb4_unicode_ci;
create index created_at on change_passwords_logs (created_at);
create index created_at_2 on change_passwords_logs (created_at, user_id);
create index user_id on change_passwords_logs (user_id);
create table password_reset_tokens (
  id int auto_increment primary key,
  token varchar(255) not null,
  user_id int not null,
  created_at datetime not null,
  expire_at datetime not null,
  used_at datetime null,
  source varchar(255) null,
  constraint token unique (token),
  constraint password_reset_tokens_ibfk_1 foreign key (user_id) references users (id)
) collate = utf8mb4_unicode_ci;
create index user_id on password_reset_tokens (user_id);
create table registration_attempts (
  id int auto_increment primary key,
  user_id int null,
  email varchar(255) not null,
  created_at datetime not null,
  status varchar(255) not null,
  source varchar(255) null,
  ip varchar(255) not null,
  user_agent text null,
  constraint registration_attempts_ibfk_1 foreign key (user_id) references users (id)
) collate = utf8mb4_unicode_ci;
create index ip on registration_attempts (ip, created_at);
create index user_id on registration_attempts (user_id);
create table sales_funnels_conversion_distributions (
  id int auto_increment primary key,
  sales_funnel_id int null,
  type varchar(255) null,
  user_id int null,
  value decimal(10, 2) not null,
  created_at datetime not null,
  constraint funnel_type_user_idx unique (sales_funnel_id, type, user_id),
  constraint sales_funnels_conversion_distributions_ibfk_1 foreign key (sales_funnel_id) references sales_funnels (id),
  constraint sales_funnels_conversion_distributions_ibfk_2 foreign key (user_id) references users (id)
) collate = utf8mb4_unicode_ci;
create index user_id on sales_funnels_conversion_distributions (user_id);
create table scenarios_selected_variants (
  id int auto_increment primary key,
  element_id int not null,
  user_id int not null,
  variant_code varchar(255) not null,
  created_at datetime not null,
  constraint user_id unique (
    user_id, element_id, variant_code
  ),
  constraint scenarios_selected_variants_ibfk_1 foreign key (element_id) references scenarios_elements (id),
  constraint scenarios_selected_variants_ibfk_2 foreign key (user_id) references users (id)
) collate = utf8mb4_unicode_ci;
create index element_id on scenarios_selected_variants (element_id);
create table subscriptions (
  id int auto_increment primary key,
  user_id int not null,
  subscription_type_id int not null,
  is_recurrent tinyint(1) default 0 not null,
  is_paid tinyint(1) null,
  start_time datetime not null,
  end_time datetime not null,
  type varchar(255) not null,
  length int not null,
  created_at datetime not null,
  modified_at datetime not null,
  next_subscription_id int null,
  internal_status varchar(255) default 'unknown' not null,
  note varchar(255) null,
  address_id int null,
  constraint subscriptions_ibfk_2 foreign key (subscription_type_id) references subscription_types (id),
  constraint subscriptions_ibfk_3 foreign key (user_id) references users (id),
  constraint subscriptions_ibfk_4 foreign key (next_subscription_id) references subscriptions (id),
  constraint subscriptions_ibfk_6 foreign key (address_id) references addresses (id),
  constraint subscriptions_ibfk_7 foreign key (type) references subscription_type_names (type)
) collate = utf8mb4_unicode_ci;
create table access_tokens (
  id int auto_increment primary key,
  token varchar(255) not null,
  created_at datetime not null,
  user_id int not null,
  subscription_id int null,
  device_token_id int null,
  valid_until datetime null,
  ip varchar(255) not null,
  user_agent text not null,
  version int default 1 not null,
  last_used_at datetime null,
  source varchar(255) null,
  constraint access_tokens_ibfk_1 foreign key (user_id) references users (id),
  constraint access_tokens_ibfk_2 foreign key (subscription_id) references subscriptions (id),
  constraint access_tokens_ibfk_3 foreign key (device_token_id) references device_tokens (id) on delete
  set
    null
) collate = utf8mb4_unicode_ci;
create index created_at on access_tokens (created_at, user_id);
create index device_token_id on access_tokens (device_token_id);
create index last_used_at on access_tokens (last_used_at);
create index subscription_id on access_tokens (subscription_id);
create index token on access_tokens (token);
create index user_id on access_tokens (user_id);
create table payments (
  id int auto_increment primary key,
  variable_symbol varchar(255) not null,
  amount decimal(10, 2) not null,
  additional_amount decimal(10, 2) default 0.00 not null,
  additional_type varchar(255) null,
  payment_gateway_id int not null,
  subscription_id int null,
  subscription_type_id int null,
  user_id int not null,
  status varchar(255) default 'form' not null,
  created_at datetime not null,
  modified_at datetime not null,
  error_message varchar(255) null,
  referer varchar(2000) null,
  paid_at datetime null,
  note text null,
  ip varchar(255) not null,
  user_agent varchar(2000) not null,
  subscription_start_at datetime null,
  subscription_end_at datetime null,
  address_id int null,
  payment_country_id int null,
  payment_country_resolution_reason varchar(255) null,
  recurrent_charge tinyint(1) default 0 not null,
  invoice_id int null,
  invoice_number_id int null,
  sales_funnel_id int null,
  upgrade_type varchar(255) null,
  constraint invoice_number_id unique (invoice_number_id),
  constraint payments_ibfk_10 foreign key (invoice_id) references invoices (id),
  constraint payments_ibfk_11 foreign key (sales_funnel_id) references sales_funnels (id),
  constraint payments_ibfk_12 foreign key (invoice_number_id) references invoice_numbers (id),
  constraint payments_ibfk_13 foreign key (payment_country_id) references countries (id),
  constraint payments_ibfk_2 foreign key (subscription_type_id) references subscription_types (id) on delete
  set
    null,
    constraint payments_ibfk_3 foreign key (user_id) references users (id),
    constraint payments_ibfk_4 foreign key (subscription_id) references subscriptions (id),
    constraint payments_ibfk_8 foreign key (payment_gateway_id) references payment_gateways (id),
    constraint payments_ibfk_9 foreign key (address_id) references addresses (id)
) collate = utf8mb4_unicode_ci;
create table orders (
  id int auto_increment primary key,
  payment_id int not null,
  shipping_address_id int null,
  licence_address_id int null,
  billing_address_id int null,
  postal_fee_id int null,
  note text null,
  status varchar(255) default 'new' not null,
  created_at datetime not null,
  updated_at datetime not null,
  backup_postal_fee_amount decimal(10, 2) null,
  constraint orders_ibfk_1 foreign key (payment_id) references payments (id),
  constraint orders_ibfk_2 foreign key (shipping_address_id) references addresses (id),
  constraint orders_ibfk_3 foreign key (billing_address_id) references addresses (id),
  constraint orders_ibfk_4 foreign key (postal_fee_id) references postal_fees (id),
  constraint orders_ibfk_5 foreign key (licence_address_id) references addresses (id)
) collate = utf8mb4_unicode_ci;
create index billing_address_id on orders (billing_address_id);
create index licence_address_id on orders (licence_address_id);
create index payment_id on orders (payment_id);
create index postal_fee_id on orders (postal_fee_id);
create index shipping_address_id on orders (shipping_address_id);
create table parsed_mail_logs (
  id int auto_increment primary key,
  created_at datetime not null,
  delivered_at datetime not null,
  variable_symbol varchar(255) null,
  amount float null,
  payment_id int null,
  state varchar(255) not null,
  message varchar(255) null,
  source_account_number varchar(255) null,
  note text null,
  constraint parsed_mail_logs_ibfk_1 foreign key (payment_id) references payments (id)
) collate = utf8mb4_unicode_ci;
create index created_at on parsed_mail_logs (created_at);
create index payment_id on parsed_mail_logs (payment_id);
create index state on parsed_mail_logs (state);
create index variable_symbol on parsed_mail_logs (variable_symbol);
create table payment_gift_coupons (
  id int auto_increment primary key,
  payment_id int not null,
  product_id int null,
  subscription_type_id int null,
  email varchar(255) not null,
  starts_at datetime not null,
  status varchar(255) not null,
  sent_at datetime null,
  subscription_id int null,
  address_id int null,
  constraint payment_gift_coupons_ibfk_1 foreign key (payment_id) references payments (id),
  constraint payment_gift_coupons_ibfk_2 foreign key (product_id) references products (id),
  constraint payment_gift_coupons_ibfk_3 foreign key (subscription_id) references subscriptions (id),
  constraint payment_gift_coupons_ibfk_4 foreign key (subscription_type_id) references subscription_types (id),
  constraint payment_gift_coupons_ibfk_5 foreign key (address_id) references addresses (id)
) charset = utf8mb3;
create index address_id on payment_gift_coupons (address_id);
create index payment_id on payment_gift_coupons (payment_id);
create index product_id on payment_gift_coupons (product_id);
create index subscription_id on payment_gift_coupons (subscription_id);
create index subscription_type_id on payment_gift_coupons (subscription_type_id);
create table payment_items (
  id int auto_increment primary key,
  payment_id int not null,
  type varchar(255) default 'subscription_type' not null,
  subscription_type_id int null,
  subscription_type_item_id int null,
  product_id int null,
  postal_fee_id int null,
  name varchar(255) not null,
  count int default 1 not null,
  amount decimal(10, 2) not null,
  amount_without_vat decimal(10, 2) not null,
  vat int not null,
  created_at datetime not null,
  updated_at datetime not null,
  constraint payment_items_ibfk_1 foreign key (payment_id) references payments (id),
  constraint payment_items_ibfk_2 foreign key (subscription_type_id) references subscription_types (id),
  constraint payment_items_ibfk_3 foreign key (product_id) references products (id),
  constraint payment_items_ibfk_4 foreign key (postal_fee_id) references postal_fees (id),
  constraint payment_items_ibfk_5 foreign key (subscription_type_item_id) references subscription_type_items (id)
) collate = utf8mb4_unicode_ci;
create table payment_item_meta (
  id int auto_increment primary key,
  payment_item_id int not null,
  `key` varchar(255) not null,
  value varchar(255) null,
  created_at datetime not null,
  updated_at datetime not null,
  constraint payment_item_id unique (payment_item_id, `key`),
  constraint payment_item_meta_ibfk_1 foreign key (payment_item_id) references payment_items (id)
) collate = utf8mb4_unicode_ci;
create index payment_id on payment_items (payment_id);
create index postal_fee_id on payment_items (postal_fee_id);
create index product_id on payment_items (product_id);
create index subscription_type_id on payment_items (subscription_type_id);
create index subscription_type_item_id on payment_items (subscription_type_item_id);
create index type on payment_items (type);
create table payment_logs (
  id int auto_increment primary key,
  created_at datetime not null,
  status varchar(255) not null,
  message text null,
  source_url text not null,
  payment_id int null,
  constraint payment_logs_ibfk_1 foreign key (payment_id) references payments (id)
) collate = utf8mb4_unicode_ci;
create index payment_id on payment_logs (payment_id);
create table payment_meta (
  id int auto_increment primary key,
  payment_id int not null,
  `key` varchar(255) not null,
  value varchar(255) not null,
  constraint payment_id unique (payment_id, `key`),
  constraint payment_meta_ibfk_1 foreign key (payment_id) references payments (id)
) collate = utf8mb4_unicode_ci;
create index `key` on payment_meta (`key`);
create index value on payment_meta (value);
create index address_id on payments (address_id);
create index created_at on payments (created_at);
create index invoice_id on payments (invoice_id);
create index modified_at on payments (modified_at);
create index paid_at on payments (paid_at);
create index payment_country_id on payments (payment_country_id);
create index payment_type_id on payments (payment_gateway_id);
create index sales_funnel_id on payments (sales_funnel_id, status, amount);
create index status on payments (status);
create index subscription_id on payments (subscription_id);
create index subscription_type_id on payments (subscription_type_id);
create index user_id on payments (user_id);
create index variable_symbol on payments (variable_symbol);
create table print_subscriptions (
  id int auto_increment primary key,
  type varchar(255) not null,
  subscription_id int null,
  user_id int not null,
  address_id int null,
  exported_at datetime not null,
  export_date datetime not null,
  first_name varchar(255) null,
  last_name varchar(255) null,
  address varchar(255) null,
  number varchar(255) null,
  zip varchar(255) null,
  city varchar(255) null,
  phone_number varchar(255) null,
  country_id int not null,
  email varchar(255) not null,
  status varchar(255) default 'new' not null,
  institution_name varchar(255) null,
  meta json not null,
  constraint print_subscriptions_ibfk_1 foreign key (user_id) references users (id),
  constraint print_subscriptions_ibfk_2 foreign key (address_id) references addresses (id),
  constraint print_subscriptions_ibfk_3 foreign key (subscription_id) references subscriptions (id),
  constraint print_subscriptions_ibfk_4 foreign key (country_id) references countries (id)
) collate = utf8mb4_unicode_ci;
create table print_claims (
  id int auto_increment primary key,
  print_subscription_id int not null,
  description text null,
  claimant varchar(255) null,
  claimant_contact varchar(255) null,
  created_at datetime not null,
  closed_at datetime null,
  updated_at datetime not null,
  constraint print_claims_ibfk_1 foreign key (print_subscription_id) references print_subscriptions (id)
) collate = utf8mb4_unicode_ci;
create index created_at on print_claims (created_at);
create index print_subscription_id on print_claims (print_subscription_id);
create index address_id on print_subscriptions (address_id);
create index export_date on print_subscriptions (export_date);
create index exported_at_export_date_status on print_subscriptions (exported_at, export_date, status);
create index fk_country_id on print_subscriptions (country_id);
create index subscription_id on print_subscriptions (subscription_id);
create index type on print_subscriptions (type);
create index user_id on print_subscriptions (user_id);
create table recurrent_payments (
  id int auto_increment primary key,
  cid varchar(255) null,
  created_at datetime not null,
  updated_at datetime not null,
  payment_gateway_id int not null,
  charge_at datetime not null,
  expires_at datetime null,
  payment_id int null,
  retries int default 3 not null,
  status varchar(255) null,
  approval varchar(255) null,
  user_id int not null,
  subscription_type_id int not null,
  next_subscription_type_id int null,
  parent_payment_id int null,
  state varchar(255) default 'active' not null,
  note varchar(255) null,
  custom_amount float null,
  constraint recurrent_payments_ibfk_1 foreign key (subscription_type_id) references subscription_types (id),
  constraint recurrent_payments_ibfk_2 foreign key (user_id) references users (id),
  constraint recurrent_payments_ibfk_4 foreign key (parent_payment_id) references payments (id),
  constraint recurrent_payments_ibfk_5 foreign key (payment_gateway_id) references payment_gateways (id),
  constraint recurrent_payments_ibfk_6 foreign key (next_subscription_type_id) references subscription_types (id),
  constraint recurrent_payments_ibfk_7 foreign key (payment_id) references payments (id)
) collate = utf8mb4_unicode_ci;
create index charge_at on recurrent_payments (charge_at);
create index cid on recurrent_payments (cid);
create index created_at on recurrent_payments (created_at);
create index next_subscription_type_id on recurrent_payments (next_subscription_type_id);
create index parent_payment_id on recurrent_payments (parent_payment_id);
create index payment_id on recurrent_payments (payment_id);
create index payment_type_id on recurrent_payments (payment_gateway_id);
create index state on recurrent_payments (state);
create index subscription_type_id on recurrent_payments (subscription_type_id);
create index user_id on recurrent_payments (user_id);
create table subscription_upgrades (
  id int auto_increment primary key,
  base_subscription_id int not null,
  upgraded_subscription_id int not null,
  type varchar(255) not null,
  created_at datetime not null,
  constraint subscription_upgrades_ibfk_1 foreign key (base_subscription_id) references subscriptions (id),
  constraint subscription_upgrades_ibfk_2 foreign key (upgraded_subscription_id) references subscriptions (id)
) collate = utf8mb4_unicode_ci;
create index base_subscription_id on subscription_upgrades (base_subscription_id);
create index upgraded_subscription_id on subscription_upgrades (upgraded_subscription_id);
create index address_id on subscriptions (address_id);
create index created_at on subscriptions (created_at);
create index end_time on subscriptions (end_time);
create index internal_status on subscriptions (internal_status);
create index is_paid on subscriptions (is_paid);
create index is_recurrent on subscriptions (is_recurrent);
create index next_subscription_id on subscriptions (next_subscription_id);
create index start_time on subscriptions (start_time, end_time);
create index start_time_2 on subscriptions (start_time);
create index subscription_type_id on subscriptions (subscription_type_id);
create index type on subscriptions (type);
create index user_id on subscriptions (user_id);
create table subscriptions_meta (
  id int auto_increment primary key,
  subscription_id int null,
  `key` varchar(255) null,
  value varchar(255) null,
  created_at datetime null,
  updated_at datetime null,
  sorting int default 100 null,
  constraint subscription_id unique (subscription_id, `key`),
  constraint subscriptions_meta_ibfk_1 foreign key (subscription_id) references subscriptions (id)
) collate = utf8mb4_unicode_ci;
create index `key` on subscriptions_meta (`key`);
create table user_actions_log (
  id int auto_increment primary key,
  user_id int not null,
  created_at datetime not null,
  action varchar(255) not null,
  params json null,
  constraint user_actions_log_ibfk_1 foreign key (user_id) references users (id)
) collate = utf8mb4_unicode_ci;
create index created_at on user_actions_log (created_at);
create index user_id on user_actions_log (user_id);
create table user_connected_accounts (
  id int auto_increment primary key,
  user_id int not null,
  type varchar(255) not null,
  external_id varchar(255) not null,
  email varchar(255) null,
  created_at datetime not null,
  updated_at datetime not null,
  meta json null,
  constraint type unique (type, external_id),
  constraint user_connected_accounts_ibfk_1 foreign key (user_id) references users (id)
) collate = utf8mb4_unicode_ci;
create index user_id_2 on user_connected_accounts (user_id);
create table user_email_confirmations (
  id int auto_increment primary key,
  user_id int not null,
  token varchar(255) not null,
  confirmed_at datetime null,
  constraint user_email_confirmations_ibfk_1 foreign key (user_id) references users (id)
) collate = utf8mb4_unicode_ci;
create index user_id on user_email_confirmations (user_id);
create table user_groups (
  id int auto_increment primary key,
  user_id int not null,
  group_id int not null,
  created_at datetime not null,
  constraint user_groups_ibfk_1 foreign key (user_id) references users (id),
  constraint user_groups_ibfk_2 foreign key (group_id) references `groups` (id)
) collate = utf8mb4_unicode_ci;
create index created_at on user_groups (created_at);
create index group_id on user_groups (group_id);
create index user_id on user_groups (user_id);
create table user_meta (
  id int auto_increment primary key,
  user_id int not null,
  `key` varchar(255) not null,
  value text not null,
  is_public tinyint(1) default 0 not null,
  created_at datetime not null,
  updated_at datetime not null,
  constraint user_id unique (user_id, `key`),
  constraint user_meta_ibfk_1 foreign key (user_id) references users (id)
) collate = utf8mb4_unicode_ci;
create index `key` on user_meta (`key`);
create table user_onboarding_goals (
  id int auto_increment primary key,
  user_id int not null,
  onboarding_goal_id int not null,
  created_at datetime not null,
  updated_at datetime not null,
  completed_at datetime null,
  timedout_at datetime null,
  constraint user_onboarding_goals_ibfk_1 foreign key (user_id) references users (id),
  constraint user_onboarding_goals_ibfk_2 foreign key (onboarding_goal_id) references onboarding_goals (id)
) collate = utf8mb4_unicode_ci;
create index created_at on user_onboarding_goals (created_at);
create index onboarding_goal_id on user_onboarding_goals (onboarding_goal_id);
create index timedout_at on user_onboarding_goals (timedout_at);
create index user_id on user_onboarding_goals (user_id);
create table user_source_accesses (
  id int auto_increment primary key,
  user_id int not null,
  source varchar(255) not null,
  last_accessed_at datetime not null,
  constraint user_id unique (user_id, source),
  constraint user_source_accesses_ibfk_1 foreign key (user_id) references users (id)
) collate = utf8mb4_unicode_ci;
create table user_stats (
  id int auto_increment primary key,
  user_id int not null,
  `key` varchar(255) not null,
  value varchar(255) not null,
  created_at datetime not null,
  updated_at datetime not null,
  constraint `key` unique (`key`, user_id),
  constraint user_stats_ibfk_1 foreign key (user_id) references users (id)
) collate = utf8mb4_unicode_ci;
create index user_id on user_stats (user_id);
create index active on users (active);
create index created_at on users (created_at);
create index public_name on users (public_name);
create index sales_funnel_id on users (sales_funnel_id);
create index source on users (source);
create index wp_id on users (ext_id);
create table variable_symbols (
  id int auto_increment primary key,
  created_at datetime not null,
  variable_symbol varchar(255) not null,
  constraint variable_symbol unique (variable_symbol)
) collate = utf8mb4_unicode_ci;
create table vat_rates (
  id int auto_increment primary key,
  country_id int not null,
  standard float not null,
  reduced json default (_utf8mb4 '[]') not null comment 'Reduced VAT rates (eg. print).',
  eperiodical float null comment 'VAT rate for online periodical publications.',
  ebook float null,
  valid_from datetime null,
  valid_to datetime null comment 'Set only if new rates for country were added.',
  created_at datetime not null,
  constraint vat_rates_ibfk_1 foreign key (country_id) references countries (id)
) collate = utf8mb4_unicode_ci;
create index country_id on vat_rates (country_id);
create index valid_from on vat_rates (valid_from);
create index valid_to on vat_rates (valid_to);
