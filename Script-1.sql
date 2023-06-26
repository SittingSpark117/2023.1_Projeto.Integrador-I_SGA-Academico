

--SELECTS TABELAS--




select * from aluno limit 40

select * from aulas
where cod_disciplina ='ADS100' 

select * from curso 
order by campus 

select * from frequencia 

select * from matricula;


select * from endereco 

select cep from endereco order by RANDOM() limit 1

select * from notas

select * from presenca
where cod_disciplina ='MBI102'

select * from professor where cep ='5744302' 

select * from  oferecimento  

select cod_disciplina, semestre_ano from  oferecimento  

select * from curso  
select distinct cod_curso  from curso  

select * from frequencia
where ra = 203802970




select * from disciplina 
where  periodo ='1'

select * from aulas








select * from  presenca
where cod_disciplina ='MBI100' and ra ='203407072'

select * from presenca 


DELETE FROM presenca
WHERE cod_disciplina like 'G%';


INSERT INTO aulas (cod_disciplina, n_aula, conteudo, registro_prof, data)
VALUES ('ADS100', 1, 'Conteúdo da aula 1', 184844018, '2023-06-19');









select nome_disciplina, periodo, carga_horaria, cod_curso 
from disciplina 
order by cod_curso, periodo, nome_disciplina;





select distinct c.cod_curso, nome_curso 
from disciplina as d
inner join curso as c
on c.cod_curso=d.cod_curso 


select * from aluno as a
inner join disciplina as d 
on a.cod_curso=d.cod_curso 
where d.periodo ='1'



select * from professor 
where cod_curso ='ADS6'

select * from disciplina where cod_curso = 'ADS6' and periodo ='1'


--quantidade de professores por curso --
select  count(registro_prof) as prof, nome_curso from professor as p, curso as c
where p.cod_curso=c.cod_curso 
group by nome_curso



--quantidade de alunos por curso --
select  count(ra) as alunos, nome_curso from aluno as a, curso as c
where a.cod_curso=c.cod_curso 
group by nome_curso

--quantidade de disciplinas por curso (com periodo 1)--
select  d.cod_curso, count(cod_disciplina) as discP_curso
from curso as c
inner join  disciplina as d
on c.cod_curso=d.cod_curso 
where d.periodo ='1'
group by d.cod_curso
order by discP_curso desc   




DROP TABLE oferecimento
ALTER TABLE oferecimento
ADD dia_semana varchar(15),



ALTER TABLE turma
ADD fk_aluno int,
ADD fk_disciplina varchar;


INSERT INTO aluno (ra, nome_aluno, cpf, data_nasc, genero, email, cep, cod_curso, nota_redacao, acertos_vestibular)
VALUES (208468589, 'Mtheuss', '47137708846', '1997-04-23', 'Masculino', 'guilherme.d@gmail.com', '1459672 ', 'SEC6','1144',50)



select distinct ra from prova  

ALTER TABLE turma
ADD CONSTRAINT fk_aluno FOREIGN KEY (fk_aluno) REFERENCES aluno (ra),
ADD CONSTRAINT fk_disciplina FOREIGN KEY (fk_disciplina) REFERENCES disciplina (cod_disciplina);











insert into notas (cod_disciplina,n_prova,ra,nota_tirada) 
values ('RD102',2,836092450,4.5)




UPDATE notas
SET semestre_ano = '2023.1';





------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------
--CRUD DE NOTAS--

--lista de cursos com disciplinas--
select distinct (nome_curso), c.cod_curso  from curso as c ,disciplina as d
where  d.cod_curso  = c.cod_curso

--lista de disciplinas por curso (Primeiro semestre)--
select cod_disciplina, nome_disciplina from disciplina 
where cod_curso = 'GDTI6' and periodo = '1'



--lista notas por disciplina--
select nome_aluno, n_prova, nota_tirada  
from notas as n
inner join aluno as a 
on n.ra = a.ra 
where cod_disciplina = 'RD100'
order by nome_aluno, n_prova


--lista medias por aluno--
SELECT a.nome_aluno, (SUM(n.nota_tirada) - MIN(n.nota_tirada)) / (COUNT(n.nota_tirada) - 1) as media
FROM notas AS n
INNER JOIN aluno AS a ON n.ra = a.ra
INNER JOIN disciplina AS d ON n.cod_disciplina = d.cod_disciplina
WHERE d.cod_disciplina = 'RD100'
GROUP BY a.nome_aluno
order by media desc 

---------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------
--CRUD DE PRESENCA--

--presença de alunos por aula--
select nome_aluno, presente, n_aula from presenca as p
inner join aluno as a on p.ra =a.ra 
inner join disciplina as d on d.cod_disciplina = p.cod_disciplina 
WHERE p.cod_disciplina = 'RD100' and n_aula = 0


select nome_aluno, count(presente) as presenca from presenca as p
inner join aluno as a on p.ra =a.ra 
inner join disciplina as d on d.cod_disciplina = p.cod_disciplina 
having  p.cod_disciplina = 'RD100' and presente = true 
group by nome_aluno

--registro de presença por disciplina por auluno--
select nome_aluno, p.n_aula, presente, data_aula from presenca as p
inner join aluno as al on p.ra = al.ra
inner join aulas as a on a.cod_disciplina = p.cod_disciplina and p.n_aula = a.n_aula 
WHERE p.cod_disciplina = 'RD100' and al.nome_aluno = 'Anna Silva'





--lista média por disciplinas--
SELECT nome_disciplina, ROUND((SUM(nota_tirada) - MIN(nota_tirada)) / (COUNT(nota_tirada) - 1), 2) as media
FROM (
  SELECT a.nome_aluno, d.nome_disciplina, n.n_prova, n.nota_tirada
  FROM notas AS n
  INNER JOIN aluno AS a ON a.ra = n.ra
  INNER JOIN disciplina AS d ON d.cod_disciplina = n.cod_disciplina
  WHERE a.nome_aluno = 'Thainá Binello'
) AS notas_aluno
GROUP BY nome_disciplina;


--seleção de notas por alunos-- 
select a.nome_aluno,d.nome_disciplina, n.n_prova, n.nota_tirada  
from notas as n
inner join aluno as a
on a.ra = n.ra 
inner join disciplina as d 
on d.cod_disciplina = n.cod_disciplina 
where a.nome_aluno = 'Thiago Miura'








