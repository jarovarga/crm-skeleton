SELECT
  users.first_name,
  users.last_name,
  users.email,
  subscriptions.*
FROM
  users
  INNER JOIN subscriptions ON users.id = subscriptions.user_id
WHERE
  users.registration_channel = 'api'
  AND subscriptions.start_time = '2024-01-01'
  AND subscriptions.end_time >= NOW()
  AND users.referer LIKE '%fontech%';
