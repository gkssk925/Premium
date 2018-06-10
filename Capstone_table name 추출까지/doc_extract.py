import re
from operator import eq
import pymysql.cursors

conn = pymysql.connect(host='localhost',
                       user='root',
                       password='tmddus96',
                       db='Capstone',
                       charset='utf8')
curs = conn.cursor()

sql_insert = """insert into doc_combine(table_name, environment, channel, ch_bw)
                values (%s, %s, %s, %s)"""

def file_len(fname):
    with open(fname, encoding='UTF8') as f:
        for i, l in enumerate(f):
            pass
    return i + 1


def main():
    test_environment = "Test Environment"
    test_channel = "Test Channel"
    ch_BW = "Ch BW"
    connect_the_SS = "Connect the SS"
    note_1 = "Note 1:"
    table = "Table"
    test_procedure = "Test procedure"

    MHz = "MHz"
    index = 0
    save_index = 0
    copy_line = 0
    count_mhzs = 1
    count_environment = 1
    count_channel = 1
    extracted_environment = []
    extracted_channel = []
    extracted_mhz = []
    mhzs_match = []
    table_name = []

    with open('capstone_combine.txt', "r+", encoding='UTF8') as input_file:
        for index in range(file_len('capstone_combine.txt')):
            lines = input_file.readlines()
            for line in lines:
                index += 1
                if test_environment in line:
                    save_index = index
                    check_environment = False
                    check_finish = False
                    while True:
                        index += 1
                        if connect_the_SS in lines[index]:
                            check_finish = True
                            set_range = range(save_index, index)
                            for i in set_range:
                                if test_channel in lines[i]:
                                    if lines[i].find('TS') != -1:
                                        save_channel = lines[i + 2]
                                        if lines[i + 3].find('H') != -1:
                                            save_channel += lines[i + 3]
                                    elif lines[i + 1].find('TS') != -1:
                                        save_channel = lines[i + 2]
                                        if lines[i + 3].find('H') != -1:
                                            save_channel += lines[i + 3]
                                    """else:
                                        save_channel = lines[i + 1]
                                        if lines[i + 2].find('H') != -1:
                                            save_channel += lines[i + 2]"""
                                if ch_BW in lines[i]:
                                    check_environment = True
                                    index = save_index
                                    #extracted_channel.append(count_channel)
                                    count_channel += 1
                                    #extracted_channel.append(index)

                                    if save_channel.find('See') != -1:
                                        #print(save_channel.split(' '))
                                        save_table = save_channel.split(' ')[2].split('\n')[0]
                                        #print(save_table)
                                        n = len(table_name)

                                        for i in range(0, n):
                                            if save_table == table_name[i]:
                                                extracted_channel.append(extracted_channel[i])
                                    else:
                                        extracted_channel.append(save_channel)

                                    break

                        if note_1 in lines[index]:
                            check_finish = True
                            set_range = range(save_index, index)
                            for i in set_range:
                                if test_channel in lines[i]:
                                    if lines[i].find('TS') != -1:
                                        save_channel = lines[i + 2]
                                        if lines[i + 3].find('H') != -1:
                                            save_channel += lines[i + 3]
                                    elif lines[i + 1].find('TS') != -1:
                                        if lines[i + 2].find(')') != -1:
                                            save_channel = lines[i + 3]
                                            if lines[i + 4].find('H') != -1:
                                                save_channel += lines[i + 4]
                                        else:
                                            save_channel = lines[i + 2]
                                            if lines[i + 3].find('H') != -1:
                                                save_channel += lines[i + 3]
                                    """else:
                                        save_channel = lines[i + 1]
                                        if lines[i + 2].find('H') != -1:
                                            save_channel += lines[i + 2]"""
                                if ch_BW in lines[i]:
                                    check_environment = True
                                    index = save_index
                                    #extracted_channel.append(count_channel)
                                    count_channel += 1
                                    #extracted_channel.append(index)
                                    if save_channel.find('See') != -1:
                                        #print(save_channel.split(' '))
                                        save_table = save_channel.split(' ')[2].split('\n')[0]
                                        #print(save_table)
                                        n = len(table_name)

                                        for i in range(0, n):
                                            if save_table == table_name[i]:
                                                extracted_channel.append(extracted_channel[i])
                                    else:
                                        extracted_channel.append(save_channel)
                                    break

                        if test_procedure in lines[index]:
                            check_finish = True
                            set_range = range(save_index, index)
                            for i in set_range:
                                if test_channel in lines[i]:
                                    if lines[i].find('TS') != -1:
                                        save_channel = lines[i + 2]
                                        if lines[i + 3].find('H') != -1:
                                            save_channel += lines[i + 3]
                                    elif lines[i + 1].find('TS') != -1:
                                        save_channel = lines[i + 2]
                                        if lines[i + 3].find('H') != -1:
                                            save_channel += lines[i + 3]
                                    """else:
                                        save_channel = lines[i + 1]
                                        if lines[i + 2].find('H') != -1:
                                            save_channel += lines[i + 2]"""
                                if ch_BW in lines[i]:
                                    check_environment = True
                                    index = save_index
                                    #extracted_channel.append(count_channel)
                                    count_channel += 1
                                    #extracted_channel.append(index)

                                    if save_channel.find('See') != -1:
                                        #print(save_channel.split(' '))
                                        save_table = save_channel.split(' ')[2].split('\n')[0]
                                        #print(save_table)
                                        n = len(table_name)

                                        for i in range(0, n):
                                            if save_table == table_name[i]:
                                                extracted_channel.append(extracted_channel[i])
                                    else:
                                        extracted_channel.append(save_channel)

                                    break

                        if check_finish:
                            index = save_index
                            break

                    if check_environment:
                        if lines[index + 1].find('TS') != -1:
                            #extracted_environment.append(count_environment)
                            #table_name.append(count_environment)
                            count_environment += 1

                            b = lines[index - 3].find('Table')
                            c = lines[index - 3].find(':')
                            d = lines[index - 3][b + 6:c]

                            if d == '':
                                b = lines[index - 4].find('Table')
                                c = lines[index - 4].find(':')
                                d = lines[index - 4][b + 6:c]
                                table_name.append(d)
                            elif d == "(network signalled value \"NS_04\")":
                                b = lines[index - 4].find('Table')
                                c = lines[index - 4].find('-->')
                                d = lines[index - 4][b + 6:c]
                                table_name.append(d)
                            else:
                                table_name.append(d)

                            if lines[index].find('See') != -1:
                                #print(lines[index].split(' ')[2])
                                save_table = save_channel.split(' ')[2].split('\n')[0]
                                n = len(table_name)
                                for i in range(0, n):
                                    if table_name[i] == save_table:
                                        extracted_environment.append(extracted_environment[i])
                            else:
                                extracted_environment.append(lines[index])

                        else:
                            if lines[index + 1].find(')') != -1:
                                #extracted_environment.append(count_environment)
                                #table_name.append(count_environment)
                                count_environment += 1

                                b = lines[index - 3].find('Table')
                                c = lines[index - 3].find(':')
                                d = lines[index - 3][b + 6:c]

                                if d == '':
                                    b = lines[index - 4].find('Table')
                                    c = lines[index - 4].find(':')
                                    d = lines[index - 4][b + 6:c]
                                    table_name.append(d)
                                elif d == "(network signalled value \"NS_04\")":
                                    b = lines[index - 4].find('Table')
                                    c = lines[index - 4].find('-->')
                                    d = lines[index - 4][b + 6:c]
                                    table_name.append(d)
                                else:
                                    table_name.append(d)

                                if lines[index + 2].find('See') != -1:
                                    #print(lines[index + 2].split(' ')[2])
                                    save_table = lines[index + 2].split(' ')[2].split('\n')[0]
                                    n = len(table_name)
                                    for i in range(0, n):
                                        if table_name[i] == save_table:
                                            extracted_environment.append(extracted_environment[i])
                                else:
                                    extracted_environment.append(lines[index + 2])

                            else:
                                #extracted_environment.append(count_environment)
                                #table_name.append(count_environment)
                                count_environment += 1

                                b = lines[index - 3].find('Table')
                                c = lines[index - 3].find(':')
                                d = lines[index - 3][b + 6:c]

                                if d == '':
                                    b = lines[index - 4].find('Table')
                                    c = lines[index - 4].find(':')
                                    d = lines[index - 4][b + 6:c]
                                    table_name.append(d)
                                elif d == "(network signalled value \"NS_04\")":
                                    b = lines[index - 4].find('Table')
                                    c = lines[index - 4].find('-->')
                                    d = lines[index - 4][b + 6:c]
                                    table_name.append(d)
                                else:
                                    table_name.append(d)

                                if lines[index + 1].find('See') != -1:
                                    #print(lines[index + 1].split(' ')[2])
                                    save_table = lines[index + 1].split(' ')[2].split('\n')[0]
                                    n = len(table_name)
                                    for i in range(0, n):
                                        if table_name[i] == save_table:
                                            extracted_environment.append(extracted_environment[i])
                                else:
                                    extracted_environment.append(lines[index + 1])

    with open('capstone_combine.txt', "r+", encoding='UTF8') as input_file:
        copy = False
        # pattern = 'MHz$'

        for index in range(file_len('capstone_combine.txt')):
            lines = input_file.readlines()
            for line in lines:
                if ch_BW in line:
                    copy = True
                    mhzs_match.append(count_mhzs)
                    count_mhzs += 1
                    mhzs_match.append("aaaaaaaaaaaaaaaaaa")
                if copy:
                    m = re.findall(r"(\w+\.\w+|\w+|\w+\.\w+\s|\w+\s)MHz$", line)
                    if not m:
                        pass
                    else:
                        str_m = ''.join(m) + "MHz"
                        mhzs_match.append(str_m)
                if connect_the_SS in line:
                    copy = False
                if note_1 in line:
                    copy = False
                if table in line:
                    copy = False

    n = len(mhzs_match)
    count_mhzs = 1
    print(n)
    for i in range(0, n):
        if mhzs_match[i] == "aaaaaaaaaaaaaaaaaa":
            if i + 2 < n:
                if mhzs_match[i + 2] != "aaaaaaaaaaaaaaaaaa":
                    #extracted_mhz.append(count_mhzs)
                    count_mhzs += 1
                    save_mhz = ""
                    save_i = i
                    while True:
                        i += 1
                        if i + 1 == n:
                            save_mhz += mhzs_match[i]
                            break
                        elif mhzs_match[i + 1] != "aaaaaaaaaaaaaaaaaa":
                            save_mhz += mhzs_match[i]
                            save_mhz += " "
                        else:
                            i = save_i
                            break
                    extracted_mhz.append(save_mhz)
            else:
                #extracted_mhz.append(count_mhzs)
                count_mhzs += 1
                extracted_mhz.append(mhzs_match[i + 1])
