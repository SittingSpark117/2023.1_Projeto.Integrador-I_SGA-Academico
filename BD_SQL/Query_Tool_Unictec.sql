---1. TABELA CURSO com INSERTS dos Cursos

DROP TABLE IF EXISTS curso CASCADE;
CREATE TABLE curso(
cod_curso VARCHAR(6) NOT NULL PRIMARY KEY,
nome_curso VARCHAR(50) NOT NULL,
qntd_semestres CHAR(2) NOT NULL,
tipo VARCHAR(30) CHECK (tipo IN ('Bacharelado', 'Tecnologo')),
turno_curso VARCHAR(30) CHECK (turno_curso IN ('Matutino','Vespertino', 'Noturno')),
campus VARCHAR(30) NOT NULL,
data_criacao timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP);

INSERT INTO curso VALUES ('ADS6', 'Análise e Desenvolvimento de Sistemas', 6, 'Tecnologo', 'Vespertino', 'CentroLeste'),
('MBI6', 'Business Intelligence e Mineração de Dados', 6, 'Tecnologo', 'Noturno', 'MatrizSul'),
('BDN8', 'Big Data para Negócios', 8, 'Tecnologo', 'Noturno', 'CentroLeste'),
('GDTI6', 'Gestão da Tecnologia da Informação', 6, 'Tecnologo', 'Noturno', 'Ipiranga'),
('SEC6', 'Segurança Cibernética', 6, 'Tecnologo', 'Noturno', 'Interlagos'),
('SI10', 'Sistemas de Informação', 8, 'Bacharelado', 'Noturno', 'Ipiranga'),
('TSI10', 'Tecnologia em Sistemas de Informação', 6, 'Bacharelado', 'Matutino', 'PresidentePrudente'),
('RDS8', 'Redes de Computadores e Sistemas Distribuídos', 8, 'Bacharelado', 'Noturno', 'Interlagos');

SELECT * FROM CURSO;

---2. TABELA ENDERECO

DROP TABLE IF EXISTS endereco CASCADE;
CREATE TABLE endereco (
cep CHAR(8) NOT NULL PRIMARY KEY,
n_residencia INT NOT NULL,
logradouro VARCHAR (40) NOT NULL);

-- Insert de endec professores

INSERT INTO endereco VALUES
(2929670,595,'Rua Carlos José de Castilho'),
(1077375,596,'Alameda Ibiracemas'),
(5526601,864,'Rua Carneiro Leão'),
(5115132,175,'Avenida Onze de Junho'),
(1318103,79,'Rua Filadélphia'),
(5476761,829,'Rua Engenheiro Toledo Malta'),
(1677625,298,'Rua Delfino Casal de Rey'),
(1968324,110,'Rua General Costa Campos'),
(5488783,963,'Rua Barão da Cunha de Araripe'),
(2189927,927,'Praça José Moreno'),
(5606558,560,'Rua Caiabu'),
(4831552,483,'Rua Desembargador Isnard dos Reis'),
(5751957,627,'Praça Argemiro Alves de Sá'),
(1713238,335,'Rua Emílio Baumgart'),
(3646124,993,'Rua Frei Galvão'),
(4111960,267,'Rua Dario Vilares Barbosa'),
(4803986,847,'Rua Aracari'),
(2683518,28,'Rua Benício José da Fonseca'),
(5744302,107,'Alameda Olga'),
(5856565,603,'Rua Eusébio da Silva');


---3 Criando a Tabela Aluno e Professor (com as FKS)

---3.1 Tabela Aluno

DROP TABLE IF EXISTS aluno CASCADE;
CREATE TABLE aluno (
ra INT PRIMARY KEY,
nome_aluno VARCHAR(100) NOT NULL,
cpf VARCHAR(11) NOT NULL,
data_nasc DATE NOT NULL,
genero VARCHAR(20) NOT NULL CHECK (genero IN('Masculino', 'Feminino')),
email VARCHAR(32) NOT NULL,
cep CHAR(8) NOT NULL, 
cod_curso CHAR(6) NOT NULL,
nota_redacao Decimal (2,2) NOT NULL,
acertos_vestibular INT NOT NULL,
FOREIGN KEY (cod_curso) REFERENCES curso(cod_curso),
FOREIGN KEY (cep) REFERENCES endereco(cep));

---3.2 TABELA professor e Inserts de Professor
SELECT * FROM professor;

