CREATE DATABASE IF NOT EXISTS petclinic;

ALTER DATABASE petclinic
  DEFAULT CHARACTER SET utf8
  DEFAULT COLLATE utf8_general_ci;

--GRANT ALL PRIVILEGES ON petclinic.* TO 'petclinic@%' IDENTIFIED BY 'petclinic';

create user 'petclinic'@'%' identified by 'petclinic';

-- For MySQL 8.0, to avoid NPE
-- java.sql.SQLNonTransientConnectionException: Could not create connection to database server.
--      at com.mysql.cj.jdbc.exceptions.SQLError.createSQLException(SQLError.java:110) ~[na:na]
-- due to :
--      Authentication plugin 'caching_sha2_password' cannot be loaded: /usr/lib64/mysql/plugin/caching_sha2_password.so: cannot open shared object file: No such file or directory
-- uncomment below :
ALTER USER 'petclinic'@'%' IDENTIFIED WITH mysql_native_password BY 'petclinic';

grant all on petclinic.* to 'petclinic'@'%';
FLUSH PRIVILEGES;
