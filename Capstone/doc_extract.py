import re
import pymysql.cursors

conn = pymysql.connect(host='localhost',
                       user='root',
                       password='tmddus96',
                       db='Capstone',
                       charset='utf8')
curs = conn.cursor()

sql_insert = """insert into doc_1(environment, channel, ch_bw)
                values (%s, %s, %s)"""

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
    # input_file_name = open('capstone.txt',"r",encoding='UTF8')
    # output_file_name = open("output.txt", 'w')

    with open('capstone.txt', "r+", encoding='UTF8') as input_file:
        for index in range(file_len('capstone.txt')):
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
                                    else:
                                        save_channel = lines[i + 1]
                                        if lines[i + 2].find('H') != -1:
                                            save_channel += lines[i + 2]
                                if ch_BW in lines[i]:
                                    check_environment = True
                                    index = save_index
                                    extracted_channel.append(save_channel)
                                    count_channel += 1
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
                                        save_channel = lines[i + 2]
                                        if lines[i + 3].find('H') != -1:
                                            save_channel += lines[i + 3]
                                    else:
                                        save_channel = lines[i + 1]
                                        if lines[i + 2].find('H') != -1:
                                            save_channel += lines[i + 2]
                                if ch_BW in lines[i]:
                                    check_environment = True
                                    index = save_index
                                    extracted_channel.append(save_channel)
                                    count_channel += 1
                                    break
                        if check_finish:
                            index = save_index
                            break

                    if check_environment:
                        if lines[index + 1].find('TS') != -1:
                            count_environment += 1
                            extracted_environment.append(lines[index])
                        else:
                            count_environment += 1
                            extracted_environment.append(lines[index + 1])

    with open('capstone.txt', "r+", encoding='UTF8') as input_file:
        copy = False
        # pattern = 'MHz$'

        for index in range(file_len('capstone.txt')):
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
                    count_mhzs += 1
                    save_mhz = ""
                    save_i = i
                    while True:
                        i += 1
                        if mhzs_match[i + 1] != "aaaaaaaaaaaaaaaaaa":
                            save_mhz += mhzs_match[i]
                            save_mhz += " "
                        else:
                            i = save_i
                            break
                    extracted_mhz.append(save_mhz)
            else:
                count_mhzs += 1
                extracted_mhz.append(mhzs_match[i + 1])

    print(extracted_environment)
    print("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++")
    print(extracted_channel)
    print("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++")
    print(extracted_mhz)

    n = len(extracted_mhz)
    for i in range(0, n):
        curs.execute(sql_insert, (extracted_environment[i], extracted_channel[i], extracted_mhz[i]))
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
