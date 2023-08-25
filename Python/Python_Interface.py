#import PySimpleGUI as bolinho
import psycopg2
import pandas as pd

host = 'unictec.postgres.database.azure.com'
dbname = 'postgres'
user = 'bolinho'
password = 'abacaxi123!'
port = '5432'
sslmode = 'require'

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

def consulta(sql):
    con = conecta_db()
    cur = con.cursor()
    cur.execute(sql)
    recset = cur.fetchall()
    con.close()
    return recset

dados = [['dados']]
df = pd.DataFrame(dados)

consultar=1

while consultar==1:
    teste=input("Digite o comando em SQL")
    resultados = consulta(teste) 
    for registro in resultados:
        print(registro)
    consultar=input("Deseja fazer uma nova consulta? Pressione 1")
breakpoint



#def menu():
#menu(teste)



#df_bd = pd.DataFrame( columns=['Registro Academico','Nome','CPF',
#                                   'Data Nascimento','Genêro',
#                                  'Email','CEP',
#                                    'Cod_Curso'])
#df_bd.head()
#bolinho.Window(title='What Happen', layout =[[]], margins=(100,50)).read()
