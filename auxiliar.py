from flask import Flask, jsonify, request
import psycopg2
import pandas as pd
import random


#credenciais de conexão
host = 'unictec.postgres.database.azure.com'
dbname = 'postgres'
user = 'bolinho'
password = 'abacaxi123!'
port = '5432'
sslmode = 'require'

#criando conexão com o banco
def conecta_db():
    conn = psycopg2.connect(
        host=host,
        database=dbname,
        user=user,
        password=password,
        port=port,
        sslmode=sslmode
    )
    return conn


#consulta global
def consulta(sql):
    con = conecta_db()
    cur = con.cursor()
    cur.execute(sql)
    recset = cur.fetchall()
    con.close()
    return recset


#insert global


def inserir_dados(sql, values):
    con = conecta_db()
    cur = con.cursor()
    cur.execute(sql, values)
    con.commit()
    con.close()




#get de cod_disciplina
def listaDisciplinas(cod_curso,periodo):
  sql = "select * from disciplina where cod_curso = '{}' and periodo ='{}'".format(cod_curso, periodo)
  disciplinas = consulta(sql)
  lista = []
  for disciplina in disciplinas:
      lista.append(disciplina[0])

  return lista

#get de RAs
def listaRa(cod_curso):
  sql = "select * from aluno where cod_curso = '{}' limit 40".format(cod_curso)
  alunos = consulta(sql)
  lista = []
  for aluno in alunos:
      lista.append(aluno[0])

  return lista



#get de RAs
def listaProfsByCurso(cod_curso):
  sql = "select * from professor where cod_curso = '{}'".format(cod_curso)
  profs = consulta(sql)
  lista = []
  for prof in profs:
      lista.append(prof[0])

  return lista


#gerador de provas
def insert_provas_data(disciplinas, alunos_ra, num_prova):
    semestre_ano = '2023.1'
    for alunos_ra_value in alunos_ra:
      for disciplina in disciplinas:

        nota = round(random.uniform(0, 10), 1)
        sql = "INSERT INTO notas (cod_disciplina, ra , n_prova, nota_tirada, semestre_ano) " \
              "VALUES (%s, %s, %s, %s, %s)"
        values = (disciplina, alunos_ra_value, num_prova , nota, semestre_ano)
        inserir_dados(sql, values)
        
        
             
#gerador de presenca
def insert_presenca_data(disciplinas, alunos_ra, num_aula):
    semestre_ano = '2023.1'
    for alunos_ra_value in alunos_ra:
      for disciplina in disciplinas:

        presente = random.choices([True, False], [0.70, 1 - 0.70])[0]
        sql = "INSERT INTO presenca (cod_disciplina, semestre_ano, ra , n_aula, presente) " \
              "VALUES (%s, %s, %s, %s, %s)"
        values = (disciplina, semestre_ano, alunos_ra_value, num_aula , presente)
        inserir_dados(sql, values)



def insert_oferecimento_data(disciplinas, profs_registro):
  dias_da_semana = ["Segunda-feira", "Terça-feira", "Quarta-feira", "Quinta-feira", "Sexta-feira"]

  for i in range(5):
    semestre_ano = "2023.1"    
    data_inicio_semestre = '01-01-2023'
    sql = "INSERT INTO oferecimento (cod_disciplina, registro_prof,data_inicio_semestre, dia_semana, semestre_ano) " \
          "VALUES (%s, %s, %s, %s, %s)"
    values = (disciplinas[i],  profs_registro[i], data_inicio_semestre, dias_da_semana[i], semestre_ano)
    inserir_dados(sql, values)
    
    
    

def insert_oferecimento_data(disciplinas, profs_registro):
  dias_da_semana = ["Segunda-feira", "Terça-feira", "Quarta-feira", "Quinta-feira", "Sexta-feira"]

  for i in range(5):
    semestre_ano = "2023.1"    
    data_inicio_semestre = '01-01-2023'
    sql = "INSERT INTO oferecimento (cod_disciplina, registro_prof,data_inicio_semestre, dia_semana, semestre_ano) " \
          "VALUES (%s, %s, %s, %s, %s)"
    values = (disciplinas[i],  profs_registro[i], data_inicio_semestre, dias_da_semana[i], semestre_ano)
    inserir_dados(sql, values)




import datetime

def gerar_aulas_datas():
  
  data_atual = datetime.date(2023, 2, 20)
  semestre_ano = "2023.1"
  
  ofrs  = [
    'MBI100',
    'MBI101',
    'MBI102',
    'MBI103',
    'MBI104',
    'ADS100',
    'ADS101',
    'ADS102',
    'ADS103',
    'ADS104',
    'GDT100',
    'GDT101',
    'GDT102',
    'GDT103',
    'GDT104',
    'SEC100',
    'SEC101',
    'SEC102',
    'SEC103',
    'SEC104',
    'RD100',
    'RD101',
    'RD102',
    'RD103',
    'RD104'
]  
  
  for i in range(20):
    
    for j in range(25):
      if j % 5 == 0 and j!=0:
      # Reinicie o dia da semana
        data_atual -= datetime.timedelta(days=5)
      if data_atual.weekday() < 5:  # Verifica se não é sábado ou domingo

        sql = "INSERT INTO aulas (cod_disciplina, semestre_ano, n_aula, data_aula) " \
              "VALUES (%s, %s, %s, %s)"
        values = (ofrs[j],  semestre_ano, i, data_atual)
        inserir_dados(sql, values)
        data_atual += datetime.timedelta(days=1)
      else: 
        data_atual += datetime.timedelta(days=2)
        sql = "INSERT INTO aulas (cod_disciplina, semestre_ano, n_aula, data_aula) " \
              "VALUES (%s, %s, %s, %s)"
        values = (ofrs[j],  semestre_ano, i, data_atual)
    
      
      
      
      
def gerar_aulas_datas2():
    data_atual = datetime.date(2023, 2, 20)
    semestre_ano = "2023.1"
    ofrs = consulta("SELECT cod_disciplina FROM oferecimento")

    for i, discp in enumerate(ofrs, start=1):
        if i % 5 == 1:
            dia_semana = data_atual.weekday()

        if dia_semana < 5:  # Verifica se não é sábado ou domingo
            sql = "INSERT INTO aulas (cod_disciplina, semestre_ano, n_aula, data_aula) " \
                  "VALUES (%s, %s, %s, %s)"
            values = (discp[0], semestre_ano, i, data_atual)
            inserir_dados(sql, values)

        data_atual += datetime.timedelta(days=1)


      
  
      
# gerar_aulas_datas()

def gerar_aulas_datas3():   
  data_atual = datetime.date(2023, 2,27)  # Data inicial
  cod_disciplina = 'ADS100'
  semestre_ano = '2023.1'
  n_aula = 1
  conteudo = None
  for i in range(19):
    sql = "INSERT INTO aulas (cod_disciplina, semestre_ano, n_aula, conteudo, data_aula) " \
          "VALUES (%s, %s, %s, %s, %s)"
    values = (cod_disciplina, semestre_ano, n_aula, conteudo, data_atual)
    inserir_dados(sql, values)

    data_atual += datetime.timedelta(days=7)  # Adiciona 7 dias à data atual

    n_aula += 1 

# gerar_aulas_datas3()


# registros = listaProfsByCurso('RDS8')

# print(registros)


discip = listaDisciplinas('RDS8', '1')
ras = listaRa('RDS8')

print(ras)
print(discip)


# for i in range(20):
#  insert_presenca_data(discip, ras, i)



# insert_oferecimento_data(discip, registros)
