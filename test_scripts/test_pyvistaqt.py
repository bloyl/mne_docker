import pyvista as pv
from pyvistaqt import BackgroundPlotter

sphere = pv.Sphere()

plotter = BackgroundPlotter()
plotter.add_mesh(sphere)

tmp = plotter.screenshot(filename='/outputs/pyvistaqt_out.png')
print(f'min:{tmp.min()} - max:{tmp.max()}')
