-- Create database;
CREATE DATABASE IF NOT EXISTS mini_blog CHARACTER SET utf8 COLLATE utf8_general_ci;

-- Use database
USE mini_blog;

--
-- Character encoding setting
--
SET NAMES utf8;

-- drop before create table
DROP TABLE IF EXISTS comments;
DROP TABLE IF EXISTS posts;
DROP TABLE IF EXISTS tokens;
DROP TABLE IF EXISTS users;

--
-- 'comments' table structure
--
CREATE TABLE comments (
    id INTEGER NOT NULL AUTO_INCREMENT,
    content VARCHAR(256) NOT NULL,
    create_time TIMESTAMP NOT NULL,
    edit_time TIMESTAMP,
    pcomment_id INTEGER,
    post_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    PRIMARY KEY (id)
)  ENGINE=INNODB;

--
-- 'posts' table structure
--
CREATE TABLE posts (
    id INTEGER NOT NULL AUTO_INCREMENT,
    content TINYTEXT NOT NULL,
    create_time TIMESTAMP NOT NULL,
    description VARCHAR(128) NOT NULL,
    edit_time TIMESTAMP,
    public_time TIMESTAMP,
    title VARCHAR(128) NOT NULL,
    user_id INTEGER NOT NULL,
    PRIMARY KEY (id)
)  ENGINE=INNODB;

--
-- 'tokens' table structure
--
CREATE TABLE tokens (
    id INTEGER NOT NULL AUTO_INCREMENT,
    create_time TIMESTAMP NOT NULL,
    expired_time TIMESTAMP NOT NULL,
    value VARCHAR(64) NOT NULL,
    user_id INTEGER NOT NULL,
    PRIMARY KEY (id)
)  ENGINE=INNODB;

--
-- 'users' table structure
--
CREATE TABLE users (
    id INTEGER NOT NULL AUTO_INCREMENT,
    avatar_link VARCHAR(256),
    first_name VARCHAR(64) NOT NULL,
    join_date DATE NOT NULL,
    last_name VARCHAR(64) NOT NULL,
    pass_hash VARCHAR(64) NOT NULL,
    username VARCHAR(64) NOT NULL,
    PRIMARY KEY (id)
)  ENGINE=INNODB;

-- foreign key
ALTER TABLE comments ADD INDEX fk_comments_users (user_id), ADD CONSTRAINT fk_comments_users FOREIGN KEY (user_id) REFERENCES users (id);
ALTER TABLE comments ADD INDEX fk_comments_comments (pcomment_id), ADD CONSTRAINT fk_comments_comments FOREIGN KEY (pcomment_id) REFERENCES comments (id);
ALTER TABLE comments ADD INDEX fk_comments_posts (post_id), ADD CONSTRAINT fk_comments_posts FOREIGN KEY (post_id) REFERENCES posts (id);
ALTER TABLE posts ADD INDEX fk_posts_users (user_id), ADD CONSTRAINT fk_posts_users FOREIGN KEY (user_id) REFERENCES users (id);
ALTER TABLE tokens ADD INDEX fk_tokens_users (user_id), ADD CONSTRAINT fk_tokens_users FOREIGN KEY (user_id) REFERENCES users (id);
