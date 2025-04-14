Q1:departmentsテーブルの追加

CREATE TABLE departments(
	department_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
	name VARCHAR(20) NOT NULL,
	created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (department_id)
);

Q2:peopleテーブルにdepartment_idを追加

ALTER TABLE people
ADD COLUMN department_id INT(10) UNSIGNED NULL AFTER email

Q3:三つのテーブルにレコードを追加

departmentsテーブルにレコードを追加
INSERT INTO departments (name)
VALUES
	('営業'),
	('開発'),
	('経理'),
	('人事'),
	('情報システム');

department_id:
1:営業
2:開発
3:経理
4:人事
5:情報システム

peopleテーブルにレコードを追加
INSERT INTO people (
	name,
	email,
	department_id,
	age,
	gender)
VALUES
('ジョンソン','jon@gizumo.jp',1,29,1),
('マイケル','mike@gizumo.jp',1,28,1),
('ベンジャミン','benn@gizumo.jp',1,27,1),
('ガッツマン','gat@gizumo.jp',2,26,1),
('ガーディアン','gardin@gizumo.jp',2,25,1),
('ソミア','somi@gizumo.jp',2,24,2),
('ジェニファー','jeny@gizumo.jp',2,23,2),
('ティファ','tifa@gizumo.jp',3,22,2),
('スミソニアン','sumi@gizumo.jp',4,21,2),
('ケイティー','keity@gizumo.jp',5,20,2);

gender:
1:男
2:女

reportsテーブルにレコードを追加
INSERT INTO reports(
	person_id,
	content)
VALUES
(1,"こんにちは、鈴木です"),
(2,"こんにちは、田中です"),
(10,"こんばんは、ガッツマンです"),
(15,"こんばんは、スミソニアンです"),
(9,"おはようございます、ベンジャミンぐす"),
(4,"こんにちは、豊島はなこです"),
(7,"ハロー！ジョンソンです"),
(12,"こんにちは！ソミアです"),
(14,"おはようございます！ティファです"),
(3,"おはようございます！福田です");

Q4:department_idがNULLであるレコードのdepartment_idを存在するidに変更

UPDATE people
SET department_id=1
WHERE department_id IS NULL;

Q5:年齢の降順で男性の名前と年齢を取得してください。 

SELECT name,age
     FROM people
     WHERE gender=1
     ORDER by age DESC;

Q6:テーブル・レコード・カラムという3つの単語を適切に使用して、下記のSQL文を日本語で説明してください。

SELECT
  `name`, `email`, `age`
FROM
  `people`
WHERE
  `department_id` = 1
ORDER BY
  `created_at`;

回答:このSQL文は、peopleテーブルから、department_idが1であるレコードを検索し、name、email、ageの3つのカラムに絞って、created_atの値を基準に昇順で結果を取得するクエリです。

Q7:20代の女性と40代の男性の名前一覧を取得してください。

SELECT name
FROM people
WHERE (gender=2 AND age BETWEEN 20 AND 29)
OR (gender=1 AND age BETWEEN 40 AND 49)

Q8:営業部に所属する人だけを年齢の昇順で取得してください。

SELECT age
FROM people
WHERE department_id=1
ORDER BY age ASC

Q9:開発部に所属している女性の平均年齢を取得してください。

SELECT AVG(age) AS average_age
FROM people
WHERE gender=2 AND department_id=2; 

Q10:名前と部署名とその人が提出した日報の内容を同時に取得してください。（日報を提出していない人は含めない）

SELECT
  people.name AS 名前,
  departments.name AS 部署名,
  reports.content AS 日報内容
FROM
  reports
INNER JOIN people ON reports.person_id = people.person_id
INNER JOIN departments ON people.department_id = departments.department_id;

Q11:日報を一つも提出していない人の名前一覧を取得してください。

SELECT people.name AS 日報未提出者名前
FROM people
LEFT JOIN reports ON people.person_id = reports.person_id
WHERE reports.person_id IS NULL;