#
## Hyojin Kim
#
    for i in range(len(extracted_mhz)):
        mhz_only = ''
        mhz_num_only = ''
        min_mhz_num = 0
        k = 0
        if i % 2 == 1:
            mhz_only = extracted_mhz[i]
            mhz_num_only = re.findall(r"[-=]?\d*\.\d+|\d+", mhz_only)   # mhz_num_only is type 'list'
            min_mhz_num = min(mhz_num_only, key=float)
            max_mhz_num = max(mhz_num_only, key=float)
            if i % 2 == 1:
                min_mhz.append(int((i+1)/2))
                min_mhz.append(min_mhz_num)
                max_mhz.append(int((i+1)/2))
                max_mhz.append(max_mhz_num)

    cond_matched_mhz = extracted_channel 
    
    for i in range(len(cond_matched_mhz)):
        if i % 2 == 1:
            words = cond_matched_mhz[i].split()
            if any(lowest in s for s in words):
                cond_matched_mhz[i] = cond_matched_mhz[i].replace('Lowest', min_mhz[i]+'MHz')
            if any(highest in s for s in words):
                cond_matched_mhz[i] = cond_matched_mhz[i].replace('Highest', max_mhz[i]+'MHz')

#
##
#
    print(extracted_environment)
    print("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++")
    print(extracted_channel)
    print("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++")
    print(extracted_mhz)
    print("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++")
    print(cond_matched_mhz)
    print("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++")
    print(table_name)

    n = len(extracted_mhz)

    print(len(extracted_environment))
    print(len(extracted_channel))
    print(len(extracted_mhz))
    print(len(table_name))
    for i in range(0, n):
        curs.execute(sql_insert, (table_name[i], extracted_environment[i], extracted_channel[i], extracted_mhz[i]))
    conn.commit()
    conn.close()


'''def findMHz():
    file = open('C:\\Users\\Administrator\\Desktop\\first.txt',"r",encoding='UTF8')
    lines = file.readlines()
    file.close()
    i=0
    indexNo=0
    global str
    for line in lines:
        while i==len(line):
            indexNo=line.find('MHz',indexNo+1)
            str[i]=indexNo
            i=i+1


    for a in str:
        print(a)


findMHz()
'''
main()
