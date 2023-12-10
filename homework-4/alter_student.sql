-- 1. Создать таблицу student с полями student_id serial, first_name varchar,
--    last_name varchar, birthday date, phone varchar
create table student
(
	student_id serial primary key,
	first_name varchar(50),
	last_name varchar(50),
	birthday date,
	phone varchar(11)
);

-- 2. Добавить в таблицу student колонку middle_name varchar
alter table student add column middle_name varchar(50);

-- 3. Удалить колонку middle_name
alter table student drop column middle_name;

-- 4. Переименовать колонку birthday в birth_date
alter table student rename column birthday to birth_date;

-- 5. Изменить тип данных колонки phone на varchar(32)
alter table student alter column phone set data type varchar(32);

-- 6. Вставить три любых записи с автогенерацией идентификатора
insert into student (first_name, last_name, birth_date, phone)
values ('Иван', 'Иванов', '1983-12-15', '8(963)45345678');
insert into student (first_name, last_name, birth_date, phone)
values ('Семён', 'Петров', '1985-11-12', '+7(965)45345348');
insert into student (first_name, last_name, birth_date, phone)
values ('Светлана', 'Соколова', '1995-10-03', '8(961)32321348');

-- 7. Удалить все данные из таблицы со сбросом идентификатор в исходное состояние
TRUNCATE TABLE student RESTART IDENTITY;