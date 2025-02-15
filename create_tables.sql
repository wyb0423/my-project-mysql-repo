-- create jobprotal database
DROP DATABASE IF EXISTS `jobportal`;
CREATE DATABASE `jobportal`;
USE `jobportal`;

-- create table_1: user_type
-- column: user_type_id; user_type_name;
CREATE TABLE `user_type` (
	`user_type_id` int NOT NULL AUTO_INCREMENT,
    `user_type_name` varchar(255) DEFAULT NULL,
    PRIMARY KEY (`user_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `user_type` VALUES (1,'Recruiter'), (2,'Job Seeker');

-- create table_2: users
-- colmm: user_id, email, active, password, reg_date, user_type_id 
CREATE TABLE `users` (
	`user_id` int NOT NULL AUTO_INCREMENT,
    `email` varchar(255) DEFAULT NULL,
    `active` bit(1) DEFAULT NULL,
    `password` varchar(255) DEFAULT NULL,
    `reg_date` datetime(6) DEFAULT NULL,
    `user_type_id` int DEFAULT NULL,
    PRIMARY KEY (`user_Id`),
    UNIQUE KEY (`email`),
    CONSTRAINT FOREIGN KEY (`user_type_id`) REFERENCES `user_type`(`user_type_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- create table_3: job_company
-- column: company_id, logo, name
CREATE TABLE `job_company` (
	`company_id` int NOT NULL AUTO_INCREMENT,
    `logo` varchar(255) DEFAULT NULL,
    `name` varchar(255) DEFAULT NULL,
    PRIMARY KEY (`company_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- create table_4: job_location
-- column: location_id, city, country, state
CREATE TABLE `job_location` (
	`location_id` int NOT NULL AUTO_INCREMENT,
    `city` varchar(255) DEFAULT NULL,
    `country` varchar(255) DEFAULT NULL,
    `state` varchar(255) DEFAULT NULL,
    PRIMARY KEY (`location_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- create table_5: job_seeker_profile
-- column: account_id, city, country, state, employment_type, first_name, last_name, profile_photo, resume, work_authorization
CREATE TABLE `job_seeker_profile` (
	`account_id` int NOT NULL AUTO_INCREMENT,
    `city` varchar(255) DEFAULT NULL,
    `country` varchar(255) DEFAULT NULL,
    `state` varchar(255) DEFAULT NULL,
    `employment_type` varchar(255) DEFAULT NULL,
    `first_name` varchar(255) DEFAULT NULL,
    `last_name` varchar(255) DEFAULT NULL,
    `profile_photo` varchar(255) DEFAULT NULL,
    `resume` varchar(255) DEFAULT NULL,
    `work_authorization` varchar(255) DEFAULT NULL,
    PRIMARY KEY (`account_id`),
	CONSTRAINT FOREIGN KEY (`account_id`) REFERENCES `users`(`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- create table_6: recruiter_profile
-- column: account_id, city, country, state, company, first_name, last_name, profile_photo
CREATE TABLE `recruiter_profile`(
	`account_id` int NOT NULL AUTO_INCREMENT,
	`city` varchar(255) DEFAULT NULL,
    `country` varchar(255) DEFAULT NULL,
    `state` varchar(255) DEFAULT NULL, 
    `company` varchar(255) DEFAULT NULL,
    `first_name` varchar(255) DEFAULT NULL,
    `last_name` varchar(255) DEFAULT NULL,
    `profile_photo` varchar(255) DEFAULT NULL,
    PRIMARY KEY (`account_id`),
    CONSTRAINT FOREIGN KEY (`account_id`) REFERENCES `users`(`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- create table_7: job_post_activity
-- column: job_post_id, job_description, job_title, job_type, posted_date, remote, salary, job_company_id, job_location_id, posted_by_id
CREATE TABLE `job_post_activity`(
	`job_post_id` int NOT NULL AUTO_INCREMENT,
    `job_description` varchar(10000) DEFAULT NULL,
    `job_title` varchar(255) DEFAULT NULL,
    `job_type` varchar(255) DEFAULT NULL,
    `posted_date` datetime(6) DEFAULT NULL,
    `remote` varchar(255) DEFAULT NULL,
    `salary` varchar(255) DEFAULT NULL,
    `job_company_id` int DEFAULT NULL,
    `job_location_id` int DEFAULT NULL,
    `posted_by_id` int DEFAULT NULL,
    PRIMARY KEY (`job_post_id`),
    KEY (`job_company_id`),
    KEY (`job_location_id`),
    KEY (`posted_by_id`),
    CONSTRAINT FOREIGN KEY (`job_company_id`) REFERENCES `job_company`(`company_id`),
    CONSTRAINT FOREIGN KEY (`job_location_id`) REFERENCES `job_location`(`location_id`),
	CONSTRAINT FOREIGN KEY (`posted_by_id`) REFERENCES `users`(`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- create table_8: job_seeker_save
-- column: id, job_id, user_id
CREATE TABLE `job_seeker_save`(
	`id` int NOT NULL AUTO_INCREMENT,
    `job_id` int DEFAULT NULL,
    `user_id` int DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY (`job_id`, `user_id`),
    KEY (`job_id`),
    CONSTRAINT FOREIGN KEY (`job_id`) REFERENCES `job_post_activity`(`job_post_id`),
    CONSTRAINT FOREIGN KEY (`user_id`) REFERENCES `job_seeker_profile`(`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- create table_9: job_seeker_apply
-- column: apply_id, apply_date, cover_letter, job_id, user_id
CREATE TABLE `job_seeker_apply`(
	`apply_id` int NOT NULL AUTO_INCREMENT,
    `apply_date` datetime(6) DEFAULT NULL,
    `cover_letter` varchar(255) DEFAULT NULL,
    `job_id` int DEFAULT NULL,
    `user_id` int DEFAULT NULL,
    PRIMARY KEY (`apply_id`),
    UNIQUE KEY (`job_id`,`user_id`),
    KEY (`job_id`),
    CONSTRAINT FOREIGN KEY (`job_id`) REFERENCES `job_post_activity`(`job_post_id`),
    CONSTRAINT FOREIGN KEY (`user_id`) REFERENCES `job_seeker_profile`(`account_id`)
)  ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- create table_10: skills
-- column: id, skill_name, skill_experience, skill_level, job_seeker_profile
CREATE TABLE `skills`(
	`id` int NOT NULL AUTO_INCREMENT,
    `skill_name` varchar(255) DEFAULT NULL,
    `skill_experience` varchar(255) DEFAULT NULL,
    `skill_level` varchar(255) DEFAULT NULL,
    `job_seeker_profile` int DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY (`job_seeker_profile`),
    CONSTRAINT FOREIGN KEY (`job_seeker_profile`) REFERENCES `job_seeker_profile`(`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;








