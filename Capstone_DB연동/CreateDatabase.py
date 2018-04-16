import pymysql.cursors
conn = pymysql.connect(host = 'localhost',
                       user = 'root',
                       password = 'tmddus96',
                       charset = 'utf8mb4')

try:
    with conn.cursor() as cursor:
        sql = 'CREATE DATABASE Capstone'
        cursor.execute(sql)
    conn.commit()
finally:
    conn.close()