DROP TABLE IF EXISTS professor CASCADE;
CREATE TABLE professor (
registro_prof INT PRIMARY KEY,
nome_prof VARCHAR(100) NOT NULL,
cpf VARCHAR(11) NOT NULL,
data_nasc DATE NOT NULL,
genero VARCHAR(15) CHECK (genero IN('Masculino','Feminino')),
email VARCHAR(32) NOT NULL, 
cod_curso CHAR(6) NOT NULL,
cep CHAR(8) NOT NULL,
FOREIGN KEY (cod_curso) REFERENCES curso(cod_curso), 
FOREIGN KEY (cep) REFERENCES endereco(cep));

--3.4 Insert TABELAS PROFESSOR

SELECT * FROM professor;

INSERT INTO professor VALUES
(184844018,'Daniel Souza','94439353681','1990-09-12','Masculino','daniel57@terra.com.br','ADS6',2929670),
(149971906,'Carlos Azevedo','66456375517','1987-04-17','Masculino','carlos42@gmail.com','ADS6',1077375),
(144630033,'Jessica Silva','88065183727','1976-12-07','Feminino','jessica7@outlook.com.br','ADS6',5526601),
(112003108,'Igor Azevedo','85431001000','1971-04-21','Masculino','igor48@gmail.com','ADS6',5115132),
(122571498,'João Guadagnino','67412857681','1970-06-08','Masculino','joão45@msn.com.br','ADS6',1318103),
(136231346,'Maike Pereira','65202810342','1996-01-12','Masculino','maike18@msn.com','MBI6',5476761),
(169314036,'Juliana Goes','28675220138','1974-06-13','Feminino','juliana63@msn.com.br','MBI6',1677625),
(136461622,'Henrique Silva','20117856185','1978-03-11','Masculino','henrique11@terra.com.br','MBI6',1968324),
(137046466,'Leonardo Faria','85797289911','1993-03-10','Masculino','leonardo47@outlook.com.br','MBI6',5488783),
(101991020,'Lucas Neto','86428166780','2004-07-20','Masculino','lucas24@yahoo.com','GDTI6',2189927),
(145730130,'Victor Corrêa','67757766320','1987-08-25','Masculino','victor38@uol.com','GDTI6',5606558),
(182534872,'Fernanda Rubim','52755734566','1988-09-12','Feminino','fernanda7@terra.com','GDTI6',4831552),
(196817236,'Daniel Costa','72165205646','1980-02-10','Masculino','daniel36@yahoo.com','SEC6',5751957),
(147224138,'Thayane Resende','67268234872','1989-10-07','Feminino','thayane57@gmail.com.br','SEC6',1713238),
(124219266,'Jonatas Essaber','26247358601','1998-08-23','Masculino','jonatas15@msn.com','SEC6',3646124),
(110010818,'Silvio Provenzano','24716500233','1978-11-02','Masculino','silvio42@hotmail.com','SEC6',4111960),
(154676795,'Myllena Corrêa','84511313520','1980-11-25','Feminino','myllena7@yahoo.com','RDS8',4803986),
(198060408,'Natali Rangel','48758453083','1976-08-22','Feminino','natali63@terra.com','RDS8',2683518),
(146639152,'William Mendonça','66630181751','1970-04-13','Masculino','william27@msn.com','RDS8',5744302),
(143511500,'Gustavo Guimarães','40558810020','1976-03-10','Masculino','gustavo46@msn.com.br','RDS8',5856565);


--INSERT endereco ALUNO e ALUNOS com suas disciplinas
SELECT * FROM aluno;

INSERT INTO endereco VALUES
('2169540','8987','Rua dos Ipês'),
('3334806','6153','Avenida dos Girassóis'),
('5445813','2725','Rua das Rosas'),
('5509066','140','Avenida dos Pinheiros'),
('1269987','455','Rua das Violetas'),
('2964922','8688','Avenida das Magnólias'),
('5322231','906','Rua dos Lírios'),
('4766454','5188','Avenida das Palmeiras'),
('3107083','1121','Rua das Orquídeas'),
('5478279','4140','Avenida dos Flamboyants'),
('4181912','5758','Rua das Begônias'),
('3228833','1360','Avenida das Bromélias'),
('1799110','9513','Rua dos Jasmim'),
('4866971','3710','Avenida dos Jacarandás'),
('3218292','3229','Rua das Hortênsias'),
('4228779','8193','Avenida das Tulipas'),
('3960540','9646','Rua dos Cravos'),
('3114033','3777','Avenida das Azaleias'),
('3539965','6708','Rua dos Gerânios');


