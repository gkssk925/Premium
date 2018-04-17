import pymysql.cursors

conn = pymysql.connect(host='localhost',
                       user='root',
                       password='tmddus96',
                       db='Capstone',
                       charset='utf8mb4')

try:
    with conn.cursor() as cursor:
        sql = '''
        CREATE TABLE doc_combine (
         table_name text NOT NULL,
         environment text NOT NULL,
         channel text NOT NULL,
         ch_bw text NOT NULL )
        '''
        cursor.execute(sql)
    conn.commit()

finally:
    conn.close()