-- Create database;
CREATE DATABASE IF NOT EXISTS mini_blog CHARACTER SET utf8 COLLATE utf8_general_ci;

-- Use database
USE mini_blog;

--
-- Character encoding setting
--
SET NAMES utf8;


-- drop before create table
drop table if exists _comments;
drop table if exists _posts;
drop table if exists _tokens;
drop table if exists _users;

CREATE TABLE _comments (
    id INTEGER NOT NULL AUTO_INCREMENT,
    content VARCHAR(256) NOT NULL,
    create_time TIMESTAMP NOT NULL,
    edit_time TIMESTAMP,
    partner_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    PRIMARY KEY (id)
)  ENGINE=INNODB;
--
-- '_posts' table structure
--;
CREATE TABLE _posts (
    id INTEGER NOT NULL AUTO_INCREMENT,
    content VARCHAR(1024) NOT NULL,
    create_time TIMESTAMP NOT NULL,
    description VARCHAR(50) NOT NULL,
    edit_time TIMESTAMP,
    user_id INTEGER NOT NULL,
    PRIMARY KEY (id)
)  ENGINE=INNODB;
--
-- '_posts' table structure
--;
CREATE TABLE _tokens (
    id INTEGER NOT NULL AUTO_INCREMENT,
    create_time TIMESTAMP NOT NULL,
    expired_time TIMESTAMP NOT NULL,
    value VARCHAR(64) NOT NULL,
    user_id INTEGER NOT NULL,
    PRIMARY KEY (id)
)  ENGINE=INNODB;
--
-- '_users' table structure
--;
CREATE TABLE _users (
    id INTEGER NOT NULL AUTO_INCREMENT,
    avatar_link VARCHAR(256),
    first_name VARCHAR(64) NOT NULL,
    join_date TIMESTAMP NOT NULL,
    last_name VARCHAR(64) NOT NULL,
    pass_hash VARCHAR(64) NOT NULL,
    user_name VARCHAR(64) NOT NULL,
    PRIMARY KEY (id)
)  ENGINE=INNODB;

-- foreign key
alter table _comments add index fk_comments_users (user_id), add constraint fk_comments_users foreign key (user_id) references _users (id);
alter table _comments add index fk_comments_posts (partner_id), add constraint fk_comments_posts foreign key (partner_id) references _posts (id);
alter table _posts add index fk_posts_users (user_id), add constraint fk_posts_users foreign key (user_id) references _users (id);
alter table _tokens add index fk_tokens_users (user_id), add constraint fk_tokens_users foreign key (user_id) references _users (id);