INSERT INTO ALUNO VALUES
(203850289, 'Gustavo Alves', '13892678957', '1972-12-02', 'Masculino', 'gustavo.alves@yahoo.com.br', '2169540' , 'ADS6'),
(203527616, 'Camila Ribeiro', '55142973800', '1995-03-03', 'Feminino', 'camila_ribeiro@outlook.com', '3334806' , 'ADS6'),
(203262511, 'Thiago Lima', '20232276586', '1978-03-20', 'Masculino', 'thiago.lima@bol.com', '5445813' , 'ADS6'),
(203225781, 'Maria Fernandes', '11341265204', '1997-09-13', 'Feminino', 'mariafernandes@hotmail.com', '5509066' , 'ADS6'),
(203932125, 'Gabriel Santos', '86123698410', '2003-03-18', 'Masculino', 'gabriel.santos@protonmail.com', '1269987' , 'ADS6'),
(203780135, 'Luana Oliveira', '52648146091', '1981-10-08', 'Feminino', 'luana.oliveira@ig.com.br', '2964922' , 'ADS6'),
(203900597, 'Bruno Costa', '16897564351', '1978-03-17', 'Masculino', 'brunocosta@terra.com.br', '5322231' , 'ADS6'),
(203499962, 'Vanessa Rodrigues', '73978432108', '1977-04-01', 'Feminino', 'vanessa.rodrigues@uol.com', '4766454' , 'ADS6'),
(203997819, 'Matheus Carvalho', '90143125699', '1990-12-18', 'Masculino', 'matheus.carvalho@gmx.com', '3107083' , 'ADS6'),
(203922408, 'Carolina Souza', '44138654203', '1999-09-08', 'Feminino', 'carolina.souza@yandex.com', '5478279' , 'ADS6'),
(203130391, 'Rodrigo Pereira', '67384521957', '2000-03-21', 'Masculino', 'rodrigopereira@live.com', '4181912' , 'ADS6'),
(203211685, 'Juliana Gomes', '32859741930', '1994-04-29', 'Feminino', 'juliana.gomes@zoho.com', '3228833' , 'ADS6'),
(203750264, 'Lucas Fernandes', '75782136490', '1987-05-06', 'Masculino', 'lucasfernandes@icloud.com', '1799110' , 'ADS6'),
(203458297, 'Amanda Silva', '17563492800', '1996-11-28', 'Feminino', 'amanda.silva@yopmail.com', '4866971' , 'ADS6'),
(203372014, 'Rafael Rocha', '39981064327', '1986-09-03', 'Masculino', 'rafael_rocha@me.com', '3218292' , 'ADS6'),
(203691201, 'Mariana Santos', '98234818709', '1982-09-19', 'Feminino', 'mari.santos@protonmail.ch', '4228779' , 'ADS6'),
(203969502, 'Felipe Oliveira', '51679308234', '2001-08-18', 'Masculino', 'felipe.oliveira@gmx.us', '3960540' , 'ADS6'),
(203764704, 'Larissa Mendes', '27934598761', '2003-04-14', 'Feminino', 'larissa.mendes@fastmail.com', '3114033' , 'ADS6');

--- 4.0 TABELA DISCIPLINA e INSERT

DROP TABLE IF EXISTS disciplina CASCADE;
CREATE TABLE disciplina (
cod_disciplina VARCHAR(25) NOT NULL PRIMARY KEY,
periodo CHAR(2) NOT NULL,
nome_disciplina VARCHAR(100) NOT NULL,
carga_horaria INT NOT NULL,
cod_curso VARCHAR(6) NOT NULL,
FOREIGN KEY (cod_curso) REFERENCES curso(cod_curso));

--- 4.1 Inserindo as disciplinas (ADS,MBI6,GDTI6,SEC6,RDS8)

