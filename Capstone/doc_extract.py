import re


def file_len(fname):
    with open(fname, encoding='UTF8') as f:
        for i, l in enumerate(f):
            pass
    return i + 1


def main():
    test_environment = "Test Environment as specified in"
    test_frequencies = "Test Frequencies as specified in"
    test_channel = "Test Channel Bandwidths as specified in"
    ch_BW = "Ch BW"
    connect_the_SS = "Connect the SS"
    note_1 = "Note 1:"
    table = "Table"

    MHz = "MHz"
    index = 0
    count = 1
    extracted_environment = []
    extracted_channel = []
    mhzs_match = []
    all_mhzs_match = []
    test_freq_line_num = 0
    test_chan_line_num = 0
    # input_file_name = open('capstone.txt',"r",encoding='UTF8')
    # output_file_name = open("output.txt", 'w')

    with open('capstone.txt', "r+", encoding='UTF8') as input_file:
        for index in range(file_len('capstone.txt')):
            lines = input_file.readlines()
            for line in lines:
                index += 1
                if test_environment in line:
                    if test_frequencies not in lines[index + 1]:
                        extracted_environment.append(lines[index + 1])
                        test_freq_line_num = index + 1
                elif test_channel in line:
                    extracted_channel.append(lines[index + 1])
                    test_chan_line_num = index + 1

    with open('capstone.txt', "r+", encoding='UTF8') as input_file:
        copy = False
        # pattern = 'MHz$'

        for index in range(file_len('capstone.txt')):
            lines = input_file.readlines()
            for line in lines:
                if ch_BW in line:
                    copy = True
                    mhzs_match.append(count)
                    count += 1
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
        print(mhzs_match)
    # print(extracted_environment)
    # print("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++")
    # print(extracted_channel)


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

