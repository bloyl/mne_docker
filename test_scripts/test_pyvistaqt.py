import pyvista as pv
from pyvistaqt import BackgroundPlotter
import sys

sphere = pv.Sphere()
plotter = BackgroundPlotter()
plotter.add_mesh(sphere)
tmp = plotter.screenshot(filename=sys.argv[1])
print(f'min:{tmp.min()} - max:{tmp.max()}')