INSERT INTO disciplina VALUES 
('ADS100', 'Lógica de Programação', 80, 1, null, 'ADS6'),
('ADS101', 'Algoritmos e Estrutura de Dados', 80, 1, 'ADS100', 'ADS6'),
('ADS102', 'Programação Orientada a Objetos', 80, 2, 'ADS101', 'ADS6'),
('ADS103', 'Banco de Dados', 80, 2, 'ADS102', 'ADS6'),
('ADS104', 'Desenvolvimento de Software para Web', 80, 3, 'ADS102', 'ADS6'),
('ADS105', 'Engenharia de Software', 80, 3, 'ADS102', 'ADS6'),
('ADS106', 'Programação Mobile', 80, 4, 'ADS104', 'ADS6'),
('ADS107', 'Gestão de Projetos de Software', 80, 4, 'ADS105', 'ADS6'),
('ADS108', 'Tópicos Especiais em Análise e Desenvolvimento', 80, 5, 'ADS105', 'ADS6'),
('ADS109', 'Segurança de Sistemas', 80, 5, 'ADS103', 'ADS6'),
('ADS110', 'Desenvolvimento Ágil de Software', 80, 6, 'ADS107', 'ADS6'),
('ADS111', 'Estágio Supervisionado em Análise e Desenv.', 160, 6, 'ADS110', 'ADS6');
('MBI100', 'Matemática para Negócios', 80, 1, null, 'MBI6'),
('MBI101', 'Banco de Dados', 80, 1, 'MBI100', 'MBI6'),
('MBI102', 'Mineração de Dados', 80, 2, 'MBI101', 'MBI6'),
('MBI103', 'Business Intelligence', 80, 2, 'MBI101', 'MBI6'),
('MBI104', 'Análise de Dados para Negócios', 80, 3, 'MBI102, MBI103', 'MBI6'),
('MBI105', 'Visualização de Dados', 80, 3, 'MBI104', 'MBI6'),
('MBI106', 'Estatística Avançada para Negócios', 80, 4, 'MBI104', 'MBI6'),
('MBI107', 'Modelagem de Dados para Negócios', 80, 4, 'MBI103', 'MBI6'),
('MBI108', 'Tópicos Especiais em BI e Mineração de Dados', 80, 5, null, 'MBI6');
('GES101', 'Gestão de Projetos de TI', 80, 1, NULL, 'GDTI6'),
('SIS101', 'Sistemas de Informação para Negócios', 80, 1, NULL, 'GDTI6'),
('DBA101', 'Fundamentos de Banco de Dados', 80, 2, NULL, 'GDTI6'),
('ENG101', 'Engenharia de Software', 80, 2, NULL, 'GDTI6'),
('GES201', 'Governança de TI', 80, 3, 'GES101', 'GDTI6'),
('BDAD01', 'Bancos de Dados Avançados', 80, 3, 'DBA101', 'GDTI6'),
('SEG101', 'Segurança da Informação', 80, 4, NULL, 'GDTI6'),
('ARQ101', 'Arquitetura de TI', 80, 4, 'ENG101', 'GDTI6'),
('ECO101', 'Economia e Finanças para TI', 80, 5, NULL, 'GDTI6'),
('CIB101', 'Computação em Nuvem e Infraestrutura de TI', 80, 5, 'ARQ101, BDAD01', 'GDTI6'),
('GES301', 'Estratégia Empresarial e de TI', 80, 6, 'GES201', 'GDTI6'),
('TCC01', 'Trabalho de Conclusão de Curso I', 80, 6, NULL, 'GDTI6');
('SEG101', 'Segurança da Informação', 80, 1, NULL, 'SEC6'),
('SIS101', 'Sistemas de Informação para Negócios', 80, 1, NULL, 'SEC6'),
('AUD101', 'Auditoria em Segurança da Informação', 80, 2, 'SEG101', 'SEC6'),
('FDS101', 'Forense Digital e Segurança em Redes', 80, 2, 'SEG101', 'SEC6'),
('GES201', 'Governança de TI', 80, 3, 'SIS101', 'SEC6'),
('SCS101', 'Sistemas de Controle e Segurança', 80, 3, 'AUD101', 'SEC6'),
('DPC101', 'Direito e Proteção de Dados', 80, 4, 'AUD101', 'SEC6'),
('SGR101', 'Sistemas de Gerenciamento de Riscos e Continuidade', 80, 4, 'FDS101', 'SEC6'),
('GES301', 'Estratégia Empresarial e de TI', 160, 5, 'GES201', 'SEC6'),
('TCC01', 'Trabalho de Conclusão de Curso I', 160, 6, NULL, 'SEC6');

SELECT * FROM disciplina;

--- 5.0 Matriculas

DROP TABLE IF EXISTS matricula CASCADE;
CREATE TABLE matricula (
ra INT NOT NULL,
cod_curso VARCHAR(25) NOT NULL,
semestre CHAR(2) NOT NULL,
data_matricula DATE NOT NULL,
status VARCHAR NOT NULL,
FOREIGN KEY (ra) REFERENCES aluno(ra),
FOREIGN KEY (cod_curso) REFERENCES curso(cod_curso));

