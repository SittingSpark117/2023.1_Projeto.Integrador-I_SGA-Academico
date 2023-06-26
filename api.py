from flask import Flask, jsonify, request
import psycopg2
import pandas as pd
from flask_cors import CORS 
import random
from datetime import date
import json


app = Flask(__name__)
CORS(app)
# Credenciais de conexão
host = 'unictec.postgres.database.azure.com'
dbname = 'postgres'
user = 'bolinho'
password = 'abacaxi123!'
port = '5432'
sslmode = 'require'


# Criando conexão com o banco
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


# Consulta global
def consulta(sql):
    con = conecta_db()
    cur = con.cursor()
    cur.execute(sql)
    recset = cur.fetchall()
    con.close()
    return recset


# Insert global
def inserir_dados(sql, values):
    con = conecta_db()
    cur = con.cursor()
    cur.execute(sql, values)
    con.commit()
    con.close()


# Rota para cadastrar alunos
@app.route('/cadastrar', methods=['POST'])
def cadastrar():
    sql = "select cep from endereco order by RANDOM() limit 1"
    cep = consulta(sql)
    
    data = request.json
    nome = str(data['nome'])
    cpf = str(data['cpf'])
    dataNascimento = data['dataNascimento']
    genero = str(data['genero'])
    email = str(data['email'])
    cep = str(cep)
    cod_curso = str(data['curso'])
    nota_redacao ="45.55"
    acertos_vestibular = 45
       
    ra = random.randrange(10**8, 10**9)

    sql = "INSERT INTO aluno (ra, nome_aluno, cpf, data_nasc, genero, email, cep, cod_curso, nota_redacao, acertos_vestibular ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"
    values = (ra, nome, cpf, dataNascimento, genero, email, cep, cod_curso, nota_redacao, acertos_vestibular)
    inserir_dados(sql, values)

    return jsonify({'message': 'Dados inseridos com sucesso!'}), 201



@app.route('/cep', methods=['GET'])
def getCep():

    sql = "select cep from endereco order by RANDOM() limit 1"
    data = consulta(sql)
    # Criar um DataFrame pandas com os dados retornados
    df = pd.DataFrame(data, columns=['nome_curso', 'cod_curso'])
    # Converter o DataFrame em JSON
    json_data = df.to_json(orient='records')
    return json_data


# Rota para ler 
@app.route('/ler', methods=['GET'])
def ler():
    sql = "SELECT nome_aluno, genero, data_nasc FROM aluno"
    data = consulta(sql)

    # Criar um DataFrame pandas com os dados retornados
    df = pd.DataFrame(data, columns=['nome_aluno', 'genero', 'data_nasc'])

    # Converter o DataFrame em JSON
    json_data = df.to_json(orient='records')
    return json_data
    
    
@app.route('/alunos', methods=['GET'])
def alunosByCurso():
    cod_curso = request.args.get('cod_curso')

    sql = "SELECT * FROM aluno WHERE cod_curso = '{}'".format(cod_curso)
    alunos = consulta(sql)
    lista = [aluno[0] for aluno in alunos]

    return jsonify(lista), 200


@app.route('/alunos-por-curso', methods=['GET'])
def listaAlunosByCurso():   

    sql = "SELECT  count(ra) as alunos, nome_curso FROM aluno as a, curso as c WHERE a.cod_curso=c.cod_curso GROUP BY nome_curso"
    lista = consulta(sql)
    df = pd.DataFrame(lista, columns=['alunos', 'nome_curso'])

    # Converter o DataFrame em JSON
    json_data = df.to_json(orient='records')
    return json_data


@app.route('/grade', methods=['GET'])
def grade():
    sql = "select nome_disciplina, periodo, carga_horaria, cod_curso from disciplina order by cod_curso, periodo, nome_disciplina"
    data = consulta(sql)

    # Criar um DataFrame pandas com os dados retornados
    df = pd.DataFrame(data, columns=['nome_disciplina', 'carga_horaria', 'periodo', 'cod_curso'])

    # Converter o DataFrame em JSON
    json_data = df.to_json(orient='records')
    return json_data

# -----------------------------------------------NOTAS CRUD--------------------------------------

# LISTA DE CURSOS QUE POSSUEM DISCIPLINA
@app.route('/cursos', methods=['GET'])
def getCursos():

    sql = "select distinct (nome_curso), c.cod_curso  from curso as c ,disciplina as d where  d.cod_curso  = c.cod_curso"
    data = consulta(sql)
    # Criar um DataFrame pandas com os dados retornados
    df = pd.DataFrame(data, columns=['nome_curso', 'cod_curso'])
    # Converter o DataFrame em JSON
    json_data = df.to_json(orient='records')
    return json_data

@app.route('/disciplinas', methods=['GET'])
def getDisciplinasByCurso():    
    
    cod_curso = request.args.get('cod_curso')
    sql = "select cod_disciplina, nome_disciplina from disciplina where cod_curso = '{}' and periodo = '1'".format(cod_curso)
    data = consulta(sql)
    # Criar um DataFrame pandas com os dados retornados
    df = pd.DataFrame(data, columns=['cod_disciplina', 'nome_disciplina'])
    # Converter o DataFrame em JSON
    json_data = df.to_json(orient='records')
    return json_data
    

@app.route('/notas-alunos', methods=['GET'])
def getNotasByCurso():
    cod_disciplina = request.args.get('cod_disciplina')
    
    sql =   "select nome_aluno, n_prova, nota_tirada " \
    "from notas as n " \
    "inner join aluno as a on n.ra = a.ra " \
    "where cod_disciplina = '{}' " \
    "order by nome_aluno, n_prova ".format(cod_disciplina)
    data = consulta(sql)

    df = pd.DataFrame(data, columns=['nome_aluno', 'n_prova','nota_tirada'])
    # Converter o DataFrame em JSON
    json_data = df.to_json(orient='records')
    return json_data


@app.route('/meidas-alunos', methods=['GET'])
def mediaByalunoByDisciplina():
    aluno = request.args.get('cod_disciplina')

    sql = "SELECT a.nome_aluno, (SUM(n.nota_tirada) - MIN(n.nota_tirada)) / (COUNT(n.nota_tirada) - 1) as media " \
        "FROM notas AS n " \
        "INNER JOIN aluno AS a ON a.ra = n.ra " \
        "INNER JOIN disciplina AS d ON d.cod_disciplina = n.cod_disciplina " \
        "WHERE d.cod_disciplina = '{}' " \
        "GROUP BY a.nome_aluno order by media desc".format(aluno)
    data = consulta(sql)

    # Criar um DataFrame pandas com os dados retornados
    df = pd.DataFrame(data, columns=['nome_aluno', 'media'])

    
    json_data = df.to_json(orient='records')
    return json_data


if __name__ == '__main__':
    app.run()
