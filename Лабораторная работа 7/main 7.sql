drop user test
drop role test_role

create role test_role

create login test_login with password = 'password'
create user test_user for test_login

grant update, select on player to test_user