-- 6.0 Provas (mudei de double para FLOAT) o programa não reconhece
-- ERROR:  there is no unique constraint matching given keys for referenced table "matricula"
--- state: 42830

DROP TABLE IF EXISTS prova CASCADE;
CREATE TABLE prova (
num_prova SERIAL PRIMARY KEY NOT NULL,
ra INT NOT NULL, 
cod_disciplina VARCHAR(25) NOT NULL,
semestre CHAR(1) NOT NULL, 
P1 INT NULL,
P2 INT NULL,
FOREIGN KEY (ra) REFERENCES aluno(ra),
FOREIGN KEY (cod_disciplina) REFERENCES disciplina(cod_disciplina));

SELECT * FROM PROVA;

select nota_tirada as P1 ,ra as Registro_aluno from prova where nota_tirada > 5;

INSERT INTO prova (ra, cod_disciplina, semestre, P1, P2) VALUES
(203618817, 'ADS100', '1', 7,7);
(203850289, 'ADS101', '1', 6, 'P1'),
(203527616, 'ADS102', '2', 10, 'P1'),
(203262511, 'ADS103', '2', 8, 'P1'),
(203225781, 'ADS104', '3', 10, 'P1'),
(203932125, 'ADS105', '3', 7, 'P1'),
(203780135, 'ADS106', '4', 6, 'P1'),
(203900597, 'ADS107', '4', 6, 'P1'),
(203499962, 'ADS108', '5', 8, 'P1'),
(203997819, 'ADS109', '5', 10, 'P1'),
(203922408, 'ADS110', '6', 6, 'P1'),
(203130391, 'ADS111', '6', 6, 'P1'),
(203211685, 'ADS100', '1', 8, 'P1'),
(203750264, 'ADS101', '1', 6, 'P1'),
(203458297, 'ADS102', '2', 8, 'P1'),
(203372014, 'ADS103', '2', 6, 'P1'),
(203691201, 'ADS104', '3', 10, 'P1'),
(203969502, 'ADS105', '3', 9, 'P1'),
(203764704, 'ADS106', '4', 9, 'P1');



--- É isso vou mandar alguém de janela já já (alguns cursos possuem disciplinas de outros cursos então é isso)

-- 7.0 Tabela AULA

DROP TABLE IF EXISTS aula CASCADE;
CREATE TABLE aula(
id_aula SERIAL NOT NULL PRIMARY KEY,
cod_disciplina VARCHAR(25) NOT NULL,
data TIMESTAMP NOT NULL, 
conteudo VARCHAR NOT NULL,
FOREIGN KEY (cod_disciplina) REFERENCES disciplina(cod_disciplina));


-- 8.0 Tabela de Turmas

DROP TABLE IF EXISTS turma CASCADE;
CREATE TABLE turma (
id_turma VARCHAR(10) PRIMARY KEY,
cod_curso VARCHAR(6) NOT NULL,
ano VARCHAR(4) NOT NULL,
semestre_sala CHAR(1) NOT NULL,
FOREIGN KEY (cod_curso) REFERENCES curso(cod_curso));

-- 8.1 Inserindo as turmas

INSERT INTO turma (id_turma, cod_curso,ano,semestre_sala)VALUES
('ADS6231','ADS6','2023','1'),
('ADS6232','ADS6','2023','2'),
('ADS6233','ADS6','2023','3'),
('ADS6234','ADS6','2023','4'),
('ADS6235','ADS6','2023','5'),
('ADS6236','ADS6','2023','6'),
('MBI6231','MBI6','2023','1'),
('MBI6232','MBI6','2023','2'),
('MBI6233','MBI6','2023','3'),
('MBI6234','MBI6','2023','4'),
('MBI6235','MBI6','2023','5'),
('MBI6236','MBI6','2023','6'),
('GDTI6231','GDTI6','2023','1'),
('GDTI6232','GDTI6','2023','2'),
('GDTI6233','GDTI6','2023','3'),
('GDTI6234','GDTI6','2023','4'),
('GDTI6235','GDTI6','2023','5'),
('GDTI6236','GDTI6','2023','6'),
('SEC6231','SEC6','2023','1'),
('SEC6232','SEC6','2023','2'),
('SEC6233','SEC6','2023','3'),
('SEC6234','SEC6','2023','4'),
('SEC6235','SEC6','2023','5'),
('SEC6236','SEC6','2023','6'),
('RDS8231','RDS8','2023','1'),
('RDS8232','RDS8','2023','2'),
('RDS8233','RDS8','2023','3'),
('RDS8234','RDS8','2023','4'),
('RDS8235','RDS8','2023','5'),
('RDS8236','RDS8','2023','6'),
('RDS8237','RDS8','2023','7'),
('RDS8238','RDS8','2023','8');

