import pyvista as pv
from pyvistaqt import BackgroundPlotter  # <--- this uses Qt here

sphere = pv.Sphere()

plotter = BackgroundPlotter()
plotter.add_mesh(sphere)
plotter.screenshot('/outputs/pyvistaqt_out.png')
