#!/usr/bin/env python3

import sys
import os

def is_plt_line(line):
    return ('<' in line and '>:' in line)

def is_remind_line(line):
    return "plt:" in line

def extract_plt_function(line):
    if '<' in line and '>:' in line:
        start = line.find('<')
        end = line.find('>:')
        return line[start:end+1].strip()
    return None

def simple_compare(file1, file2, output_file):
    try:
        with open(file1, 'r') as f1, open(file2, 'r') as f2:
            lines1 = f1.readlines()
            lines2 = f2.readlines()
    except FileNotFoundError as e:
        print(f"Error: {e}")
        return
    
    label1 = os.path.splitext(os.path.basename(file1))[0]
    label2 = os.path.splitext(os.path.basename(file2))[0]
    label_out1 = label1.split("_")[1]
    label_out2 = label2.split("_")[1]
    
    with open(output_file, 'w') as out_f:
        out_f.write(f"Comparison of {label1} and {label2}\n")
        out_f.write("=" * 60 + "\n\n")
        start_i = ""
        start_j = ""
        prev_i = ""
        prev_j = ""
        i = 1
        j = 1
        count_i = 0
        count_j = 0
        skip_list = []
        prev_line1 = ""
        prev_line2 = ""
        remind_i = ""
        remind_j = ""
        remind_count_i = 0
        remind_count_j = 0
        print(len(lines1),len(lines2))
        while i < len(lines1) or j < len(lines2):
            line1 = lines1[i].rstrip() if i < len(lines1) else ""
            line2 = lines2[j].rstrip() if j < len(lines2) else ""
            if is_plt_line(line1):
                tmp1 = extract_plt_function(line1)
                if tmp1 != start_i and tmp1 not in skip_list:
                    prev_i = start_i
                    start_i = tmp1
                    count_i += 1
                    print(count_i,count_j,f"{label_out1}: {start_i}")
                    if count_i == count_j and start_i != start_j:
                        count_j -= 1
                        skip_list.append(start_j)
                        start_j = prev_j
                        print(f"Decrease j, count: ({count_i},{count_j}), ({start_i},{start_j})")
            if is_plt_line(line2):
                tmp2 = extract_plt_function(line2)
                if tmp2 != start_j and tmp2 not in skip_list:
                    prev_j = start_j
                    start_j = tmp2
                    count_j += 1
                    print(count_i,count_j,f"{label_out2}: {start_j}")
                    if count_i == count_j and start_i != start_j:
                        count_i -= 1
                        skip_list.append(start_i)
                        start_i = prev_j
                        print(f"Decrease i, count: ({count_i},{count_j}), ({start_i},{start_j})")
            if is_remind_line(line1):
                remind_i = line1
                remind_count_i += 1
                print("[REMIND]",count_i,count_j,f"{label_out1}: {start_i}")
            if is_remind_line(line2):
                remind_j = line2
                remind_count_j += 1
                print("[REMIND]",count_i,count_j,f"{label_out2}: {start_j}")
            if line1 != line2:
                if line1:
                    if not is_plt_line(line1) and not is_remind_line(line1) and line1 != prev_line1:
                        out_f.write(f"line {i}, {label_out1}: {line1}\n")
                    elif is_plt_line(line1) and line1 in skip_list:
                        out_f.write(f"\nline {i}, {label_out1}: {line1}\n")
                    elif is_plt_line(line1) and start_i == start_j:
                        out_f.write(f"\nline {i}, {label_out1}: {line1}\n")
                if line2:
                    if not is_plt_line(line2) and not is_remind_line(line2) and line2 != prev_line2:
                        out_f.write(f"line {j}, {label_out2}: {line2}\n")
                    elif is_plt_line(line2) and line2 in skip_list:
                        out_f.write(f"line {j}, {label_out2}: {line2}\n")
                    elif is_plt_line(line2) and start_i == start_j:
                        out_f.write(f"line {j}, {label_out2}: {line2}\n")
                    elif is_remind_line(line2) and remind_i == remind_j:
                        out_f.write(f"\nline {i}, {label_out1}: {remind_i}\n")
                        out_f.write(f"line {j}, {label_out2}: {remind_j}\n")
            if remind_count_i + remind_count_j == 1:
                print("!!!!!!!!!",i,j,line1,line2)
            if i < len(lines1) and j < len(lines2):
                if count_i == count_j:
                    i += 1
                    j += 1
                elif count_i < count_j:
                    i += 1
                elif count_i > count_j:
                    j += 1
            elif i < len(lines1):
                    i += 1
            elif j < len(lines2):
                    j += 1
            prev_line1 = line1
            prev_line2 = line2

def main():
    if len(sys.argv) != 3:
        print(f"Usage: python {sys.argv[0]} <file1> <file2>")
        print(f"Example: python {sys.argv[0]} vec_launcher.txt origin_launcher.txt")
        sys.exit(1)
    
    file1 = sys.argv[1]
    file2 = sys.argv[2]
    output_file = "diff.txt"
    
    simple_compare(file1, file2, output_file)

if __name__ == "__main__":
    main()
