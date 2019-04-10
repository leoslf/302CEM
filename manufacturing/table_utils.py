def max_col(cols, rows):
    ret = []
    tbl = list([cols])
    tbl.extend(list(rows))
    tbl_T = map(list,  zip(*tbl))
    for c in tbl_T:
        ret.append(len(max((str(s) for s in c), key=len)))
    return ret

