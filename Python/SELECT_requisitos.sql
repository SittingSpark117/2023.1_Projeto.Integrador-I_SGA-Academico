SELECT * FROM aluno;

--- Cadastrar alunos:
INSERT INTO aluno (ra,nome_aluno,cpf,data_nasc,genero,email,cep,cod_curso,nota_redacao,aceros_vestibular) 
VALUES ('..........');

--- Lançar notas de alunos:
INSERT INTO notas (cod_disciplina,ra ,n_prova, nota_tirada, semestre_ano) 
VALUES ('MBI100', 203407072, 1,7.50, '2023.1');
SELECT * FROM notas;

--- Abaixo da Média
SELECT a.nome_aluno, n.nota_tirada
FROM aluno a
JOIN notas n ON a.ra = n.ra
WHERE n.nota_tirada < (SELECT AVG(nota_tirada) FROM notas);

--- Frequência Abaixo dos 70%
SELECT a.nome_aluno, f.frequencia_total
FROM aluno a
JOIN frequencia f ON a.ra = f.ra
WHERE f.frequencia_total < 70;


SELECT *
FROM frequencia
WHERE ra = ra;


