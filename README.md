# PoliceRP
This is a reupload of the main PoliceRP server. The reason we didn't make the original repo public is because there is a lot of private data in the git history (Webhook/passwords/paid addon). Here is a fresh reupload with all the sensitive information removed.

# What is included?
Included is the entire policerp server with any paid addons removed. Any public addons used are still in the repo. For the most part, you should be able to just load the server if you create the right database connections and manually create the tables for the required addons

# Table creation statements

## Auction House
```
CREATE TABLE `auction_active_listings` (
 `id` int(255) NOT NULL AUTO_INCREMENT,
 `userid` varchar(255) NOT NULL,
 `name` varchar(255) NOT NULL,
 `model` varchar(510) NOT NULL,
 `price` int(255) NOT NULL,
 `quantity` int(255) NOT NULL,
 `type` varchar(255) NOT NULL,
 `class` varchar(255) NOT NULL,
 `length` int(255) NOT NULL,
 `data` text NOT NULL,
 `server` int(2) DEFAULT NULL,
 `current_bid` int(255) DEFAULT NULL,
 `ended` int(1) DEFAULT NULL,
 `created` int(255) NOT NULL,
 PRIMARY KEY (`id`),
 KEY `current_bid` (`current_bid`)
) 
```
```
CREATE TABLE `auction_bids` (
 `id` int(255) NOT NULL AUTO_INCREMENT,
 `listing` int(255) NOT NULL,
 `userid` varchar(255) NOT NULL,
 `amount` int(255) NOT NULL,
 `created` int(255) NOT NULL,
 PRIMARY KEY (`id`),
 KEY `listing` (`listing`),
 CONSTRAINT `auction_bids_ibfk_1` FOREIGN KEY (`listing`) REFERENCES `auction_active_listings` (`id`)
)
```
```
CREATE TABLE `auction_notifications` (
 `id` int(255) NOT NULL AUTO_INCREMENT,
 `userid` varchar(255) NOT NULL,
 `message` text NOT NULL,
 `created` int(255) NOT NULL,
 PRIMARY KEY (`id`)
)
```
## Badges
```
	
CREATE TABLE `badges` (
 `userid` bigint(32) DEFAULT NULL,
 `badge` varchar(64) DEFAULT NULL,
 `progress` text,
 `complete` text,
 UNIQUE KEY `unique_index` (`userid`,`badge`)
)
```
## Inventory
```
CREATE TABLE `inventories` (
 `id` int(11) NOT NULL AUTO_INCREMENT,
 `userid` varchar(32) NOT NULL,
 `item` text NOT NULL,
 `data` text,
 PRIMARY KEY (`id`)
) 
```
```
CREATE TABLE `banks` (
 `id` int(11) NOT NULL AUTO_INCREMENT,
 `userid` varchar(32) NOT NULL,
 `item` text NOT NULL,
 `data` text,
 PRIMARY KEY (`id`)
)
```
## DMV
```
CREATE TABLE `dmv_license` (
 `steamid` text,
 `date` text,
 `points` int(11) DEFAULT '0'
)
```
```
CREATE TABLE `dmv_revokes` (
 `steamid` varchar(128) NOT NULL,
 `date` text NOT NULL,
 `total` int(11) NOT NULL DEFAULT '1',
 PRIMARY KEY (`steamid`)
) 
```
## Economy Stats
```
CREATE TABLE `economy_stats` (
 `date` date NOT NULL,
 `circulating` bigint(64) NOT NULL
)
```
## Gov Tags
```
CREATE TABLE `gov_tag` (
 `userid` varchar(32) NOT NULL,
 `tag` int(4) NOT NULL,
 PRIMARY KEY (`userid`)
)
```
## Impound
```
CREATE TABLE `impound` (
 `id` int(32) NOT NULL,
 `impounder` varchar(32) DEFAULT NULL,
 PRIMARY KEY (`id`)
) 
```
## Job Tracker
```
CREATE TABLE `job_tracker` (
 `id` int(11) NOT NULL AUTO_INCREMENT,
 `userid` varchar(32) NOT NULL,
 `join` int(11) NOT NULL,
 `leave` int(11) DEFAULT NULL,
 `job` varchar(64) NOT NULL,
 `jobType` varchar(32) NOT NULL,
 PRIMARY KEY (`id`)
)
```
```
CREATE TABLE `job_tracker_promo` (
 `id` int(11) NOT NULL AUTO_INCREMENT,
 `userid` varchar(32) NOT NULL,
 `promoter` varchar(32) NOT NULL,
 `time` int(11) DEFAULT NULL,
 `job` varchar(64) NOT NULL,
 `jobType` varchar(32) NOT NULL,
 `state` varchar(10) NOT NULL,
 PRIMARY KEY (`id`)
)
```
## Meeting Logs
```
CREATE TABLE `meeting_logs` (
 `host_id` text,
 `dep` text,
 `reason` text,
 `length` int(11) DEFAULT NULL,
 `crime` tinyint(1) DEFAULT NULL
)
```
## Mining
```
CREATE TABLE `mining_inv` (
 `userid` varchar(32) NOT NULL,
 `ore` varchar(32) NOT NULL,
 `amount` int(11) NOT NULL,
 UNIQUE KEY `unique_index` (`userid`,`ore`)
)
```
## Orgs
```
CREATE TABLE `orgs` (
 `id` int(11) NOT NULL AUTO_INCREMENT,
 `name` text NOT NULL,
 `xp` int(11) NOT NULL DEFAULT '1000',
 `funds` int(11) NOT NULL DEFAULT '0',
 `upgrades` json NOT NULL,
 `roles` json NOT NULL,
 `achievements` json NOT NULL,
 PRIMARY KEY (`id`),
 KEY `id` (`id`)
) 
```
```
CREATE TABLE `orgs_members` (
 `steamid` varchar(64) NOT NULL,
 `orgid` int(11) NOT NULL,
 `role` tinyint(4) NOT NULL,
 KEY `org` (`orgid`),
 CONSTRAINT `org` FOREIGN KEY (`orgid`) REFERENCES `orgs` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) 
```
```
CREATE TABLE `orgs_inventories` (
 `orgid` int(11) NOT NULL,
 `item` text NOT NULL,
 `data` text,
 KEY `orgi` (`orgid`),
 CONSTRAINT `orgi` FOREIGN KEY (`orgid`) REFERENCES `orgs` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
)
```
## Play Time
```
CREATE TABLE `play_time` (
 `userid` text,
 `total` int(11) DEFAULT NULL,
 `last` int(11) DEFAULT NULL
)
```
## PNC
```
CREATE TABLE `pnc_911` (
 `userid` varchar(32) NOT NULL,
 `name` varchar(128) NOT NULL,
 `reason` varchar(500) NOT NULL,
 `time` int(11) NOT NULL
)
```
```
CREATE TABLE `pnc_911_new` (
 `id` int(11) NOT NULL AUTO_INCREMENT,
 `userid` varchar(32) NOT NULL,
 `name` varchar(128) NOT NULL,
 `reason` varchar(500) NOT NULL,
 `responders` text,
 `time` int(11) NOT NULL,
 PRIMARY KEY (`id`)
)
```
```
CREATE TABLE `pnc_confiscated` (
 `userid` varchar(32) NOT NULL,
 `username` varchar(32) NOT NULL,
 `officerid` varchar(32) NOT NULL,
 `officername` varchar(32) NOT NULL,
 `class` varchar(128) NOT NULL,
 `name` varchar(500) NOT NULL,
 `time` int(11) NOT NULL
) 
```
```
CREATE TABLE `pnc_tickets` (
 `userid` varchar(32) NOT NULL,
 `ticketby` varchar(32) NOT NULL,
 `time` int(11) NOT NULL,
 `charges` json NOT NULL
)
```
```
CREATE TABLE `pnc_arrests` (
 `userid` varchar(32) NOT NULL,
 `arrestby` varchar(32) NOT NULL,
 `time` int(11) NOT NULL,
 `charges` json NOT NULL
)
```
## Quests
```
CREATE TABLE `quest_progress` (
 `userid` varchar(17) NOT NULL,
 `story_id` varchar(128) NOT NULL,
 `quest_id` int(32) NOT NULL,
 `data` text,
 `complete` tinyint(1) NOT NULL DEFAULT '0',
 `started` int(32) NOT NULL,
 `finished` int(32) DEFAULT NULL,
 UNIQUE KEY `unique_index` (`userid`,`story_id`,`quest_id`)
) 
```
## Rewards
```
CREATE TABLE `rewards` (
 `userid` varchar(32) NOT NULL,
 `type` varchar(64) NOT NULL,
 `progress` int(32) DEFAULT NULL,
 `updated` int(32) NOT NULL,
 UNIQUE KEY `unique_index` (`userid`,`type`)
) 
```
## Car Dealer
```
CREATE TABLE `vehicles` (
 `id` int(32) NOT NULL AUTO_INCREMENT,
 `userid` varchar(32) NOT NULL,
 `class` varchar(128) NOT NULL,
 `color` varchar(128) NOT NULL,
 `skin` int(2) NOT NULL,
 `bodygroups` varchar(256) NOT NULL,
 `mods` varchar(256) NOT NULL,
 `performance` varchar(256) NOT NULL,
 `damage` varchar(256) NOT NULL,
 PRIMARY KEY (`id`)
)
```
## Chat Tags
```
CREATE TABLE `user_tags` (
 `userid` varchar(255) NOT NULL,
 `tag` text,
 `color` text,
 PRIMARY KEY (`userid`)
)
```
## Weapon Skins
```
CREATE TABLE `wep_skins` (
 `userid` varchar(32) NOT NULL,
 `wep` varchar(128) NOT NULL,
 `skin` varchar(64) NOT NULL,
 UNIQUE KEY `unique_index` (`userid`,`wep`)
)
```
## Christmas Content
```
CREATE TABLE `christmas_credits` (
 `userid` varchar(32) NOT NULL,
 `credits` int(11) DEFAULT NULL,
 PRIMARY KEY (`userid`)
) 
```
```
CREATE TABLE `advent_doors` (
 `userid` varchar(32) NOT NULL,
 `door` int(11) DEFAULT NULL,
 `reward` varchar(32) NOT NULL
)
```