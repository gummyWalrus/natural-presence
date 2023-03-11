from os import system
from sys import argv


def mv_range(i, maxi, j):
    if i > maxi:
        exit(1)

    while i < int(argv[2]):
        system(f'cp arr{"0" * (3 - len(str(i)))}{str(i)}.svg plus_{j}.svg')
        print(f'cp arr{"0" * (3 - len(str(i)))}{str(i)}.svg plus_{j}.svg')
        i += 1
        system(f'cp arr{"0" * (3 - len(str(i)))}{str(i)}.svg minus_{j}.svg')
        print(f'cp arr{"0" * (3 - len(str(i)))}{str(i)}.svg minus_{j}.svg')
        i += 1
        system(f'cp arr{"0" * (3 - len(str(i)))}{str(i)}.svg cross_{j}.svg')
        print(f'cp arr{"0" * (3 - len(str(i)))}{str(i)}.svg cross_{j}.svg')
        i += 1
        system(f'cp arr{"0" * (3 - len(str(i)))}{str(i)}.svg check_{j}.svg')
        print(f'cp arr{"0" * (3 - len(str(i)))}{str(i)}.svg check_{j}.svg')
        i += 1
        j += 1


def mv_group(groups):
    for (index, group) in enumerate(groups):
        system(f'mv minus_{index + 1}.svg {group}_minus.svg')
        system(f'mv plus_{index + 1}.svg {group}_plus.svg')
        system(f'mv cross_{index + 1}.svg {group}_cross.svg')
        system(f'mv check_{index + 1}.svg {group}_check.svg')


def rm_group(groups):
    for (index, group) in enumerate(groups):
        system(f'rm  minus_{group}.svg')
        system(f'rm plus_{group}.svg')
        system(f'rm  cross_{group}.svg')
        system(f'rm  check_{group}.svg')


mv_group(["demi", "circle", "square"])
