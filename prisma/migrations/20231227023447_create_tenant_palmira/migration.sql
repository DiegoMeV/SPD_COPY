-- This is an empty migration.
DELETE FROM user_account
WHERE  email = 'miguelramirezdeveloper@gmail.com';

UPDATE user_account
SET   role = 'ADMIN'
WHERE tenant_id = 3; --Palmira