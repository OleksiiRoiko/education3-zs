import matplotlib.pyplot as plt
import matplotlib.patches as patches

board_width = 17
board_height = 9

shapes = {
    'i2': {'width': 1, 'height': 2, 'x': 332.0/35.0, 'y': 0},
    'h2': {'width': 2, 'height': 1, 'x': 373.0/35.0, 'y': 46.0/35.0},
    'g1': {'width': 2, 'height': 2, 'x': 15.0, 'y': 1.0/10.0},
    'g2': {'width': 2, 'height': 2, 'x': 741.0/70.0, 'y': 169.0/70.0},
    'f1': {'width': 4, 'height': 1, 'x': 373/35, 'y': 0.0},
    'b1': {'width': 4, 'height': 4, 'x': 76.0/35.0, 'y': 321.0/70.0},
    'd1': {'width': 4, 'height': 2, 'x': 893.0/70.0, 'y': 87.0/35.0},
    'e2': {'width': 2, 'height': 4, 'x': 1033.0/70.0, 'y': 163.0/35.0},
    'c1': {'width': 8, 'height': 2, 'x': 222.0/35.0, 'y': 7.0},
    'd2': {'width': 4, 'height': 2, 'x': 222.0/35.0, 'y': 158.0/35.0},
    'e1': {'width': 2, 'height': 4, 'x': 0.0, 'y': 146.0/35.0},
    'h1': {'width': 2, 'height': 1, 'x': 449.0/35.0, 'y': 41.0/35.0},
    'i1': {'width': 1, 'height': 2, 'x': 291.0/35.0, 'y': 6.0/35.0},
    'f2': {'width': 4, 'height': 1, 'x': 741.0/70.0, 'y': 163.0/35.0},
    'a1': {'width': 8, 'height': 4, 'x': 1.0/7.0, 'y': 0.0},
    'g3': {'width': 2, 'height': 2, 'x': 589.0/70.0, 'y': 82.0/35.0},
    'f3': {'width': 4, 'height': 1, 'x': 368.0/35.0, 'y': 204.0/35.0},
}


fig, ax = plt.subplots()

for shape, properties in shapes.items():
    rect = patches.Rectangle(
        (properties['x'], properties['y']),
        properties['width'],
        properties['height'],
        linewidth=1,
        edgecolor='black',
        facecolor='none',
        label=shape
    )
    ax.add_patch(rect)
    ax.text(
        properties['x'] + properties['width'] / 2,
        properties['y'] + properties['height'] / 2,
        shape,
        ha='center',
        va='center'
    )

ax.set_xlim(0, board_width)
ax.set_ylim(0, board_height)
ax.set_xlabel('Width')
ax.set_ylabel('Height')
ax.set_title('Shape Placement on Board')

plt.gca().set_aspect('equal', adjustable='box')
plt.show()
