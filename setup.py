# from ez_setup import use_setuptools
# use_setuptools()

from setuptools import setup, find_packages


entry_points = """
[cosmoscope.plugin]
qml=qml_client:start
"""

setup(
    name='qml-client',
    version='0.1.0',
    packages=find_packages(),
    include_package_data=True,
    url='https://github.com/cosmoscope/cosmos-client-qml',
    license='',
    author='Nicholas Earl',
    author_email='contact@nicholasearl.me',
    description='Front-end qml interface for interacting with the cosmoscope server',
    entry_points=entry_points,
    install_requires=['msgpack-python', 'zerorpc', 'gevent', 'qtawesome']
)