-- 8.2 Conferindo Dados da tabela

SELECT * FROM turma;

--9.0 Frquencia dos Alunos

DROP TABLE IF EXISTS frequencia CASCADE;
CREATE TABLE frequencia (
id_aula  SERIAL NOT NULL PRIMARY KEY,
ra INT NOT NULL,
cod_disciplina VARCHAR(25) NOT NULL,
frequencia_total INT NOT NULL,
FOREIGN KEY (cod_disciplina) REFERENCES disciplina(cod_disciplina),
FOREIGN KEY (ra) REFERENCES aluno(ra));


DROP TABLE IF EXISTS calendario CASCADE;
CREATE TABLE calendario(
id_calendario SERIAL PRIMARY KEY,
classi VARCHAR(10) NOT NULL,
data_aula DATE NOT NULL);

INSERT INTO calendario (classi,data_aula) VALUES
('Data1','02-08-23'),
('Data2','02-15-23'),
('Data3','02-22-23'),
('Data4','03-01-23'),
('Data5','03-08-23'),
('Data6','03-15-23'),
('Data7','03-22-23'),
('Data8','03-29-23'),
('Data9','04-05-23'),
('Data10','04-12-23'),
('Data11','04-19-23'),
('Data12','04-26-23'),
('Data13','05-03-23'),
('Data14','05-10-23'),
('Data15','05-17-23'),
('Data16','05-24-23'),
('Data17','05-31-23'),
('Data18','06-07-23'),
('Data19','06-08-23'),
('Data20','06-09-23');


CREATE TABLE aulas (
  cod_disciplina VARCHAR(10),
  semestre_ano VARCHAR(10),
  n_aula INT,
  conteudo VARCHAR(255),
  registro_prof INT,
  data DATE,
  PRIMARY KEY (cod_disciplina, semestre_ano, n_aula),
  FOREIGN KEY (cod_disciplina, semestre_ano) REFERENCES oferecimento (cod_disciplina, semestre_ano)

)

CREATE TABLE presenca (
  cod_disciplina  VARCHAR(10),
  semestre_ano VARCHAR(10),
  n_aula INT,
  ra INT,
  presente BOOLEAN,
  PRIMARY KEY (cod_disciplina, semestre_ano, n_aula, ra),
  FOREIGN KEY (cod_disciplina, semestre_ano, n_aula) REFERENCES aulas (cod_disciplina, semestre_ano, n_aula),
  FOREIGN KEY (ra) REFERENCES aluno (ra)
);



DROP TABLE aulas;
CREATE TABLE aulas (
  cod_disciplina VARCHAR(7),
  n_aula INT,
  conteudo VARCHAR(255),
  registro_prof INT,
  data DATE,
  PRIMARY KEY (cod_disciplina, n_aula),
  FOREIGN KEY (cod_disciplina) REFERENCES disciplina (cod_disciplina),
  FOREIGN KEY (registro_prof) REFERENCES professor (registro_prof)
);



CREATE TABLE oferecimento (
  cod_disciplina VARCHAR(7),  
  registro_prof INT,
  data_inicio_semestre DATE,
  dia_semana varchar(15),
  semestre_ano VARCHAR(10),
  PRIMARY KEY (cod_disciplina, semestre_ano),
  FOREIGN KEY (cod_disciplina) REFERENCES disciplina (cod_disciplina),
  FOREIGN KEY (registro_prof) REFERENCES professor (registro_prof)
);



DROP TABLE notas
CREATE TABLE notas (
  cod_disciplina VARCHAR(10),
  ra INT, 
  n_prova INT,
  nota_tirada DECIMAL(5,2),
  semestre_ano VARCHAR(10),
  PRIMARY KEY (cod_disciplina, semestre_ano, ra, n_prova),
  FOREIGN KEY (cod_disciplina, semestre_ano) REFERENCES oferecimento (cod_disciplina, semestre_ano),
  FOREIGN KEY (ra) REFERENCES aluno (ra)
);


--- POPULAR algumas tabelas

SELECT * FROM aula, frequencia;
SELECT * FROM disciplina WHERE cod_curso = 'GDTI6' and periodo = '4';

-- USEM A PLANILHA COM AS INFORMAÇÕES


