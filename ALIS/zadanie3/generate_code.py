shapes = {
    'a': {'width': 8, 'height': 4, 'count': 1},
    'b': {'width': 4, 'height': 4, 'count': 1},
    'c': {'width': 8, 'height': 2, 'count': 1},
    'd': {'width': 4, 'height': 2, 'count': 2},
    'e': {'width': 2, 'height': 4, 'count': 2},
    'f': {'width': 4, 'height': 1, 'count': 3},
    'g': {'width': 2, 'height': 2, 'count': 3},
    'h': {'width': 2, 'height': 1, 'count': 2},
    'i': {'width': 1, 'height': 2, 'count': 2}
}


def non_overlapping_conditions(shape1, index1, width1, height1, shape2, index2, width2, height2):
    conditions = []
    conditions.append(f"(> {shape1}x{index1} (+ {shape2}x{index2} {width2 + 0.1}))")
    conditions.append(f"(< {shape1}x{index1} (- {shape2}x{index2} {width1 + 0.1}))")
    conditions.append(f"(> {shape1}y{index1} (+ {shape2}y{index2} {height2 + 0.1}))")
    conditions.append(f"(< {shape1}y{index1} (- {shape2}y{index2} {height1 + 0.1}))")
    return " (or " + " ".join(conditions) + ")"

def generate_smt_lib(shapes, field_width=17, field_height=9):
    smt_code = ""

    for shape, info in shapes.items():
        for i in range(1, info['count'] + 1):
            smt_code += f"(declare-fun {shape}x{i} () Real)\n"
            smt_code += f"(declare-fun {shape}y{i} () Real)\n"

    smt_code += "(assert (and\n"
    for shape, info in shapes.items():
        for i in range(1, info['count'] + 1):
            max_x = field_width - info['width']
            max_y = field_height - info['height']
            smt_code += f"\t(>= {shape}x{i} 0)\n"
            smt_code += f"\t(<= {shape}x{i} {max_x})\n"
            smt_code += f"\t(>= {shape}y{i} 0)\n"
            smt_code += f"\t(<= {shape}y{i} {max_y})\n"

    for shape1, info1 in shapes.items():
        for i in range(1, info1['count'] + 1):
            for shape2, info2 in shapes.items():
                for j in range(1, info2['count'] + 1):
                    if shape1 != shape2 or i != j:
                        condition = non_overlapping_conditions(shape1, i, info1['width'], info1['height'], shape2, j, info2['width'], info2['height'])
                        smt_code += f"\t{condition}\n"

    smt_code += "))\n(check-sat)\n(get-model)\n"
    return smt_code

smt_lib_code = generate_smt_lib(shapes)
print(smt_lib_code)
