/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50716
Source Host           : localhost:3306
Source Database       : db_news

Target Server Type    : MYSQL
Target Server Version : 50716
File Encoding         : 65001

Date: 2017-05-01 19:56:53
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `t_comment`
-- ----------------------------
DROP TABLE IF EXISTS `t_comment`;
CREATE TABLE `t_comment` (
  `commentId` int(11) NOT NULL AUTO_INCREMENT,
  `newsId` int(11) DEFAULT NULL,
  `content` varchar(300) DEFAULT NULL,
  `userIP` varchar(40) DEFAULT NULL,
  `commentDate` datetime DEFAULT NULL,
  PRIMARY KEY (`commentId`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_comment
-- ----------------------------
INSERT INTO `t_comment` VALUES ('1', '2', 'fuck', '127.0.0.1', '2017-04-09 14:32:40');
INSERT INTO `t_comment` VALUES ('2', '3', 'shit', '127.0.0.1', '2017-04-09 14:33:06');
INSERT INTO `t_comment` VALUES ('3', '1', '算法', '0:0:0:0:0:0:0:1', '2017-04-15 18:23:17');
INSERT INTO `t_comment` VALUES ('7', '1', '递归', '0:0:0:0:0:0:0:1', '2017-04-15 18:26:05');
INSERT INTO `t_comment` VALUES ('9', '2', '阿斯顿', '0:0:0:0:0:0:0:1', '2017-04-15 18:32:57');
INSERT INTO `t_comment` VALUES ('10', '3', '刚刚收到个', '0:0:0:0:0:0:0:1', '2017-04-20 18:21:53');
INSERT INTO `t_comment` VALUES ('12', '3', '阿哥啊', '0:0:0:0:0:0:0:1', '2017-04-20 18:21:59');
INSERT INTO `t_comment` VALUES ('17', '8', '的v', '0:0:0:0:0:0:0:1', '2017-04-21 12:37:22');
INSERT INTO `t_comment` VALUES ('18', '1', '是个 ', '0:0:0:0:0:0:0:1', '2017-04-27 19:54:14');

-- ----------------------------
-- Table structure for `t_link`
-- ----------------------------
DROP TABLE IF EXISTS `t_link`;
CREATE TABLE `t_link` (
  `linkId` int(11) NOT NULL AUTO_INCREMENT,
  `linkName` varchar(30) DEFAULT NULL,
  `linkUrl` varchar(40) DEFAULT NULL,
  `linkEmail` varchar(40) DEFAULT NULL,
  `orderNum` int(11) DEFAULT NULL,
  PRIMARY KEY (`linkId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_link
-- ----------------------------
INSERT INTO `t_link` VALUES ('1', 'google', 'https://www.google.com', 'null', '1');
INSERT INTO `t_link` VALUES ('2', '百度', 'http://www.baidu.com', 'null', '3');
INSERT INTO `t_link` VALUES ('3', 'Diary', 'http://182.254.208.159:8080/Diary', '1054390839@qq.com', '2');
INSERT INTO `t_link` VALUES ('4', '开源中国', 'http://www.oschina.net', 'freedomfanye@gmail.com', '6');

-- ----------------------------
-- Table structure for `t_news`
-- ----------------------------
DROP TABLE IF EXISTS `t_news`;
CREATE TABLE `t_news` (
  `newsId` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(40) DEFAULT NULL,
  `content` text,
  `publishDate` datetime DEFAULT NULL,
  `author` varchar(20) DEFAULT NULL,
  `typeId` int(11) NOT NULL,
  `click` int(11) DEFAULT NULL,
  `isHead` tinyint(4) DEFAULT NULL,
  `isImage` tinyint(4) DEFAULT NULL,
  `imageName` varchar(30) DEFAULT NULL,
  `isHot` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`newsId`),
  KEY `typeId` (`typeId`),
  CONSTRAINT `t_news_ibfk_1` FOREIGN KEY (`typeId`) REFERENCES `t_newstype` (`newsTypeId`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_news
-- ----------------------------
INSERT INTO `t_news` VALUES ('1', '今天真高兴啊', '打击感的感觉是你当啊离开电脑发空间你g', '2017-04-10 13:14:09', '爸爸', '1', '32', '0', '1', '70jiyi.jpg', '0');
INSERT INTO `t_news` VALUES ('2', '发', '发射点说的格式', '2017-04-10 13:15:19', '十多个', '2', '15', '0', '1', 'beipiao.jpg', '0');
INSERT INTO `t_news` VALUES ('3', '冯绍峰', '方式格式十多年送搞点你手动哦啊的哦啊法莫丝佛啊', '2017-04-10 13:15:43', '感受到', '3', '16', '1', '1', 'shaolingsi.jpg', '0');
INSERT INTO `t_news` VALUES ('4', '三国杀', '是公司打工什么的公司没毛i到底狗i是狗i是dog i山东i那时士大夫 是打工i', '2017-04-10 13:16:14', '水泥地', '4', '7', '0', '1', 'tiaoweishi.jpg', '0');
INSERT INTO `t_news` VALUES ('5', '弄死', '搞i哦那个i能够i死难过哦i速度', '2017-04-10 13:16:36', '士大夫', '5', '10', '0', '1', 'yesong.jpg', '0');
INSERT INTO `t_news` VALUES ('6', '烦恼', '附属公司棍isidro您死覅是地闹id发', '2017-04-10 13:16:59', '算法', '6', '5', '0', '0', 'null', '1');
INSERT INTO `t_news` VALUES ('7', '十多个', '<p>摄氏度华氏度还是</p>\r\n', '2017-04-21 12:31:36', null, '2', '2', '0', '0', null, '0');
INSERT INTO `t_news` VALUES ('8', '法饿饭', '<p><img alt=\"\" src=\"userImage/20170421123511.jpg\" /></p>\r\n\r\n<p>gaf adg a a功能的烦恼id能够i啊</p>\r\n', '2017-04-21 12:35:26', null, '5', '5', '1', '1', '20170421123526.jpg', '3');
INSERT INTO `t_news` VALUES ('9', '个', '<p>公司公司分公司的公司公司的公司</p>\r\n', '2017-04-21 16:11:52', '说的格式的', '2', '0', '0', '0', null, '0');
INSERT INTO `t_news` VALUES ('10', '都是高手s', '<p>公司公司打工十多个十多个十多个是</p>\r\n', '2017-04-21 16:12:34', '公司公司的', '5', '0', '0', '0', null, '0');
INSERT INTO `t_news` VALUES ('12', '是', '<p>阿斯弗</p>\r\n', '2017-04-21 17:03:53', '算法', '3', '0', '0', '0', null, '0');
INSERT INTO `t_news` VALUES ('13', '是', '<p>阿斯弗</p>\r\n', '2017-04-21 17:05:00', '算法', '3', '0', '0', '0', null, '0');

-- ----------------------------
-- Table structure for `t_newstype`
-- ----------------------------
DROP TABLE IF EXISTS `t_newstype`;
CREATE TABLE `t_newstype` (
  `newsTypeId` int(11) NOT NULL AUTO_INCREMENT,
  `typeName` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`newsTypeId`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_newstype
-- ----------------------------
INSERT INTO `t_newstype` VALUES ('1', '时政新闻');
INSERT INTO `t_newstype` VALUES ('2', '科教文卫');
INSERT INTO `t_newstype` VALUES ('3', '政法新闻');
INSERT INTO `t_newstype` VALUES ('4', '娱乐新闻');
INSERT INTO `t_newstype` VALUES ('5', '体育新闻');
INSERT INTO `t_newstype` VALUES ('6', '军事新闻');

-- ----------------------------
-- Table structure for `t_user`
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
  `userId` int(11) NOT NULL AUTO_INCREMENT,
  `userName` varchar(20) DEFAULT NULL,
  `password` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES ('1', 'admin', '123456');
